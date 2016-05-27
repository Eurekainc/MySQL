DROP FUNCTION IF EXISTS `stripSpecialChars`;
DELIMITER ;;
CREATE FUNCTION `stripSpecialChars`(`dirty_string` varchar(2048)) RETURNS varchar(2048) CHARSET utf8
BEGIN
/**
 * MySQL function to remove Special characters, Non-ASCII,hidden characters leads to spaces, accents etc
 * Downloaded from http://DevZone.co.in
 * @param VARCHAR dirty_string : dirty string as input
 * @return VARCHAR clean_string : clean string as output
 * 
 * Usage Syntax: stripSpeciaChars(string);
 * Usage SQL> SELECT stripSpeciaChars("sdfa7987*&^&*ÂÃ ÄÅÆÇÈÉÊ sd sdfgËÌÍÎÏÑ ÒÓÔÕÖØÙÚàáâã sdkarkhru");
 * result : sdfasdsdfgsdkarkhru
 */
      DECLARE clean_string VARCHAR(2048) DEFAULT '';
      DECLARE c VARCHAR(2048) DEFAULT '';
      DECLARE counter INT DEFAULT 1;
	  
      IF ISNULL(dirty_string) THEN
            RETURN NULL;
      ELSE
	  
	   -- return numbers and Alphabets in result
        WHILE counter <= LENGTH(dirty_string) DO
                   
             SET c = MID(dirty_string, counter, 1);

				  -- check if special character
				  IF ASCII(c) >= 192 AND ASCII(c) <= 198 THEN
					SET clean_string = CONCAT(clean_string, 'A');
				  ELSEIF ASCII(c) = 199 THEN
					SET clean_string = CONCAT(clean_string, 'C');
				  ELSEIF ASCII(c) >= 200 AND ASCII(c)<=203 THEN
					SET clean_string = CONCAT(clean_string, 'E');
				  ELSEIF ASCII(c) >=204 AND ASCII(c)<=207 THEN
					SET clean_string = CONCAT(clean_string, 'I');
				  ELSEIF ASCII(c) = 208 THEN
					SET clean_string = CONCAT(clean_string, 'D');
				  ELSEIF ASCII(c) = 209 THEN
					SET clean_string = CONCAT(clean_string, 'N');
				  ELSEIF (ASCII(c) >=210 AND ASCII(c)<=214) OR (ASCII(c) = 216) THEN
				    SET clean_string = CONCAT(clean_string, 'O');
				  ELSEIF ASCII(c) >=217 AND ASCII(c)<=220 THEN
				    SET clean_string = CONCAT(clean_string, 'U');
				  ELSEIF ASCII(c) >=224 AND ASCII(c)<=230 THEN
				    SET clean_string = CONCAT(clean_string, 'a');
				  ELSEIF ASCII(c) = 231 THEN
				    SET clean_string = CONCAT(clean_string, 'c');
				  ELSEIF ASCII(c) >= 232 AND ASCII(c) <= 235 THEN
				    SET clean_string = CONCAT(clean_string, 'e');
				  ELSEIF ASCII(c) >= 236 AND ASCII(c) <= 239 THEN
				    SET clean_string = CONCAT(clean_string, 'i');
				  ELSEIF ASCII(c) = 241 THEN
				    SET clean_string = CONCAT(clean_string, 'n');				  
				  ELSEIF (ASCII(c) >= 242 AND ASCII(c) <= 246) OR (ASCII(c)=248) THEN
				    SET clean_string = CONCAT(clean_string, 'o');
				  ELSEIF ASCII(c) >=249 AND ASCII(c)<=252 THEN
				    SET clean_string = CONCAT(clean_string, 'u');
				  ELSEIF ASCII(c) >= 253 AND ASCII(c) <=255 THEN
					SET clean_string = CONCAT(clean_string, 'y');
				  ELSEIF ASCII(c) = 221 OR ASCII(c) = 159 THEN
					SET clean_string = CONCAT(clean_string, 'Y');
				  ELSEIF ASCII(c) = 158 THEN
					SET clean_string = CONCAT(clean_string, 'z');
				  ELSEIF ASCII(c) = 142 THEN
					SET clean_string = CONCAT(clean_string, 'Z');
				  ELSEIF ASCII(c) = 154 THEN
					SET clean_string = CONCAT(clean_string, 's');
				  ELSEIF ASCII(c) = 138 THEN
					SET clean_string = CONCAT(clean_string, 'S');					
				  ELSEIF ASCII(c) = 32 OR ASCII(c) >= 48 AND ASCII(c) <= 57 OR ASCII(c) >= 65 AND ASCII(c) <= 90  OR ASCII(c) >= 97 AND ASCII(c) <= 122 THEN
                    SET clean_string = CONCAT(clean_string, c);
                  ELSE
					SET clean_string = CONCAT(clean_string, '_');					
				  END IF;

                  SET counter = counter + 1;
        END WHILE;		
      END IF;
  
      RETURN clean_string;
END
;;
DELIMITER ;