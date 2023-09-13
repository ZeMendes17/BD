# BD: Guião 9


## ​9.1
 
### *a)*

```
CREATE PROC RemoveEmployees @EmpSsn char(9)
AS
    IF EXISTS(SELECT * FROM EMPLOYEES WHERE Ssn = @EmpSsn)
    BEGIN
        BEGIN TRANSACTION
            DELETE FROM DEPENDENT WHERE Essn = @EmpSsn;
            DELETE FROM WORKS_ON WHERE Essn = @EmpSsn;
            DELETE FROM EMPLOYEE WHERE Ssn = @EmpSsn;

            UPDATE EMPLOYEE SET Super_ssn=null WHERE Super_ssn=@EmpSsn
            UPDATE DEPARTMENT SET Mgr_ssn=null WHERE Mgr_ssn=@EmpSsn
        COMMIT TRANSACTION
    END

    ELSE
        PRINT 'User does not exist'

Obs: Some aditional precautions taken were:
- if the Ssn inserted does not exist, then the remove query doesn't need to be executed
- using a transaction so that if something goes wrong, it does not execute the queries
- update the supervisor and manager ssn from the employee and department table respectively to null, because they do not exist anymore 
```

### *b)* 

```
CREATE PROC getOldestManager @oldSsn CHAR(9) OUTPUT, @oldYears INT OUTPUT
AS
	SELECT *
	FROM EMPLOYEE JOIN DEPARTMENT ON Ssn=Mgr_ssn

	SELECT @oldSsn=Mgr_ssn, @oldYears=MAX(DATEDIFF(YEAR, Mgr_start_date, getdate()))
	FROM DEPARTMENT
	WHERE Mgr_Ssn IS NOT NULL
	GROUP BY Mgr_Ssn, Mgr_start_date
	ORDER BY Mgr_start_date DESC
```

### *c)* 

```
CREATE TRIGGER oneMgr ON dbo.DEPARTMENT
AFTER INSERT, UPDATE
AS
	SET NOCOUNT ON;

	DECLARE @SSN CHAR(9), @numDepartments INT;

	SELECT @SSN = Mgr_ssn FROM inserted;
	SELECT @numDepartments = COUNT(Mgr_ssn) FROM DEPARTMENT WHERE Mgr_ssn = @SSN

	IF @numDepartments > 0 BEGIN
		RAISERROR ('Impossible to insert. Employee can only manage 1 department', 16,1);
		ROLLBACK TRAN;
	END
```

### *d)* 

```
CREATE TRIGGER LimitadorGanhoss
ON Employee
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Mgr_salary DECIMAL(6,2);
    DECLARE @Dno INT;
    DECLARE @ssn CHAR(9);
    DECLARE @sal DECIMAL(6,2);

    SELECT @Dno = Dno, @sal = Salary, @ssn = Ssn FROM inserted;

    SELECT @Mgr_salary = Salary
    FROM Department
    JOIN Employee ON Mgr_ssn = Ssn
    WHERE Dnumber = @Dno;

    IF (@sal > @Mgr_salary)
    BEGIN
        UPDATE Employee
        SET Salary = @Mgr_salary - 1
        WHERE Ssn = @ssn;
    END;
END;
```

### *e)* 

```
CREATE FUNCTION getEmpProj (@empSsn CHAR(9)) RETURNS Table
AS
	RETURN(
		SELECT Pname, Plocation
		FROM PROJECT JOIN WORKS_ON ON Pnumber=Pno
		WHERE Essn=@empSsn
	)
```

### *f)* 

```
CREATE FUNCTION dbo.SalariosAcimaMedias (@dno INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Ssn, Fname, Minit, Salary, Dno
    FROM Employee
    WHERE Dno = @dno AND Salary > (SELECT AVG(Salary)
                                   FROM Employee
                                   WHERE Dno = @dno)
);
```

### *g)* 

```
CREATE FUNCTION dbo.employeeDeptHighAverage (@dep INT)
RETURNS @projs TABLE (pname VARCHAR(30), pnumber INT NOT NULL, plocation VARCHAR(15), dnum INT, budget DECIMAL(6,2), totalbudget DECIMAL(6,2))
AS
	BEGIN
		DECLARE @pname VARCHAR(30);
		DECLARE @pnumber INT;
		DECLARE @plocation VARCHAR(15);
		DECLARE @dnum INT;
		DECLARE @budget DECIMAL(6,2);
		DECLARE @totalbudget DECIMAL(6,2);

		DECLARE @hours decimal;
		DECLARE @salary decimal;

		SET @budget = 0;
		SET @totalbudget = 0;

		-- cursor to go through tuples
		DECLARE C CURSOR FAST_FORWARD
		FOR
			SELECT Pname, Pnumber, Plocation, Dnum, [Hours], Salary
			FROM (PROJECT JOIN WORKS_ON ON Pnumber=Pno) JOIN EMPLOYEE ON Essn=Ssn
			WHERE Dnum=@dep

		OPEN C;
		FETCH C INTO @pname, @pnumber, @plocation, @dnum, @hours, @salary;

		DECLARE @prevPnumber AS int
		SET @prevPnumber = @pnumber

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @prevPnumber <> @pnumber -- <> MEANS DIFFERENT
			BEGIN
				SET @totalbudget += @budget;

				INSERT @projs VALUES (@pname, @pnumber, @plocation, @dnum, @budget, @totalbudget);

				SET @budget = 0;
				SET @prevPnumber = @pnumber
			END

			SET @budget += @salary * @hours / 40;

			FETCH C INTO @pname, @pnumber, @plocation, @dnum, @hours, @salary;

		END

		CLOSE C;
		DEALLOCATE C;
		RETURN
	END
```

### *h)* 

```
After:

CREATE TRIGGER DeleteDepartment ON Department
AFTER DELETE
AS
	BEGIN
			IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Department_deleted')) 
				BEGIN
					CREATE TABLE Department_deleted(
						Dname			VARCHAR(30) NOT NULL,
						Dnumber			INT			NOT NULL,
						Mgr_ssn			CHAR(9),
						Mgr_start_date	DATE,

						FOREIGN KEY (Mgr_ssn) REFERENCES Employee 
					)								
				END

			INSERT INTO Department_deleted
			SELECT * FROM deleted
	END

Instead of:

CREATE TRIGGER DeleteDepartment ON Department
INSTEAD OF DELETE
AS
	BEGIN

			DECLARE @dnum DECIMAL(6,2);

			SELECT @dnum = Dnumber
			FROM deleted;

			IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Department_deleted')) 
				BEGIN
					CREATE TABLE Department_deleted(
						Dname			VARCHAR(30) NOT NULL,
						Dnumber			INT			NOT NULL,
						Mgr_ssn			CHAR(9),
						Mgr_start_date	DATE,
						
						FOREIGN KEY (Mgr_ssn) REFERENCES Employee 
					)						
				END

			INSERT INTO Department_deleted
			SELECT * FROM deleted

			DELETE FROM Department where Dnumber=@dnum; -- here we have to delete it our selves
	END

Using AFTER we do not need to delete the table manually since it is the clients operation, while using INSTEAD OF this is needed. Also, while using INSTEAD OF one variable had to be declared in order to store the pretended Department number to delete.
AFTER is more flexible, but may lead to unexpected behaviour, and INSTEAD OF maintains data integrity but reduces the performance of that action in the table
```

### *i)* 

```
Some benefits of using Stored Procedures and UDF's are: Extensibility, Performance, Usability, Data Integrity, Security.
Some differences between these two are: Stored Procedures can return, zero, singular or multiple values while UDF's can only return one, UDF's do not have output param and SP do, SP cannot use SELECT, WHERE, HAVING statments and UDF's can and at last, SP's have exception handling and transactions while UDF's do not.
UDF's may be used to do operations and transformations within queries, while SP's may be used to execute complex operations, batch processing, transactions, and ensure data integrity in the database.
```
