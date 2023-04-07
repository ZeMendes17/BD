# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
SELECT * FROM authors;
```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
SELECT au_fname, au_lname, phone FROM authors;
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
SELECT au_fname, au_lname, phone FROM authors
ORDER BY au_fname, au_lname;
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone
FROM authors
ORDER BY first_name, last_name;
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone
FROM authors
WHERE state = 'CA' AND au_lname != 'Ringer'
ORDER BY first_name, last_name;
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
SELECT * FROM publishers WHERE pub_name LIKE '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
SELECT DISTINCT publishers.pub_name FROM (publishers JOIN titles ON publishers.pub_id = titles.pub_id) WHERE titles.type = 'Business';
```

### *h)* Número total de vendas de cada editora; 

```
SELECT publishers.pub_name, temp.quantity FROM publishers JOIN 
(SELECT titles.pub_id, SUM (sales.qty) quantity FROM (sales JOIN titles ON sales.title_id = titles.title_id) GROUP BY titles.pub_id) AS temp ON publishers.pub_id = temp.pub_id;
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
SELECT pub_name, title, sum(qty) AS sales FROM publishers, titles,sales
WHERE publishers.pub_id = titles.pub_id AND titles.title_id=sales.title_id
GROUP BY pub_name, title;
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
SELECT DISTINCT titles.title FROM ((dbo.stores JOIN dbo.sales ON stores.stor_id=sales.stor_id) 
										JOIN dbo.titles ON sales.title_id=titles.title_id)
WHERE stores.stor_name='Bookbeat'
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
SELECT au_fname, au_lname
FROM ((titles JOIN  titleauthor ON  titles.title_id=titleauthor.title_id) JOIN authors ON authors.au_id=titleauthor.au_id)
GROUP BY au_fname, au_lname
HAVING count(DISTINCT [type]) > 1;
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
SELECT titles.type, COUNT(sales.qty) AS QuantidadeVendas, AVG(titles.price) AS MediaPreco FROM (dbo.titles JOIN dbo.sales ON titles.title_id=sales.title_id)
	GROUP BY titles.pub_id, titles.type
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
SELECT type, max(advance) AS AdvMax, avg(advance) AS Med FROM titles
GROUP BY type
HAVING max(advance) > 1.5*avg(advance);
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
SELECT titles.title, authors.au_fname, authors.au_lname, SUM(sales.qty*titles.price) AS ValorVendas
FROM (((titles JOIN sales ON titles.title_id=sales.title_id) 
				JOIN titleauthor ON titles.title_id=titleauthor.title_id) 
				 JOIN authors ON titleauthor.au_id=authors.au_id)
GROUP BY titles.title, authors.au_fname, authors.au_lname
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
SELECT title, ytd_sales,price*ytd_sales AS facturacao, price*ytd_sales*royalty/100 AS auths_revenue, price*ytd_sales-price*ytd_sales*royalty/100 AS publisher_revenue 
FROM titles;
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
SELECT title,ytd_sales, CONCAT(authors.au_fname, ' ', authors.au_lname) as author, 
	price*ytd_sales*royalty/100 AS auth_revenue, price*ytd_sales-price*ytd_sales*royalty/100 AS publisher_revenue 
FROM ((titles JOIN titleauthor ON titles.title_id=titleauthor.title_id) 
				JOIN authors ON titleauthor.au_id=authors.au_id)
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
SELECT stor_name, count(title) AS QntdTitulos
FROM ((stores JOIN sales ON stores.stor_id=sales.stor_id) JOIN titles ON sales.title_id=titles.title_id)
GROUP BY stor_name
HAVING count(title)=(SELECT count(title_id) FROM titles);
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
SELECT stor_name
FROM ((stores JOIN sales ON stores.stor_id=sales.stor_id) 
				JOIN titles ON sales.title_id=titles.title_id) GROUP BY stor_name
HAVING (SUM(sales.qty)/COUNT(title)) > (SELECT SUM(qty)/COUNT(stor_id) FROM sales)
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
SELECT DISTINCT title FROM titles
EXCEPT (SELECT DISTINCT title
FROM titles,sales,stores
WHERE stor_name='Bookbeat' AND titles.title_id=sales.title_id AND sales.stor_id=stores.stor_id);
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
SELECT publishers.pub_name, stores.stor_name FROM publishers 
CROSS JOIN stores
LEFT JOIN ( select sales.title_id,sales.stor_id FROM sales) AS sold_titles ON stores.stor_id = sold_titles.stor_id
LEFT JOIN titles ON sold_titles.titles_id = titles.title_id AND publishers.pub_id = titles.pub_id
WHERE titles.title_id IS NULL
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT PROJECT.Pname AS Project, EMPLOYEE.Ssn, EMPLOYEE.Fname,
EMPLOYEE.Minit, EMPLOYEE.Lname
FROM EMPLOYEE JOIN WORKS_ON ON Ssn=Essn JOIN PROJECT
ON WORKS_ON.Pno=PROJECT.Pnumber
```

##### *b)* 

```
SELECT E1.Fname, E1.Minit, E1.Lname
FROM (EMPLOYEE AS E1 JOIN EMPLOYEE AS E2 ON E1.Super_ssn=E2.Ssn)
WHERE E2.Fname='Carlos'AND E2.Minit='D' AND E2.Lname='Gomes'
```

##### *c)* 

```
SELECT PROJECT.Pname AS Project, SUM(WORKS_ON.[Hours])
FROM WORKS_ON JOIN PROJECT ON WORKS_ON.Pno=PROJECT.Pnumber
GROUP BY PROJECT.Pname
```

##### *d)* 

```
SELECT EMPLOYEE.Fname, EMPLOYEE.Minit, EMPLOYEE.Lname
FROM EMPLOYEE JOIN WORKS_ON ON Ssn=Essn JOIN PROJECT ON WORKS_ON.Pno=PROJECT.Pnumber
WHERE EMPLOYEE.Dno=3 AND [Hours]>20 AND Pname='Aveiro Digital'
```

##### *e)* 

```
SELECT EMPLOYEE.Fname, EMPLOYEE.Minit, EMPLOYEE.Lname
FROM EMPLOYEE LEFT OUTER JOIN WORKS_ON ON Ssn=Essn
WHERE Essn IS NULL
```

##### *f)* 

```
SELECT Dname, AVG(Salary) AS AverageSalary
FROM DEPARTMENT JOIN EMPLOYEE ON Dno=Dnumber
WHERE Sex='F'
GROUP BY Dname
```

##### *g)* 

```
SELECT Fname, Minit, Lname, COUNT(Dependent_name) AS NumberOfDependent
FROM EMPLOYEE JOIN [DEPENDENT] ON Ssn=Essn
GROUP BY Fname, Minit, Lname
HAVING COUNT(Dependent_name) > 2
```

##### *h)* 

```
SELECT Fname, Minit, Lname
FROM (EMPLOYEE JOIN DEPARTMENT ON Ssn=Mgr_ssn) LEFT OUTER JOIN [DEPENDENT] ON Ssn=Essn
WHERE Essn IS NULL
```

##### *i)* 

```
SELECT DISTINCT Fname, Minit, Lname, [Address]
FROM ((EMPLOYEE JOIN WORKS_ON ON Ssn=Essn) JOIN PROJECT ON Pno=Pnumber) JOIN DEPT_LOCATIONS ON DEPT_LOCATIONS.Dnumber=Dno
WHERE Plocation='Aveiro' AND Dlocation!='Aveiro'
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT Nif, Nome, Fax, Endereco, CondPag, Tipo
FROM FORNECEDOR LEFT OUTER JOIN ENCOMENDA ON FORNECEDOR.NIF=ENCOMENDA.Fornecedor
WHERE Numero IS NULL
```

##### *b)* 

```
SELECT codProd AS Encomenda, AVG(Unidades) AS AverageUnidades
FROM ITEM
GROUP BY codProd
```


##### *c)* 

```
SELECT numEnc AS Encomenda, AVG(Unidades) AS AverageUnidades
FROM ITEM
GROUP BY numEnc
```


##### *d)* 

```
SELECT FORNECEDOR.Nome, PRODUTO.Nome, SUM(ITEM.Unidades) AS Unidades
FROM PRODUTO JOIN (ITEM JOIN (Fornecedor JOIN Encomenda ON 
NIF = Fornecedor) ON numEnc=Numero) ON Codigo=codProd
GROUP BY FORNECEDOR.Nome, PRODUTO.Nome
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT paciente.numUtente, paciente.nome FROM paciente 
	LEFT JOIN prescricao ON paciente.numUtente=prescricao.numUtente
WHERE prescricao.numPresc IS NULL
```

##### *b)* 

```
SELECT medico.especialidade, COUNT(medico.especialidade) as QntPrescricoes FROM prescricao 
	JOIN medico ON prescricao.numMedico=medico.numSNS
GROUP BY medico.especialidade
```


##### *c)* 

```
SELECT farmacia.nome, COUNT(farmacia.nome) as prescricoesProc FROM farmacia 
	JOIN prescricao ON farmacia.nome=prescricao.farmacia
GROUP BY farmacia.nome
```


##### *d)* 

```
SELECT farmaco.nome FROM farmaco
WHERE farmaco.numRegFarm=906
EXCEPT SELECT DISTINCT presc_farmaco.nomeFarmaco FROM prescricao 
	LEFT JOIN presc_farmaco ON prescricao.numPresc=presc_farmaco.numPresc
WHERE presc_farmaco.numRegFarm=906
```

##### *e)* 

```
SELECT prescricao.farmacia, farmaceutica.nome, COUNT(farmaceutica.numReg) AS farmacosVend FROM ((prescricao 
	LEFT JOIN presc_farmaco ON prescricao.numPresc=presc_farmaco.numPresc) 
		LEFT JOIN farmaceutica ON presc_farmaco.numRegFarm=farmaceutica.numReg)
WHERE farmacia IS NOT NULL
GROUP BY prescricao.farmacia, farmaceutica.nome
```

##### *f)* 

```
SELECT prescricao.numUtente FROM prescricao 
	LEFT JOIN medico ON prescricao.numMedico=medico.numSNS
GROUP BY prescricao.numUtente
HAVING COUNT(prescricao.numMedico)>1
```
