# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
TEMP=ρ Ssn←Essn (works_on)
A=πFname, Lname, Ssn employee ⨝ πPno,Ssn TEMP
P=πPname, Pno (ρ Pno←Pnumber (project))
A ⨝ P
```


### *b)* 

```
TEMP=πsuper (σFname = 'Carlos' AND Minit = 'D' AND Lname = 'Gomes' ρ super←Ssn (employee))
FUNCIONARIOS=employee ⨝Super_ssn=super TEMP
πFname, Minit, Lname FUNCIONARIOS
```


### *c)* 

```
TEMP=γPno; sHours←sum(Hours) works_on
PROJETO=πPname,Pnumber project
RES=PROJETO ⨝ ρPnumber←Pno TEMP
πPname, sHours RES
```


### *d)* 

```
Pnum = σPname='Aveiro Digital' σDnum=3 project
WANTEDSSN = ρPnumber←Pno ρSsn←Essn σHours>20 works_on
RESULT = πSsn (WANTEDSSN ⨝ Pnum)
πFname, Minit, Lname ((πFname, Minit, Lname, Ssn (employee)) ⨝ RESULT)
```


### *e)* 

```
πFname, Minit, Lname (σEssn=null (employee ⟕Ssn=Essn works_on))
```


### *f)* 

```
TEMP = ρDnumber←Dno (γDno; AvgSalary←avg(Salary) σSex='F' employee)
πDname, AvgSalary (department ⨝ TEMP)
```


### *g)* 

```
TEMP = σCdependent>2 (γEssn; Cdependent←count(Essn) dependent)
πFname, Minit, Lname (TEMP ⨝Essn=Ssn employee)
```


### *h)* 

```
TEMP = σEssn=null AND Mgr_ssn ≠ null (dependent ⟖Essn=Mgr_ssn department)
RESULT = (πFname, Minit, Lname, Ssn employee) ⨝ (ρSsn←Mgr_ssn TEMP)
πFname, Minit, Lname RESULT
```


### *i)* 

```
DEP_AVEIRO = σDlocation='Aveiro' dept_location
PROJ = σDnumber=null (project ⟕Dnum=Dnumber DEP_AVEIRO)
TEMP = works_on ⟖Pno=Pnumber PROJ
RESULT = πSsn (ρSsn←Essn TEMP) -- projection eliminates duplicates
(πFname, Minit, Lname, Address, Ssn (employee)) ⨝ RESULT
```


## ​Problema 5.2

### *a)*

```
RES = σ numero=null (fornecedor ⟕(nif=fornecedor) encomenda)
πnif, nome, fax, endereco, condpag, tipo RES
```

### *b)* 

```
TEMP = γcodProd; AvgUnities←avg(unidades) item
(πnome, codigo produto) ⨝ (ρcodigo←codProd TEMP)
```


### *c)* 

```
γ numEnc;count(numEnc)-> numUnidades item
```


### *d)* 

```
ENC_FORNECEDOR = fornecedor ⨝nif=fornecedor encomenda
FORNECEDOR_PRODUTO = ENC_FORNECEDOR ⨝ (πnumero, codProd (ρnumero←numEnc item))
PRODUTO_QUANTIDADE = γcodProd; quantidade←sum(unidades) item
τ item.codProd (πitem.codProd, quantidade, fornecedor.nif, fornecedor.nome, fornecedor.fax, fornecedor.endereco, fornecedor.condpag, fornecedor.tipo (PRODUTO_QUANTIDADE ⨝ FORNECEDOR_PRODUTO)) -- ordered by product code
```


## ​Problema 5.3

### *a)*

```
... Write here your answer ...
```

### *b)* 

```
... Write here your answer ...
```


### *c)* 

```
... Write here your answer ...
```


### *d)* 

```
... Write here your answer ...
```

### *e)* 

```
... Write here your answer ...
```

### *f)* 

```
... Write here your answer ...
```
