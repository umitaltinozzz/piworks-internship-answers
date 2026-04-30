-- ============================================================
--  Schema and sample data for the Employee / Payments question.
--  Portable SQL (works on SQLite, PostgreSQL, MySQL, SQL Server).
-- ============================================================

DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmployeeID INTEGER      PRIMARY KEY,
    FirstName  VARCHAR(50)  NOT NULL,
    LastName   VARCHAR(50)  NOT NULL,
    City       VARCHAR(50),
    State      VARCHAR(50)
);

CREATE TABLE Payments (
    EmployeeID  INTEGER      NOT NULL,
    SalaryDate  VARCHAR(20)  NOT NULL,  -- month name as given in the question
    MonthID     INTEGER      NOT NULL,
    Value       DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- ---- Employee rows (from the question image) ----
INSERT INTO Employee (EmployeeID, FirstName, LastName, City,      State)  VALUES
    (10330, 'John',     'John',   'NY',        'NY'),
    (10449, 'Sarah',    'Lebat',  'Melbourne', 'Bourke'),
    (11012, 'Jon',      'Dallas', 'NY',        'NY'),
    (11013, 'Gheorghe', 'Honey',  'NY',        'NY'),
    (11014, 'Anton',    'Savar',  'NY',        'NY');

-- ---- Payments rows (from the question image) ----
INSERT INTO Payments (EmployeeID, SalaryDate,  MonthID, Value) VALUES
    (10330, 'June',      6,  128),
    (10330, 'July',      7,  158),
    (10330, 'August',    8,  133),
    (10330, 'September', 9,  120),
    (10330, 'October',   10, 188),
    (10330, 'November',  11, 160),
    (10330, 'December',  12, 105),
    (10449, 'September', 9,  150),
    (10449, 'October',   10, 158),
    (10449, 'November',  11, 160),
    (10449, 'December',  12, 180);
