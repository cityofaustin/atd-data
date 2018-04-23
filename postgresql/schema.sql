CREATE SCHEMA api;

CREATE TABLE IF NOT EXISTS api.jobs (
  id SERIAL,
  name TEXT,
  start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  end_date TIMESTAMP WITH TIME ZONE,
  message TEXT,
  status TEXT,
  PRIMARY KEY (id)
);

CREATE ROLE web_anon NOLOGIN;
GRANT web_anon TO <authenticated user name>;
GRANT usage ON schema api TO web_anon;
GRANT SELECT ON api.jobs TO web_anon;

CREATE ROLE jobs_user NOLOGIN;
GRANT jobs_user TO <authenticated user name>;
GRANT USAGE ON SCHEMA api TO jobs_user;
GRANT ALL ON api.jobs TO jobs_user;
GRANT USAGE, SELECT ON SEQUENCE api.jobs_id_seq TO jobs_user;















