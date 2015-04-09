
-- Name: Wrap a string to a given number of characters, similar to wordwrap() from PHP
-- Author: Zdenek Kops, https://github.com/xerno
-- Year: 2015
-- Difference: you have to call function with all arguments!


DROP FUNCTION IF EXISTS wordwrap;

DELIMITER $$

CREATE FUNCTION wordwrap(
      input TEXT,  -- required
      width INT,   -- required
      break TEXT,  -- required
      cut INT      -- required, 0=false, 1=true
   )
   RETURNS TEXT
   COMMENT "Wraps a string to a given number of characters, similar to PHP's wordwrap(). https://github.com/xerno/PHP-in-MySQL"
   LANGUAGE SQL
   DETERMINISTIC
   BEGIN
      DECLARE output TEXT;
      DECLARE length INT;
      DECLARE input_index INT;
      DECLARE line TEXT;
      DECLARE i INT;

      SET length = CHAR_LENGTH(input);

      IF input IS NULL  -- protection against freezing
         OR width < 1
         OR cut NOT IN(0, 1)
         OR length <= width  -- speed-up
      THEN
         RETURN input;
      END IF;

      SET output = "";
      SET input_index = 1;

      lins: LOOP  -- lines is not available, it is a keyword
         IF input_index+width >= length THEN
            RETURN CONCAT(output, SUBSTRING(input, input_index));
         END IF;

         SET line = SUBSTRING(input, input_index, width);
         IF line REGEXP "[[:space:]]" THEN

            -- IF LENGTH(TRIM(line)) = 0 THEN  -- if do not want to brake empty lines, just uncomment all and be better than PHP :)
               -- SET output = CONCAT(output, line);
               -- SET input_index = input_index + width;
            -- ELSE

               SET i = width-1;
               chars: LOOP
                  IF SUBSTRING(line, i, 1) REGEXP "[[:space:]]" OR i<3 THEN
                     LEAVE chars;
                  END IF;
                  SET i = i-1;
               END LOOP chars;
               SET i = i-1;
               SET output = CONCAT(output, SUBSTRING(line, 1, i), break);
               SET input_index = input_index + i + 1;

            -- END IF;

         ELSE

            SET output = CONCAT(output, line);
            IF cut=1 THEN
               SET output = CONCAT(output, break);
            END IF;
            SET input_index = input_index + width;

         END IF;

      END LOOP lins;

   END;