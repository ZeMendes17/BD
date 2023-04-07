-- CREATE TABLES

CREATE TABLE DEPARTMENT(
    Dname               VARCHAR(20) NOT NULL,
    Dnumber             INT NOT NULL,
    Mgr_ssn             CHAR(9),
    Mgr_start_date      DATE,

    PRIMARY KEY (Dnumber)
);

CREATE TABLE EMPLOYEE(
    Ssn             CHAR(9) NOT NULL,
    Fname           VARCHAR(15) NOT NULL,
    Minit           VARCHAR(1),
    Lname           VARCHAR(15) NOT NULL,
    Bdate           DATE,
    [Address]       VARCHAR(30),
    Sex             VARCHAR(1), 
    Salary          DECIMAL(6,2),
    Super_ssn       CHAR(9),
    Dno             INT NOT NULL,

    PRIMARY KEY (Ssn),
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE DEPT_LOCATIONS(
    Dnumber             INT NOT NULL,
    Dlocation           VARCHAR(20) NOT NULL,

    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE PROJECT(
    Pname           VARCHAR(30) NOT NULL,
    Pnumber         INT NOT NULL,
    Plocation       VARCHAR(20),
    Dnum            INT NOT NULL,

    PRIMARY KEY (Pnumber),
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON(
    Essn        CHAR(9) NOT NULL,
    Pno         INT NOT NULL,
    [Hours]     DECIMAL(3,1) NOT NULL,

    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

CREATE TABLE DEPENDENT(
    Essn                CHAR(9) NOT NULL,
    Dependent_name      VARCHAR(30) NOT NULL,
    Sex                 CHAR(1),
    Bdate               DATE,
    Relationship        VARCHAR(15),

    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);