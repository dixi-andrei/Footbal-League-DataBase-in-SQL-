--SEQ

create sequence SEQ_JUCATOR
increment by 1 
start with 1 
maxvalue 999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ECHIPA
increment by 1 
start with 1 
maxvalue 999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ANTRENOR
increment by 1 
start with 1 
maxvalue 9999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ARBITRU
increment by 1 
start with 1 
maxvalue 999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_STADION
increment by 1 
start with 1 
maxvalue 999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ECHIPA_MECI
increment by 1 
start with 1 
maxvalue 999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_GOL
increment by 1 
start with 1 
maxvalue 999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ASSIST
increment by 1 
start with 1 
maxvalue 9999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_ARBITRARE_MECI
increment by 1 
start with 1 
maxvalue 9999999
minvalue 1 
nocycle 
nocache; 

create sequence SEQ_MECI
increment by 1 
start with 1 
maxvalue 9999999
minvalue 1 
nocycle 
nocache; 

---Tabele

CREATE TABLE STADION (
  id_stadion number,
  nume_stadion varchar2(50),
  capacitate_stadion number,
  PRIMARY KEY (id_stadion)
);


CREATE TABLE ECHIPA (
  id_echipa number,
  nume_echipa varchar2(50),
  oras varchar2(50),
  id_stadion number,
  an_fondare number,
  PRIMARY KEY (id_echipa),
    FOREIGN KEY (id_stadion)
    REFERENCES STADION(id_stadion)
);

CREATE TABLE JUCATOR (
  id_jucator number,
  id_echipa number,
  nume_jucator varchar2(50),
  prenume_jucator varchar2(50),
  varsta number,
  data_nastere date,
  nationalitate varchar2(50),
  PRIMARY KEY (id_jucator),
FOREIGN KEY (id_echipa)
    REFERENCES ECHIPA(id_echipa)
);


CREATE TABLE MECI (
  id_meci number,
  data date,
  PRIMARY KEY (id_meci)
);


CREATE TABLE ECHIPA_MECI (
  id_echipa_meci number,
  id_meci number,
  id_echipa number,
  PRIMARY KEY (id_echipa_meci),
  FOREIGN KEY (id_meci)
    REFERENCES MECI(id_meci),
FOREIGN KEY (id_echipa)
    REFERENCES ECHIPA(id_echipa)
);

CREATE TABLE ARBITRU (
  id_arbitru number,
  nume_arbitru varchar2(50),
  meciuri_arbitrate number,
  PRIMARY KEY (id_arbitru)
);


CREATE TABLE ANTRENOR (
  id_antrenor number,
  id_echipa number,
  nume_antrenor varchar2(50),
  prenume_antrenor varchar2(50),
  experienta number,
  PRIMARY KEY (id_antrenor),
FOREIGN KEY (id_echipa)
    REFERENCES ECHIPA(id_echipa)
);


CREATE TABLE ASSIST (
  id_assist number,
  id_meci number,
  id_jucator number,
  minut_assist number,
  PRIMARY KEY (id_assist),
  FOREIGN KEY (id_meci)
    REFERENCES MECI(id_meci),
FOREIGN KEY (id_jucator)
    REFERENCES JUCATOR(id_jucator)
);


CREATE TABLE GOL (
  id_gol number,
  id_meci number,
  id_jucator number,
  minut_gol number,
  PRIMARY KEY (id_gol),
  FOREIGN KEY (id_meci)
    REFERENCES MECI(id_meci),
FOREIGN KEY (id_jucator)
    REFERENCES JUCATOR(id_jucator)
);

CREATE TABLE ARBITRARE_MECI (
  id_arbitrare_meci number,
  id_meci number,
  id_arbitru number,
  PRIMARY KEY (id_arbitrare_meci),
FOREIGN KEY (id_meci)
    REFERENCES MECI(id_meci),
FOREIGN KEY (id_arbitru)
    REFERENCES ARBITRU(id_arbitru)
);

---INSERARI

INSERT INTO STADION 
VALUES (SEQ_STADION.NEXTVAL, 'Arena-Nationala', 55634);
INSERT INTO STADION 
VALUES (SEQ_STADION.NEXTVAL, 'Cluj-Arena', 22200);
INSERT INTO STADION
VALUES (SEQ_STADION.NEXTVAL, 'Ghencea', 31254);
INSERT INTO STADION 
VALUES (SEQ_STADION.NEXTVAL, 'Sepsi-Arena', 8400);
INSERT INTO STADION 
VALUES (SEQ_STADION.NEXTVAL, 'Stefan-cel-Mare', 15032);
INSERT INTO STADION
VALUES (SEQ_STADION.NEXTVAL, 'Ion-Oblemenco', 30983);
INSERT INTO STADION 
VALUES (SEQ_STADION.NEXTVAL, 'Gruia', 17000);
INSERT INTO STADION
VALUES (SEQ_STADION.NEXTVAL, 'Ilie-Oana', 15000);
INSERT INTO STADION
VALUES (SEQ_STADION.NEXTVAL, 'Viitorul', 4500);
INSERT INTO  STADION
VALUES (SEQ_STADION.NEXTVAL, 'Francisc-Neuman', 7250);
INSERT INTO STADION
VALUES(SEQ_STADION.NEXTVAL,'Giulesti',14000);
INSERT INTO STADION
VALUES(SEQ_STADION.NEXTVAL,'Emil-Alexandrescu',11500);
INSERT INTO STADION
VALUES(SEQ_STADION.NEXTVAL,'Arena-Rosiori',500);

INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'FC-Rapid','Bucuresti',54,1923);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'Universitatea-Craiova','Recolta-Gogosu',55,1948);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'Dinamo','Bucuresti',56,1918);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'FCSB','Bucuresti',57,1947);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'Petrolul','Ploiesti',58,1923);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'UTA','Arad',10,1960);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'CFR','Cluj',7,1979);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'U-CLUJ','Cluj',2,1957);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'Sepsi','Sfantu-Gheorghe',4,2010);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'Farul-Constanta','Constanta',9,1968);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'Poli-Iasi','Iasi',12,1968);
INSERT INTO ECHIPA
VALUES(SEQ_ECHIPA.NEXTVAL,'Rova','Rosiori',13,1955);

INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 71, 'Sawa', 'Stefan', 17, TO_DATE('2006-03-20', 'YYYY-MM-DD'), 'Romania');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 70, 'Cristea', 'Francisc', 22, TO_DATE('2001-02-17', 'YYYY-MM-DD'), 'Romania');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 70, 'Sapunaru', 'Cristian', 38, TO_DATE('1985-02-05', 'YYYY-MM-DD'), 'Romania');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 71, 'Coman', 'Florinel', 24, TO_DATE('1999-03-17', 'YYYY-MM-DD'), 'Romania');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 72, 'Ionascu', 'Dragos', 19, TO_DATE('2001-08-14', 'YYYY-MM-DD'), 'Rom');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 70, 'Dixi', 'Andrei', 19, TO_DATE('2003-07-30', 'YYYY-MM-DD'), 'Romania');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 70, 'Fusho', 'Bamboye', 27, TO_DATE('1997-05-20', 'YYYY-MM-DD'), 'Ungaria');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 70, 'Jayson', 'Papeau', 26, TO_DATE('1998-01-18', 'YYYY-MM-DD'), 'Franta');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 73, 'Moldovan', 'Horatiu', 25, TO_DATE('1999-01-29', 'YYYY-MM-DD'), 'Romania');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 74, 'Alibec', 'Denis', 31, TO_DATE('1992-06-7', 'YYYY-MM-DD'), 'Romania');
INSERT INTO JUCATOR
VALUES (SEQ_JUCATOR.NEXTVAL, 74, 'Munteanu', 'Louis', 20, TO_DATE('2003-08-30', 'YYYY-MM-DD'), 'Romania');


INSERT INTO ARBITRU
VALUES (SEQ_ARBITRU.NEXTVAL,'Hategan',200);
INSERT INTO ARBITRU
VALUES (SEQ_ARBITRU.NEXTVAL,'Kovacs',150);
INSERT INTO ARBITRU
VALUES (SEQ_ARBITRU.NEXTVAL,'Petrescu',89);
INSERT INTO ARBITRU
VALUES (SEQ_ARBITRU.NEXTVAL,'Popa', 235);
INSERT INTO ARBITRU
VALUES (SEQ_ARBITRU.NEXTVAL,'Birsan' ,55);

INSERT INTO ANTRENOR
VALUES(SEQ_ANTRENOR.NEXTVAL,70,'Mutu','Adrian',2);
INSERT INTO ANTRENOR
VALUES(SEQ_ANTRENOR.NEXTVAL, 71 ,'Petrescu','Dan',18);
INSERT INTO ANTRENOR
VALUES(SEQ_ANTRENOR.NEXTVAL, 72,'Hagi','Gica',11);
INSERT INTO ANTRENOR
VALUES(SEQ_ANTRENOR.NEXTVAL, 73 ,'Reghecamf','Laurentiu',14);
INSERT INTO ANTRENOR
VALUES(SEQ_ANTRENOR.NEXTVAL,74,'Grozavu','Leo',11);

INSERT INTO MECI
VALUES(SEQ_MECI.NEXTVAL,TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO MECI
VALUES(SEQ_MECI.NEXTVAL,TO_DATE('2023-03-08', 'YYYY-MM-DD'));
INSERT INTO MECI
VALUES(SEQ_MECI.NEXTVAL,TO_DATE('2023-05-22', 'YYYY-MM-DD'));
INSERT INTO MECI
VALUES(SEQ_MECI.NEXTVAL,TO_DATE('2023-07-11', 'YYYY-MM-DD'));
INSERT INTO MECI
VALUES(SEQ_MECI.NEXTVAL,TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO MECI
VALUES(SEQ_MECI.NEXTVAL,TO_DATE('2022-11-30', 'YYYY-MM-DD'));

INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,27,61,40);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,27,61,89);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,29,66,22);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,27,67,15);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,5,8,33);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,4,1,68);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,1,10,45);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,5,2,20);
INSERT INTO GOL
VALUES(SEQ_GOL.NEXTVAL,3,8,90);


INSERT INTO ASSIST
VALUES(SEQ_ASSIST.NEXTVAL,27,61,45);
INSERT INTO ASSIST
VALUES(SEQ_ASSIST.NEXTVAL,29,66,22);
INSERT INTO ASSIST
VALUES(SEQ_ASSIST.NEXTVAL,29,66,89);
INSERT INTO ASSIST
VALUES(SEQ_ASSIST.NEXTVAL,4,1,15);
INSERT INTO ASSIST
VALUES(SEQ_ASSIST.NEXTVAL,4,4,22);

26-30
 70-74
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,26,70);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,26,71);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,27,71);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,27,72);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,28,72);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,28,73);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,29,73);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,29,74);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,30,74);
INSERT INTO ECHIPA_MECI
VALUES(SEQ_ECHIPA_MECI.NEXTVAL,30,71);


INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,27,26);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,1,2);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,2,2);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,2,3);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,3,3);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,3,4);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,4,4);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,4,5);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,5,1);
INSERT INTO ARBITRARE_MECI
VALUES(SEQ_ARBITRARE_MECI.NEXTVAL,5,5);



