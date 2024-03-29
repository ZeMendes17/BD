-- insert information into the tables

INSERT INTO DEPARTMENT VALUES ('Investigacao',1,'21312332','2010-08-02');
INSERT INTO DEPARTMENT VALUES ('Comercial',2,'321233765','2013-05-16');
INSERT INTO DEPARTMENT VALUES ('Logistica',3,'41124234','2013-05-16');
INSERT INTO DEPARTMENT VALUES ('Recursos Humanos',4,'12652121','2014-04-02');
INSERT INTO DEPARTMENT VALUES ('Desporto',5,NULL,NULL);

INSERT INTO EMPLOYEE VALUES ('183623612', 'Paula','A','Sousa','2001-08-11','Rua da FRENTE','F',1450.00,NULL,3);
INSERT INTO EMPLOYEE VALUES ('21312332', 'Carlos','D','Gomes','2000-01-01','Rua XPTO','M',1200.00,NULL,1);
INSERT INTO EMPLOYEE VALUES ('342343434', 'Maria','I','Pereira','2001-05-01','Rua JANOTA','F',1250.00,'21312332',2);
INSERT INTO EMPLOYEE VALUES ('41124234', 'Joao','G','Costa','2001-01-01','Rua YGZ','M',1300.00,'21312332',2);
INSERT INTO EMPLOYEE VALUES ('12652121', 'Ana','L','Silva','1990-03-03','Rua ZIG ZAG','F',1400.00,'21312332',2);

INSERT INTO [DEPENDENT] VALUES ('21312332' ,'Joana Costa','F','2008-04-01', 'Filho');
INSERT INTO [DEPENDENT] VALUES ('21312332' ,'Maria Costa','F','1990-10-05', 'Neto');
INSERT INTO [DEPENDENT] VALUES ('21312332' ,'Rui Costa','M','2000-08-04','Neto');
INSERT INTO [DEPENDENT] VALUES ('321233765','Filho Lindo','M','2001-02-22','Filho');
INSERT INTO [DEPENDENT] VALUES ('342343434','Rosa Lima','F','2006-03-11','Filho');
INSERT INTO [DEPENDENT] VALUES ('41124234' ,'Ana Sousa','F','2007-04-13','Neto');
INSERT INTO [DEPENDENT] VALUES ('41124234' ,'Gaspar Pinto','M','2006-02-08','Sobrinho');

INSERT INTO DEPT_LOCATIONS VALUES (2,'Aveiro');
INSERT INTO DEPT_LOCATIONS VALUES (3,'Coimbra');

INSERT INTO PROJECT VALUES ('Aveiro Digital',1,'Aveiro',3);
INSERT INTO PROJECT VALUES ('BD Open Day',2,'Espinho',2);
INSERT INTO PROJECT VALUES ('Dicoogle',3,'Aveiro',3);
INSERT INTO PROJECT VALUES ('GOPACS',4,'Aveiro',3);

INSERT INTO WORKS_ON VALUES ('183623612',1,20.0);
INSERT INTO WORKS_ON VALUES ('183623612',3,10.0);
INSERT INTO WORKS_ON VALUES ('21312332' ,1,20.0);
INSERT INTO WORKS_ON VALUES ('321233765',1,25.0);
INSERT INTO WORKS_ON VALUES ('342343434',1,20.0);
INSERT INTO WORKS_ON VALUES ('342343434',4,25.0);
INSERT INTO WORKS_ON VALUES ('41124234' ,2,20.0);
INSERT INTO WORKS_ON VALUES ('41124234' ,3,30.0);