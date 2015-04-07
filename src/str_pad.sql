
-- Name: Pad a string to a certain length with another string, like str_pad() from PHP
-- Author: Zdenek Kops, https://github.com/xerno
-- Year: 2015
-- Difference: you have to call function with all arguments, at least with empty strings


DROP FUNCTION IF EXISTS str_pad;

DELIMITER $$

CREATE FUNCTION str_pad(
      input TEXT,       -- reuquired
      pad_length INT,   -- reuquired
      pad_string TEXT,  -- at least empty string, will be changed to a space
      pad_type TEXT     -- at least empty string, will be changed to "STR_PAD_RIGHT"
   )
   RETURNS TEXT
   COMMENT "Pad a string to a certain length with another string, like PHP's str_pad(). https://github.com/xerno/PHP-in-MySQL"
   LANGUAGE SQL
   DETERMINISTIC
   BEGIN
      DECLARE length INT;
      DECLARE lft INT;  -- left is a keyword
      DECLARE rgt INT;  -- right is a keyword
      DECLARE side FLOAT;

      IF input IS NULL THEN  -- protection against freezing
         RETURN "";
      END IF;
      IF pad_length IS NULL THEN  -- protection against freezing
         RETURN input;
      END IF;

      SET length = LENGTH(input);
      IF pad_length<1 THEN
         return input;
      ELSEIF pad_length<=length THEN
         return input;
      END IF;

      IF pad_string="" THEN
         SET pad_string = " ";
      END IF;

      IF pad_type="STR_PAD_BOTH" THEN
         SET side = (pad_length-length) / 2 + length;
         SET lft = FLOOR(side);
         SET rgt = CEIL(side);
         RETURN CONCAT(SUBSTRING(LPAD(input, lft, pad_string), 1, lft-length), RPAD(input, rgt, pad_string));

      ELSEIF pad_type="STR_PAD_LEFT" THEN
         RETURN LPAD(input, pad_length, pad_string);

      ELSE
         RETURN RPAD(input, pad_length, pad_string);  -- STR_PAD_RIGHT, default

      END IF;
   END;
