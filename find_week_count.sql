DELIMITER //

-- find_week_count('2019-01-01', '2019-01-31', 'Sunday,Monday')

DROP FUNCTION  IF EXISTS `find_week_count`//

CREATE DEFINER=`root`@`localhost` FUNCTION `find_week_count`(start_date DATE, end_date DATE, week_list VARCHAR(255)) RETURNS int(11)
	READS SQL DATA
	DETERMINISTIC
BEGIN

	DECLARE crt_date DATE;
	DECLARE idx INT DEFAULT 0;
	SET crt_date = start_date;
	
	WHILE crt_date <= end_date DO
		IF FIND_IN_SET(DAYNAME(crt_date), week_list) THEN
			SET idx = idx + 1;
		END IF;
		SET crt_date = ADDDATE(crt_date, INTERVAL 1 DAY);
	END WHILE;

	RETURN idx;

END//


DELIMITER ;