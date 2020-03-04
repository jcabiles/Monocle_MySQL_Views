use ccgi_staging;
CREATE OR REPLACE VIEW execution_log_today AS
SELECT * FROM execution_log
WHERE asctime >= date(CURDATE());


use ccgitranscripts;
CREATE OR REPLACE VIEW execution_log_today AS
SELECT * FROM execution_log
WHERE asctime >= date(CURDATE());