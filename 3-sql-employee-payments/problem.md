# Problem Statement

Given the following two tables:

**Employee**

| EmployeeID | FirstName | LastName | City      | State  |
|:----------:|-----------|----------|-----------|--------|
| 10330      | John      | John     | NY        | NY     |
| 10449      | Sarah     | Lebat    | Melbourne | Bourke |
| 11012      | Jon       | Dallas   | NY        | NY     |
| 11013      | Gheorghe  | Honey    | NY        | NY     |
| 11014      | Anton     | Savar    | NY        | NY     |

**Payments**

| EmployeeID | Salary Date | MonthID | Value $ |
|:----------:|-------------|:-------:|--------:|
| 10330      | June        | 6       | 128     |
| 10330      | July        | 7       | 158     |
| 10330      | August      | 8       | 133     |
| 10330      | September   | 9       | 120     |
| 10330      | October     | 10      | 188     |
| 10330      | November    | 11      | 160     |
| 10330      | December    | 12      | 105     |
| 10449      | September   | 9       | 150     |
| 10449      | October     | 10      | 158     |
| 10449      | November    | 11      | 160     |
| 10449      | December    | 12      | 180     |

Write SQL queries to answer the following:

1. Display the total amount earned by each employee.
2. Display the employees whose first name starts with the letter "J".
