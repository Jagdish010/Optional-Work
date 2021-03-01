DELIMITER //

DROP FUNCTION  IF EXISTS `csec_to_hours`//
CREATE DEFINER=`root`@`localhost` FUNCTION `csec_to_hours`(total_working_hours BIGINT) RETURNS VARCHAR(126) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
	READS SQL DATA
	DETERMINISTIC
BEGIN
	DECLARE TimeinSecond BIGINT;
	DECLARE Hours INT;
	DECLARE Mins INT;
	DECLARE Secs INT;
	
	SET TimeinSecond = total_working_hours;
	SET Hours = TimeinSecond / 3600;
	SET Mins = (TimeinSecond /60) % 60;
	SET Secs = TimeinSecond % 60;

	RETURN concat(Hours, ':', Mins, ':', Secs);

END//

DROP FUNCTION  IF EXISTS `sec_to_hours`//

CREATE DEFINER=`root`@`localhost` FUNCTION `sec_to_hours`(TimeinSecond BIGINT) RETURNS VARCHAR(255)
	READS SQL DATA
	DETERMINISTIC
BEGIN

	DECLARE Hours INT;
	DECLARE Mins INT;
	DECLARE Secs INT;
	
	SET Secs = SUBSTRING_INDEX(TimeinSecond % 60, '.', 1);
	SET Mins = SUBSTRING_INDEX(((TimeinSecond - Secs) / 60) % 60, '.', 1);
	SET Hours = SUBSTRING_INDEX((TimeinSecond - Mins) / 3600, '.', 1);

	-- RETURN CONCAT(IF(CHAR_LENGTH(Hours) = 1, LPAD(Hours, 2, 0), Hours), ':', LPAD(Mins,2,0), ':', LPAD(Secs, 2, 0));
	RETURN CONCAT(IF(CHAR_LENGTH(Hours) = 1, LPAD(Hours, 2, 0), Hours), ':', LPAD(Mins, 2, 0));

END//

DELIMITER;