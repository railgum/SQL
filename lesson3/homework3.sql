USE lesson3;
-- 1 блок -----
CREATE TABLE salespeople
(
	snum INT NOT NULL,
    sname VARCHAR(20),
    city VARCHAR(20),
    COMM VARCHAR(10)
);
INSERT salespeople (snum, sname, city, comm)
VALUES
	(1001,'Peel','London','.12'),
	(1002,'Serres','San Jose','.13'),
	(1004,'Motika','London','.11'),
	(1007,'Rifkin','Barcelona','.15'),
	(1003,'Axelrod','New York','.10');
    
CREATE TABLE customers
(
    cnum INT NOT NULL,
    cname VARCHAR(20),
    city VARCHAR(15),
    rating INT,
    snum INT
);

INSERT customers (cnum, cname, city, rating, snum)
VALUES 
	(2001,'Hoffman','London',100,1001),
	(2002,'Giovanni','Rome',200,1003),
	(2003,'Liu','SanJose',200,1002),
	(2004,'Grass','Berlin',300,1002),
	(2006,'Clemens','London',100,1001),
	(2008,'Cisneros','SanJose',300,1007),
	(2007,'Pereira','Rome',100,1004);

ALTER TABLE salespeople CHANGE COMM comm VARCHAR(10);
CREATE TABLE orders
(
	onum INT NOT NULL,
    amt DECIMAL(5,2),
    odate VARCHAR(20),
    cnum INT,
    snum INT
);
ALTER TABLE orders CHANGE amt amt DECIMAL(8,2);
INSERT orders (onum,amt,odate,cnum,snum)
VALUES
	(3001,18.69,'10/03/1990',2008,1007),
	(3003,767.19,'10/03/1990',2001,1001),
	(3002,1900.10,'10/03/1990',2007,1004),
	(3005,5160.45,'10/03/1990',2003,1002),
	(3006,1098.16,'10/03/1990',2008,1007),
	(3009,1713.23,'10/04/1990',2002,1003),
	(3007,75.75,'10/04/1990',2004,1002),
	(3008,4723.00,'10/05/1990',2006,1001),
	(3010,1309.95,'10/06/1990',2004,1002),
	(3011,9891.88,'10/06/1990',2006,1001);
    
-- 1----
SELECT city, sname, snum, comm FROM salespeople;

-- 2----
SELECT rating, cname FROM customers WHERE city = 'SanJose';    

-- 3----
SELECT DISTINCT snum FROM salespeople;

-- 4----
SELECT cname 
FROM customers
WHERE cname LIKE 'G%';

-- 5----
SELECT * FROM orders
WHERE amt > 1000;

-- 6----
SELECT MIN(amt) 'Минимальный заказ' FROM orders;

-- 7----
SELECT * 
FROM customers
WHERE rating > 100 AND city != 'Rome';

-- 2 блок -----

CREATE TABLE staff
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar(45),
    surname varchar(45),
    specialty varchar(45),
    seniority INT,
    salary INT,
    age INT
);

INSERT staff (name, surname, specialty, seniority,salary, age)
VALUES
	("Вася", "Васькин", "начальник", 40, 100000, 60),
    ("Петя", "Петькин", "начальник", 8, 100000, 30),
    ("Катя", "Каткина", "инженер", 2, 70000, 25),
    ("Саша", "Сашкин", "инженер", 12, 50000, 35),
    ("Иван", "Иванов", "рабочий", 40, 30000, 59),
    ("Петр", "Петров", "рабочий", 20, 25000, 40),
    ("Сидор", "Сидоров", "рабочий", 10, 20000, 35),
    ("Антон", "Антонов", "рабочий", 8, 19000, 28),
    ("Юра", "Юркин", "рабочий", 5, 15000, 25),
    ("Максим", "Воронин", "рабочий", 2, 11000, 22),
    ("Юра", "Галкин", "рабочий", 3, 12000, 24),
    ("Люся", "Люськина", "уборщик", 10, 10000, 49);
  
-- 1----
SELECT * FROM staff
ORDER BY salary;
SELECT * FROM staff
ORDER BY salary DESC;

-- 2----
SELECT * FROM
(SELECT * FROM staff ORDER BY salary DESC LIMIT 5) AS temp
ORDER BY salary;

-- 3----
SELECT specialty FROM staff
GROUP BY specialty
HAVING SUM(salary)>100000;

