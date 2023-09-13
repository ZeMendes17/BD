# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.484 | 531        | 1171      | 1          | Clustered Index Scan |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  | 1 | 0.003 | 26 | 25 | 1 | Clustered Index Seek |  |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               | 11      | 0.003      | 20            | 54          | 1           | Clustered Index Seek                     |            |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   | 72591      | 0.473      | 550           | 604          | 1           | Clustered Index Seek                     |            |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2007-06-25'                                          | 72591      | 0.473      | 554          | 137           | 1           | Clustered Index Scan                     |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   | 9      | 0.034      | 40           | 2          | 2          | Index Seek (NonClustered) & Key Lookup (Clustered)                     |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              | 9      | 0.034      | 46           | 42          | 2         | Index Seek (NonClustered) & Key Lookup (Clustered)                   |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              | 72591      | 0.473      | 530           | 67          | 1           | Clustered Index Scan                     |            |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04'            | 72591      | 0.473      | 556           | 37          |  1          | Clustered Index Scan                     |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |    72591   | 0.473      | 558           | 13          | 1           | Clustered Index Scan                     |            |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |    72591   | 0.473      | 814           | 61          | 1           |  Clustered Index Scan                    |            |

## ​8.2.

### a)

```
ALTER TABLE mytemp ADD CONSTRAINT ridPrimary PRIMARY KEY CLUSTERED (rid);
```

### b)

```
Time: 128606ms
Fragmentation Percentage: 98.90%
Page Fullness: 68.11%
```

### c)

```
Fillfactor = 65 {
    Time: 126780ms
    Fragmentation Percentage: 98.94%
    Page Fullness: 67.33%
}

Fillfactor = 80 {
    Time: 124830ms
    Fragmentation Percentage: 98.94%
    Page Fullness: 67.88%
}


Fillfactor = 95 {
    Time: 125073ms
    Fragmentation Percentage: 99.16%
    Page Fullness: 69.82%
}
```

### d)

```
Fillfactor = 65 {
    Time: 125280ms
    Fragmentation Percentage: 99.39%
    Page Fullness: 69.39%
}

Fillfactor = 80 {
    Time: 125380ms
    Fragmentation Percentage: 99.28%
    Page Fullness: 69.03%
}


Fillfactor = 95 {
    Time: 127143ms
    Fragmentation Percentage: 99.03%
    Page Fullness: 69.36%
}
```

### e)

```
CREATE NONCLUSTERED INDEX IDX_at1 ON mytemp(at1);
CREATE NONCLUSTERED INDEX IDX_at2 ON mytemp(at2);
CREATE NONCLUSTERED INDEX IDX_at3 ON mytemp(at3);
CREATE NONCLUSTERED INDEX IDX_lixo ON mytemp(lixo);

Without indexes: 128606ms
With indexes: 206800ms

As expected, when adding indexes, insert/remove operations take longer to
complete.
```

## ​8.3.

```
i. CREATE UNIQUE CLUSTERED INDEX IDX_ssn ON EMPLOYEE(Ssn);
ii.
```
