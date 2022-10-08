CREATE DATABASE lesson6;
USE lesson6;

-- 1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- 		Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP FUNCTION converTime;
delimiter $$
CREATE FUNCTION converTime (num BIGINT)
RETURNS VARCHAR(250)
deterministic
BEGIN
	DECLARE dDay BIGINT DEFAULT 0;
    DECLARE hHour BIGINT DEFAULT 0;
    DECLARE mMin BIGINT DEFAULT 0;
    DECLARE sSec BIGINT DEFAULT 0;
    DECLARE res VARCHAR(250) DEFAULT '';
    
	IF num < 0 THEN
		SET res = 'Это отрицательное число';
	ELSE
		SET dDAY = FLOOR(num/86400); -- кол-во дней
		SET hHour = FLOOR((num % 86400)/3600); -- остаток часов
		SET mMin = FLOOR((num % 3600)/60); -- остаток минут
		SET sSec = num % 60;
		SET res = CONCAT(num, ' это ',dDay,' дней ',hHour,' часов ',mMin,' минут ',sSec,' секунд ');
    END IF;
	RETURN res;
END $$
delimiter ;

SELECT converTime(548900051554151210);

-- 2.	Выведите только четные числа от 1 до 10 включительно.
-- 		Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)

DROP FUNCTION even;
delimiter $$
CREATE FUNCTION even(num INT) -- немного не по заданию - будем выводить от 1 до num
RETURNS VARCHAR(200)
deterministic
BEGIN
	DECLARE tmp INT;
    DECLARE res VARCHAR(200);
    SET tmp = 2;
    SET res = '';
    IF num <= 1 THEN
		SET res = 'Число должно быть больше 1';
	ELSE
		IF (num % 2) != 0 THEN
			SET num = num - 1;
		END IF;
        REPEAT
			SET res = CONCAT_WS(',',res,tmp);
            SET tmp = tmp + 2;
            UNTIL tmp > num
		END REPEAT;
    END IF;
    RETURN RIGHT(res, LENGTH(res)-1);
END $$;
delimiter ;

SELECT even(19);
    
		
        
    
