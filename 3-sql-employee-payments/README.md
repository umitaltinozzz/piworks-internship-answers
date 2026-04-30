# SQL - Employee & Payments

SQL queries written for Question 3 of the P.I. WORKS internship application.

---

## Tables

### Employee

| Employee ID | FirstName | LastName | City      | State  |
|:-----------:|-----------|----------|-----------|--------|
| 10330       | John      | John     | NY        | NY     |
| 10449       | Sarah     | Lebat    | Melbourne | Bourke |
| 11012       | Jon       | Dallas   | NY        | NY     |
| 11013       | Gheorghe  | Honey    | NY        | NY     |
| 11014       | Anton     | Savar    | NY        | NY     |

### Payments

| Employee ID | Salary Date | Month ID | Value $ |
|:-----------:|-------------|:--------:|--------:|
| 10330       | June        | 6        | 128     |
| 10330       | July        | 7        | 158     |
| 10330       | August      | 8        | 133     |
| 10330       | September   | 9        | 120     |
| 10330       | October     | 10       | 188     |
| 10330       | November    | 11       | 160     |
| 10330       | December    | 12       | 105     |
| 10449       | September   | 9        | 150     |
| 10449       | October     | 10       | 158     |
| 10449       | November    | 11       | 160     |
| 10449       | December    | 12       | 180     |

---

## Query 1 - Total amount earned by each employee

```sql
SELECT
    e.FirstName,
    e.LastName,
    COALESCE(SUM(p.Value), 0) AS TotalAmount
FROM       Employee e
LEFT JOIN  Payments p ON p.EmployeeID = e.EmployeeID
GROUP BY   e.EmployeeID, e.FirstName, e.LastName
ORDER BY   TotalAmount DESC, e.LastName, e.FirstName;
```

### Why these choices

| Decision | Reason |
|---|---|
| `LEFT JOIN` instead of `INNER JOIN` | Some employees do not have payment records. Since the question asks for each employee, they should still appear in the result. |
| `COALESCE(SUM(p.Value), 0)` | Employees without payment records would otherwise have `NULL` as their total. `COALESCE` displays this as `0`. |
| `GROUP BY e.EmployeeID, e.FirstName, e.LastName` | Grouping by `EmployeeID` avoids accidentally combining employees who may have the same name and surname. |
| `ORDER BY TotalAmount DESC` | This makes the result easier to read by showing the highest total amount first. |

### Output

```
FirstName | LastName | TotalAmount
----------+----------+------------
John      | John     | 992
Sarah     | Lebat    | 648
Jon       | Dallas   | 0
Gheorghe  | Honey    | 0
Anton     | Savar    | 0
```

---

## Query 2 - Employees whose first name starts with "J"

```sql
SELECT
    EmployeeID,
    FirstName,
    LastName,
    City,
    State
FROM  Employee
WHERE FirstName LIKE 'J%';
```

### Why these choices

| Decision | Reason |
|---|---|
| `LIKE 'J%'` | The `%` wildcard matches any characters after `J`, so it returns all first names beginning with `J`. |
| Filtering `FirstName` | In the given employee table, the employee's name is represented by the `FirstName` column. |

### Output

```
EmployeeID | FirstName | LastName | City | State
-----------+-----------+----------+------+------
10330      | John      | John     | NY   | NY
11012      | Jon       | Dallas   | NY   | NY
```

---

## Files

| File | Description |
|------|-------------|
| `schema.sql` | Creates the tables and inserts sample data |
| `queries.sql` | The two answer queries |
