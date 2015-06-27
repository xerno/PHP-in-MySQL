
-- Name: Format a number with grouped thousands, like number_format() from PHP
-- Author: Zdenek Kops, https://github.com/xerno
-- Year: 2015
-- Difference: you have to call function with all arguments, at least with empty strings


DROP FUNCTION IF EXISTS number_format;

DELIMITER $$

CREATE FUNCTION number_format(
      number TEXT,        -- required
      decimals INT,       -- required
      dec_point TEXT,     -- at least empty string
      thousands_sep TEXT  -- at least empty string
   )
   RETURNS TEXT
   COMMENT "Format a number with grouped thousands, like PHP's number_format(). https://github.com/xerno/PHP-in-MySQL"
   LANGUAGE SQL
   DETERMINISTIC
   BEGIN

      IF number IS NULL THEN  -- protection against freezing
         RETURN "";
      END IF;

      -- any next variable testing is necessary for bad use and bad performance only

      RETURN REPLACE(REPLACE(REPLACE(FORMAT(number, decimals), ",", "#"), ".", dec_point), "#", thousands_sep);
   END;
