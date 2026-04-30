-- ============================================================
--  Answers for the two questions.
-- ============================================================

-- -------------------------------------------------------------
--  Q1. Total amount earned by each employee (by name and surname).
--  Use LEFT JOIN so employees with zero payments still appear
--  (with NULL -> 0).
-- -------------------------------------------------------------
SELECT
    e.FirstName,
    e.LastName,
    COALESCE(SUM(p.Value), 0) AS TotalAmount
FROM       Employee e
LEFT JOIN  Payments p ON p.EmployeeID = e.EmployeeID
GROUP BY   e.EmployeeID, e.FirstName, e.LastName
ORDER BY   TotalAmount DESC, e.LastName, e.FirstName;


-- -------------------------------------------------------------
--  Q2. All employees whose first name starts with the letter "J".
-- -------------------------------------------------------------
SELECT
    EmployeeID,
    FirstName,
    LastName,
    City,
    State
FROM  Employee
WHERE FirstName LIKE 'J%';
