-- В чем разница между "where" и "having"?
-- "where" - сортировка , фильтрa
-- "having"- идет в паре с group by

-- ORDER BY и GROUP BY - разница?
-- ORDER BY - сортировка
-- GROUP BY - группировка

-- Создание таблички
CREATE TABLE Staff
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar(45),
    surname varchar(45),
    specialty varchar(45),
    seniority INT,
    salary INT,
    age INT
);

-- Заполнение таблички значениями
INSERT INTO Staff (name, surname, specialty, seniority,salary, age)
VALUES
	("Вася", "Васькин", "начальник", 40, 100000, 60),
    ("Петя", "Васькин", "начальник", 8, 100000, 30),
    ("Екатерина", "Катькина", "инженер", 2, 70000, 30),
    ("Екатерина", "Сашкина", "инженер", 6, 80000, 40),
    ("Антон", "Катькин", "сотрудник", 1, 30000, 23),
    ("Юра", "Галкин", "рабочий", 5, 30000, 28);

SELECT * FROM Staff;

-- ORDER BY - сортировка

-- По воз-ю поле "возраст"
SELECT *
FROM Staff
ORDER BY age; -- По возрастанию (ASC)
-- DESC - по убыванию, по дефолту - по возрастанию (ASC)
-- Сортировка по имени, отсортируем по убыванию
SELECT *
FROM Staff
ORDER BY name DESC;
-- Сортировка по возрасту и имени по убыванию 
SELECT *
FROM Staff
ORDER BY age , name DESC;

-- Операторы сортировки
-- DISTINCT - уникальные значения (без повторов)
-- LIMIT - вывод конкретного кол-ва строк

#1.	Выведите уникальные (неповторяющиеся) значения полей "name"
SELECT DISTINCT name 
FROM Staff;
#2.	Выведите первые две первые записи из таблицы
SELECT *
FROM Staff
LIMIT 2; -- Первые 2 строчки (если указан 1 параметр)
#3.	Пропустите  первые 4 строки ("id" = 1, "id" = 2,"id" = 3,"id" = 4)
# и извлеките следующие 3 строки ("id" = 5, "id" = 6, "id" = 7)
SELECT *
FROM Staff
LIMIT 4, 3; -- Выводятся все строчки, начиная от 4+1 (5) и +3
#4*. 	Пропустите две последние строки (где id=12, id=11) и
# извлекаются следующие за ними 3 строки (где id=10, id=9, id=8)
SELECT *
FROM Staff
ORDER BY id DESC # Сортировка дала нам табличку, где id идут от 7 -> 1
LIMIT 2,3;

-- Агрегатные функции (из набора данных получается 1 значение)

-- 1.	Рассчитайте общее количество сотрудников нашей фирмы
SELECT COUNT(id)
FROM Staff;
-- 2.	Выведите общий трудовой стаж по каждому имени (с помощью предложения GROUP BY)  
SELECT name, SUM(seniority)
FROM Staff
GROUP BY name; # У "Вася" стаж: 40+6 и так далее
-- 3.	Посчитайте количество записей в таблице: строчки с NULL не учитываются
SELECT COUNT(salary)
FROM Staff;
-- 4.	Выведите количество имен, которые являются уникальными 
SELECT COUNT( DISTINCT name ) AS count_name-- alias - псевдоним
FROM Staff;
-- 5. 	Найдите средюю зарплату по нашей фирме
SELECT AVG(salary), SUM(salary) / COUNT(salary) # AVG = SUM / COUNT
FROM Staff;

SELECT FLOOR(1.222222222); -- В меньшую сторону
SELECT CEIL(1.222222222); -- В большую сторону
SELECT ROUND(1.222222222, 3); -- Число "1.222222222" до 3 знаков после запятой
SELECT length("Hello"); -- Длина строчки - 5 символов

-- GROUP BY: несколько дублирующих значений -> 1 группа
-- Сгруппируйте поля по возрасту. 
-- Для каждой группы  найдите суммарную зарплату 
SELECT name, age, salary
FROM Staff 
GROUP BY name;
-- Сгруппируйте поля по возрасту (будет 3 группы - 23 года, 24 года и 25 лет).
-- Найдите максимальную заработную плату внутри группы
SELECT name, MAX(salary)
FROM Staff 
GROUP BY name;
-- Сгруппируйте поля по возрасту (будет 3 группы - 23 года, 24 года и 25 лет). 
-- Найдите минимальную заработную плату внутри группы
SELECT name, MIN(salary)
FROM Staff 
GROUP BY name;

-- HAVING

-- Выведем те группы,  в которых количество
-- строк меньше или равно 2. Группировка по имени
SELECT *
FROM Staff 
GROUP BY name
HAVING COUNT(*) BETWEEN 1 AND 2; -- [1;2] 
-- BETWEEN левая_граница AND правая_граница [левая ; правая]
SELECT *
FROM Staff 
GROUP BY name
HAVING COUNT(*) IN (4,5);  -- От 1 до 2 раз встречается имя в группе





