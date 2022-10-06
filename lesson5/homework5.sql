CREATE database lesson5;
USE lesson5;
CREATE TABLE cars
(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(20),
    cost INT);
INSERT INTO cars (name, cost)
VALUES 
('Audi',52642),
('Mercedes',57127),
('Skoda',9000),
('Volvo',29000),
('Bentley',350000),
('Citroen',21000),
('Hummer',41400),
('Volkswagen',21600);

-- 1.	Создайте представление, в которое попадут автомобили стоимостью 
--      до 25 000 долларов

CREATE VIEW lowcost_cars AS
SELECT * FROM cars
WHERE cost < 25000;
SELECT * FROM lowcost_cars;

-- 2.	Изменить в существующем представлении порог для стоимости: 
--      пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

ALTER VIEW lowcost_cars AS
SELECT * FROM cars
WHERE cost < 30000;

SELECT * FROM lowcost_cars;

-- 3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE VIEW checkcars AS
SELECT * FROM cars
WHERE name IN ('Skoda','Audi');
SELECT * FROM checkcars;

-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
CREATE TABLE Analysis
(
	an_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    an_name VARCHAR(40),
    an_cost INT,
    an_price INT
);
INSERT INTO Analysis (an_name,an_cost,an_price)
VALUES
('НОШПА',5,10),
('АНАЛЬГИН',10,20),
('ВАЛИДОЛ',3,5),
('ЛОПЕРАМИД',13,24),
('ТЕТРАЦИКЛИН',3,9);

CREATE TABLE Orders
(
	ord_id INT NOT NULL,
    ord_datetime DATETIME,
    ord_an INT
);
INSERT INTO Orders (ord_id,ord_datetime,ord_an)
VALUES
(34,ADDDATE('2020-02-05',7),3),
(45,ADDDATE('2020-02-05',10),4),
(78,ADDDATE('2020-02-05',9),6),
(22,ADDDATE('2020-02-05',3),1),
(6,ADDDATE('2020-02-05',5),2);

SELECT an.an_name, an.an_price 
FROM Analysis an
WHERE EXISTS
(SELECT * FROM Orders ord
WHERE ord_an=an_id AND ord.ord_datetime >= DATE('2020-02-05') AND ord.ord_datetime < ADDDATE('2020-02-05',7));

-- Добавьте новый столбец под названием «время до следующей станции». 
-- Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
-- Мы можем вычислить это значение без использования оконной функции SQL, 
-- но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD . 
-- Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
-- В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.

CREATE TABLE travel_time
(
	train_id INT NOT NULL,
    station VARCHAR(20),
    station_time TIME
);
INSERT INTO travel_time
VALUES
(110,'San Francisco','10:00:00'),
(110,'Redwood City','10:54:00'),
(110,'Palo Alto','11:02:00'),
(110,'San Jose','12:35:00'),
(120,'San Francisco','11:00:00'),
(120,'Palo Alto','12:49:00'),
(120,'San Jose','13:30:00');

SELECT 
	train_id, 
    station, 
    station_time,
	IFNULL
		(
			TIMEDIFF
				(
					LEAD(station_time) OVER(PARTITION BY train_id), station_time
				), ''
		) time_to_next_station
FROM travel_time;

