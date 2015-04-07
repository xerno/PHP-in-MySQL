
-- Name: URL-encode according to RFC 3986, like rawurlencode() from PHP
-- Author: Zdenek Kops, https://github.com/xerno
-- Year: 2015


DROP FUNCTION IF EXISTS rawurlencode;

DELIMITER $$

CREATE FUNCTION rawurlencode(input TEXT)
   RETURNS TEXT
   COMMENT "URL-encode according to RFC 3986, like PHP's rawurlencode(). https://github.com/xerno/PHP-in-MySQL"
   LANGUAGE SQL
   DETERMINISTIC
   BEGIN
      DECLARE output TEXT;
      DECLARE length INT;
      DECLARE i INT;
      DECLARE chr VARCHAR(1);  -- char is not available, it is a keyword
      DECLARE temp VARCHAR(10);
      DECLARE temp_length TINYINT;
      DECLARE p TINYINT;

      IF input IS NULL OR input REGEXP "^[A-Za-z0-9_.~-]+$" THEN  -- protection against freezing and speed-up
         RETURN input;
      END IF;

      SET output = "";
      SET length = CHAR_LENGTH(input);
      SET i = 1;

      chars: LOOP
         IF i>length THEN
            LEAVE chars;
         END IF;

         SET chr = SUBSTRING(input, i, 1);
         IF chr REGEXP "[A-Za-z0-9_.~-]" THEN
            SET output = CONCAT(output, chr);
         ELSE

            SET temp = HEX(chr);
            SET temp_length = LENGTH(temp);
            IF temp_length=2 THEN  -- speed-up
               SET output = CONCAT(output, "%", temp);
            ELSE

               SET p = 1;
               percentage: LOOP
                  IF p>temp_length THEN
                     LEAVE percentage;
                  END IF;
                  SET output = CONCAT(output, "%", SUBSTRING(temp, p, 2));
                  SET p = p+2;
               END LOOP percentage;

            END IF;

         END IF;

         SET i = i+1;

      END LOOP chars;

      RETURN output;

   END;
