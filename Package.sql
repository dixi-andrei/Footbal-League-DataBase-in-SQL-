CREATE OR REPLACE PACKAGE package_liga_fotbal AS
  PROCEDURE afisare_informatii_meci(p_id_meci IN NUMBER);
  PROCEDURE DetaliiJucatoriEchipa(echipa_id IN NUMBER);
  FUNCTION detalii_meci_an(id_meci_param IN NUMBER) RETURN VARCHAR2;
  PROCEDURE detalii_meci_liga_fotbal(id_meci_param IN NUMBER);
END package_liga_fotbal;
/

CREATE OR REPLACE PACKAGE BODY package_liga_fotbal AS

--------

  PROCEDURE afisare_informatii_meci(p_id_meci IN NUMBER) AS
    v_data_meci DATE;

    TYPE DetaliiEchipaTable IS TABLE OF ECHIPA%ROWTYPE;
    v_detalii_echipa DetaliiEchipaTable := DetaliiEchipaTable();

    TYPE DetaliiGolIndexByTable IS TABLE OF GOL%ROWTYPE INDEX BY PLS_INTEGER;
    v_detalii_gol DetaliiGolIndexByTable;

    TYPE DetaliiAssistVarray IS VARRAY(10) OF ASSIST%ROWTYPE;
    v_detalii_assist DetaliiAssistVarray := DetaliiAssistVarray();

  BEGIN
    SELECT data
    INTO v_data_meci
    FROM MECI
    WHERE id_meci = p_id_meci;

    SELECT e.*
    BULK COLLECT INTO v_detalii_echipa
    FROM ECHIPA e
    INNER JOIN ECHIPA_MECI em ON e.id_echipa = em.id_echipa
    WHERE em.id_meci = p_id_meci;

    SELECT g.*
    BULK COLLECT INTO v_detalii_gol
    FROM GOL g
    WHERE g.id_meci = p_id_meci;

    SELECT a.*
    BULK COLLECT INTO v_detalii_assist
    FROM ASSIST a
    WHERE a.id_meci = p_id_meci;

    DBMS_OUTPUT.PUT_LINE('Detalii meci:');
    DBMS_OUTPUT.PUT_LINE('  Data meciului: ' || TO_CHAR(v_data_meci, 'YYYY-MM-DD'));
    
    DBMS_OUTPUT.PUT_LINE('Numele echipelor care au jucat meciul:');
    FOR i IN 1..v_detalii_echipa.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('  Nume echipa: ' || v_detalii_echipa(i).nume_echipa);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Detalii gol-uri:');
    FOR i IN 1..v_detalii_gol.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('  Minut gol: ' || v_detalii_gol(i).minut_gol);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Detalii assist-uri:');
    FOR i IN 1..v_detalii_assist.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('  Minut assist: ' || v_detalii_assist(i).minut_assist);
    END LOOP;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Meciul cu ID ' || p_id_meci || ' nu exist?.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('O eroare necunoscut? a ap?rut: ' || SQLERRM);
  END afisare_informatii_meci;
  
  ----
  
  PROCEDURE DetaliiJucatoriEchipa(echipa_id IN NUMBER) AS
    CURSOR cur_jucatori IS
      SELECT id_jucator, nume_jucator, prenume_jucator, varsta, nationalitate
      FROM JUCATOR
      WHERE id_echipa = echipa_id;

    CURSOR cur_statistici_jucatori (p_id_jucator NUMBER) IS
      SELECT COUNT(*) AS nr_goluri, COUNT(DISTINCT id_assist) AS nr_asistari
      FROM GOL g
      LEFT JOIN ASSIST a ON g.id_jucator = a.id_jucator AND g.id_meci = a.id_meci
      WHERE g.id_jucator = p_id_jucator;

    v_id_jucator JUCATOR.id_jucator%TYPE;
    v_nume_jucator JUCATOR.nume_jucator%TYPE;
    v_prenume_jucator JUCATOR.prenume_jucator%TYPE;
    v_varsta JUCATOR.varsta%TYPE;
    v_nationalitate JUCATOR.nationalitate%TYPE;

    v_nr_goluri NUMBER;
    v_nr_asistari NUMBER;
  BEGIN
    OPEN cur_jucatori;
    LOOP
      FETCH cur_jucatori INTO v_id_jucator, v_nume_jucator, v_prenume_jucator, v_varsta, v_nationalitate;
      EXIT WHEN cur_jucatori%NOTFOUND;
      
      DBMS_OUTPUT.PUT_LINE('Detalii pentru jucatorul ' || v_nume_jucator || ' ' || v_prenume_jucator);
      DBMS_OUTPUT.PUT_LINE('ID Jucator: ' || v_id_jucator);
      DBMS_OUTPUT.PUT_LINE('Varsta: ' || v_varsta);
      DBMS_OUTPUT.PUT_LINE('Nationalitate: ' || v_nationalitate);

      OPEN cur_statistici_jucatori(v_id_jucator);
      FETCH cur_statistici_jucatori INTO v_nr_goluri, v_nr_asistari;
      CLOSE cur_statistici_jucatori;

      DBMS_OUTPUT.PUT_LINE('Numarul total de goluri: ' || v_nr_goluri);
      DBMS_OUTPUT.PUT_LINE('Numarul total de asistari: ' || v_nr_asistari);

      DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;

    CLOSE cur_jucatori;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nu exista jucatori pentru echipa cu ID ' || echipa_id || '.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('O eroare necunoscuta a aparut: ' || SQLERRM);
  END DetaliiJucatoriEchipa;
  
  ----
  
  FUNCTION detalii_meci_an(id_meci_param IN NUMBER) RETURN VARCHAR2 IS
    v_cursor SYS_REFCURSOR;
    v_id_meci NUMBER;
    v_data_meci DATE;
    v_id_echipa NUMBER;
    v_nume_echipa VARCHAR2(50);
    v_an_meci NUMBER;
    v_no_data_exception EXCEPTION;
    v_wrong_year_exception EXCEPTION;
    v_detalii_meci VARCHAR2(4000);
  BEGIN
    OPEN v_cursor FOR
      SELECT m.id_meci, m.data, em.id_echipa, e.nume_echipa
      FROM MECI m
      LEFT JOIN ECHIPA_MECI em ON m.id_meci = em.id_meci
      LEFT JOIN ECHIPA e ON em.id_echipa = e.id_echipa
      WHERE m.id_meci = id_meci_param;

    FETCH v_cursor INTO v_id_meci, v_data_meci, v_id_echipa, v_nume_echipa;

    IF NOT v_cursor%FOUND THEN
      CLOSE v_cursor;
      RAISE v_no_data_exception;
    END IF;

    v_an_meci := TO_NUMBER(TO_CHAR(v_data_meci, 'YYYY'));

    IF v_an_meci <> 2023 THEN
      CLOSE v_cursor;
      RAISE v_wrong_year_exception;
    END IF;

    CLOSE v_cursor;

    v_detalii_meci := 'Detalii meci ID ' || v_id_meci || ':' || CHR(10) || 
                     'Data meciului: ' || TO_CHAR(v_data_meci, 'DD-MON-YYYY') || CHR(10) || 
                     'Echipa gazda: ' || v_nume_echipa;

    RETURN v_detalii_meci;

  EXCEPTION
    WHEN v_no_data_exception THEN
      RETURN 'Nu s-a gasit niciun meci pentru ID-ul specificat.';
    WHEN v_wrong_year_exception THEN
      RETURN 'Meciul nu este programat pentru anul 2023.';
    WHEN OTHERS THEN
      RETURN 'O eroare necunoscuta a aparut: ' || SQLERRM;
  END detalii_meci_an;
  
  ----
  
   PROCEDURE detalii_meci_liga_fotbal(id_meci_param IN NUMBER) IS
    TYPE EmpList IS TABLE OF NUMBER;
    v_id_meci MECI.id_meci%TYPE;
    v_data MECI.data%TYPE;
    v_id_echipa_meci ECHIPA_MECI.id_echipa_meci%TYPE;
    v_id_echipa ECHIPA.id_echipa%TYPE;
    v_nume_echipa ECHIPA.nume_echipa%TYPE;
    v_id_jucator GOL.id_jucator%TYPE;
    v_nume_jucator JUCATOR.nume_jucator%TYPE;
    v_id_assist ASSIST.id_jucator%TYPE;
    v_nume_arbitru ARBITRU.nume_arbitru%TYPE;
    v_displayed_emp EmpList := EmpList(); 
    v_numar_goluri_jucatormeci NUMBER := 0;  
  BEGIN
    v_id_meci := NULL;
    v_data := NULL;

    FOR rec IN (
      SELECT m.id_meci, m.data, em.id_echipa_meci, e.id_echipa, e.nume_echipa, g.id_jucator, j.nume_jucator, a.id_jucator AS id_assist, arb.nume_arbitru
      FROM MECI m
      JOIN ECHIPA_MECI em ON m.id_meci = em.id_meci
      JOIN ECHIPA e ON em.id_echipa = e.id_echipa
      LEFT JOIN GOL g ON m.id_meci = g.id_meci
      LEFT JOIN ASSIST a ON m.id_meci = a.id_meci
      LEFT JOIN ARBITRARE_MECI am ON m.id_meci = am.id_meci
      LEFT JOIN ARBITRU arb ON am.id_arbitru = arb.id_arbitru
      LEFT JOIN JUCATOR j ON g.id_jucator = j.id_jucator
      WHERE m.id_meci = id_meci_param
      ORDER BY e.id_echipa, j.id_jucator
    ) LOOP
      v_numar_goluri_jucatormeci := v_numar_goluri_jucatormeci + 1;

      IF v_numar_goluri_jucatormeci > 1 THEN
        RAISE TOO_MANY_ROWS;
      END IF;

      IF v_id_meci IS NULL THEN
        v_id_meci := rec.id_meci;
        v_data := rec.data;

        DBMS_OUTPUT.PUT_LINE('Detalii meci ID ' || v_id_meci || ':');
        DBMS_OUTPUT.PUT_LINE('Data meciului: ' || TO_CHAR(v_data, 'YYYY-MM-DD') || CHR(10));
        DBMS_OUTPUT.PUT_LINE('Echipele implicate în meci:');

        DBMS_OUTPUT.PUT_LINE('Echipa: ' || rec.nume_echipa);
        DBMS_OUTPUT.PUT_LINE('Jucatori care au marcat goluri:');

        IF rec.id_jucator IS NOT NULL THEN
          DBMS_OUTPUT.PUT_LINE('Jucator ID ' || rec.id_jucator || ': ' || rec.nume_jucator);
          v_displayed_emp.EXTEND; 
          v_displayed_emp(v_displayed_emp.LAST) := rec.id_jucator;
        END IF;

        IF rec.id_assist IS NOT NULL AND NOT v_displayed_emp.EXISTS(v_displayed_emp.LAST) OR v_displayed_emp(v_displayed_emp.LAST) <> rec.id_assist THEN
          DBMS_OUTPUT.PUT_LINE('Asistent ID ' || rec.id_assist || ': ' || rec.nume_jucator);
          v_displayed_emp.EXTEND; 
          v_displayed_emp(v_displayed_emp.LAST) := rec.id_assist;
        END IF;

        IF rec.nume_arbitru IS NOT NULL THEN
          DBMS_OUTPUT.PUT_LINE('Arbitru: ' || rec.nume_arbitru || CHR(10));
        END IF;
      END IF;
    END LOOP;

    IF v_numar_goluri_jucatormeci = 0 THEN
      RAISE NO_DATA_FOUND;
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nu s-au gasit detalii pentru meciul cu ID-ul specificat.');
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('Prea multe goluri gasite pentru un singur jucator in meciul cu ID-ul specificat.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('O eroare necunoscuta a aparut: ' || SQLERRM);
  END detalii_meci_liga_fotbal;


END package_liga_fotbal;
/