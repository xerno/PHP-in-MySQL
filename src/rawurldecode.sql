
-- Name: Decode URL-encoded strings, like rawurldecode() from PHP
-- Author: Zdenek Kops, https://github.com/xerno
-- Year: 2015


DROP FUNCTION IF EXISTS rawurldecode;

DELIMITER $$

CREATE FUNCTION rawurldecode(input TEXT)
   RETURNS TEXT
   COMMENT "Decode URL-encoded strings, like PHP's rawurldecode(). https://github.com/xerno/PHP-in-MySQL"
   LANGUAGE SQL
   DETERMINISTIC
   BEGIN
      DECLARE output TEXT;
      DECLARE length INT;
      DECLARE i INT;
      DECLARE chr VARCHAR(1);  -- char is not available, it is a keyword
      DECLARE start_at INT;
      DECLARE end_at INT;
      DECLARE to_decode TEXT;
      DECLARE decoded TEXT;

      IF input IS NULL OR input NOT REGEXP "%" THEN  -- protection against freezing and speed-up
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
         IF SUBSTRING(input, i, 3) NOT REGEXP "^%[0-9A-F]+$" THEN
            SET output = CONCAT(output, chr);
         ELSE
            SET start_at = i;

            filling: LOOP
               IF i+2 > length OR SUBSTRING(input, i, 3) NOT REGEXP "^%[0-9A-F]+$" THEN
                  SET end_at = i;
                  LEAVE filling;
               ELSE
                  SET i = i+3;
               END IF;
            END LOOP filling;

            IF end_at>start_at THEN
               SET to_decode = REPLACE(SUBSTRING(input, start_at, end_at-start_at), "%", "");
               SET decoded = UNHEX(to_decode);
               -- IF LENGTH(decoded) = LENGTH(to_decode)/2 THEN  -- uncomment all if want to write some smart fallback
                  SET output = CONCAT(output, decoded);
               -- ELSE
                  -- SET output = CONCAT(output, decoded);
               -- END IF;
               IF i+2 > length THEN
                  RETURN CONCAT(output, SUBSTRING(input, i));  -- must not continue!
               END IF;
            END IF;

         END IF;

         SET i = i+1;

      END LOOP chars;

      RETURN output;

   END;
