CREATE SCHEMA api;

CREATE TABLE IF NOT EXISTS api.jobs (
  id SERIAL PRIMARY KEY,
  name TEXT,
  start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  end_date TIMESTAMP WITH TIME ZONE,
  message TEXT,
  status TEXT,
  records_processed INTEGER,
  source TEXT,
  destination TEXT
);

# create view of the most recent job for each distrct job name
CREATE VIEW api.jobs_latest AS
SELECT DISTINCT ON (name) name, start_date, end_date, status, message, records_processed, source, destination, id FROM api.jobs order by name, start_date DESC;

CREATE ROLE web_anon NOLOGIN;
GRANT web_anon TO <authenticated user name>;
GRANT usage ON schema api TO web_anon;
GRANT SELECT ON api.jobs TO web_anon;
GRANT SELECT ON api.jobs_latest TO web_anon;

CREATE ROLE jobs_user NOLOGIN;
GRANT jobs_user TO <authenticated user name>;
GRANT USAGE ON SCHEMA api TO jobs_user;
GRANT ALL ON api.jobs TO jobs_user;
GRANT USAGE, SELECT ON SEQUENCE api.jobs_id_seq TO jobs_user;

















