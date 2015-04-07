
SELECT rawurldecode(CONCAT("karel%", rawurlencode("함"), "%A"));  -- result must be: karel%함%A
