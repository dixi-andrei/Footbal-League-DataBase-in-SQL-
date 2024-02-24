CREATE OR REPLACE TRIGGER before_update_an_fond
BEFORE UPDATE
ON ECHIPA
FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.an_fondare <> :OLD.an_fondare THEN
      RAISE_APPLICATION_ERROR(-20001, 'Anul de fondare al echipei nu poate fi modificat.');
   END IF;
END;
/

UPDATE ECHIPA
SET an_fondare = 1960
WHERE id_echipa = 70;

CREATE OR REPLACE TRIGGER dixi.ddl_procedure_trigger
AFTER CREATE OR ALTER OR DROP ON SCHEMA
DECLARE
  v_event_type     VARCHAR2(30);
  v_object_type    VARCHAR2(30);
  v_object_name    VARCHAR2(30);
BEGIN
  v_event_type := ora_sysevent;
  v_object_type := ora_dict_obj_type;
  v_object_name := ora_dict_obj_name;cds

  IF v_event_type = 'CREATE' AND v_object_type = 'FUNCTION' THEN
    DBMS_OUTPUT.PUT_LINE('Functia ' || v_object_name || ' a fost creata.');
  ELSIF v_event_type = 'ALTER' AND v_object_type = 'FUNCTION' THEN
    DBMS_OUTPUT.PUT_LINE('FUNCTION ' || v_object_name || ' a fost modificata.');
  ELSIF v_event_type = 'DROP' AND v_object_type = 'FUNCTION' THEN
    DBMS_OUTPUT.PUT_LINE('Functia ' || v_object_name || ' a fost stearsa.');
  END IF;
END;
/


CREATE OR REPLACE FUNCTION test_functie RETURN VARCHAR2 AS
BEGIN
  RETURN 'functie test.';
END;
/

CREATE OR REPLACE FUNCTION test_functie RETURN VARCHAR2 AS
BEGIN
  RETURN 'modificare functie';
END;
/

DROP FUNCTION test_functie;

begin 
package_liga_fotbal.detalii_meci_liga_fotbal(id_meci_param => 27);
end;
/

SET SERVEROUTPUT ON;
BEGIN
  package_liga_fotbal.afisare_informatii_meci(p_id_meci => 27);
END;
/


set serveroutput on;

DECLARE
  rezultat VARCHAR2(100); -- Schimb? dimensiunea tipului de date �n func?ie de nevoi
BEGIN
  rezultat := package_liga_fotbal.detalii_meci_an(id_meci_param => 27);
  DBMS_OUTPUT.PUT_LINE('Rezultatul este: ' || rezultat);
  -- Po?i folosi rezultatul �n continuare �n blocul PL/SQL sau �ntr-o instruc?iune SQL ulterioar?
END;
/

SELECT package_liga_fotbal.detalii_meci_an(id_meci_param => 27) AS rezultat
FROM dual;
