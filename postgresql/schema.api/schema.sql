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

COMMENT ON TABLE api.jobs IS
  'Austin Transportation ETL job records.';

COMMENT ON COLUMN api.jobs.start_date IS
  'The date/time the job was started';

CREATE TABLE IF NOT EXISTS api.traffic_reports (
  traffic_report_id TEXT PRIMARY KEY,
  published_date TIMESTAMP WITH TIME ZONE,
  address TEXT,
  issue_reported TEXT,
  latitude DECIMAL,
  longitude DECIMAL,
  traffic_report_status TEXT,
  traffic_report_status_date_time TIMESTAMP WITH TIME ZONE,
);

CREATE ROLE super_user NOLOGIN;
GRANT super_user TO <authenticated user name>;
GRANT USAGE ON SCHEMA api TO super_user;
GRANT ALL ON api.jobs TO super_user;
GRANT USAGE, SELECT ON SEQUENCE api.jobs_id_seq TO super_user;
GRANT SELECT, UPDATE, INSERT, DELETE ON api.traffic_reports TO super_user;
GRANT USAGE, SELECT ON SEQUENCE api.traffic_reports_id_seq TO super_user;

CREATE ROLE web_anon NOLOGIN;
GRANT web_anon TO <authenticated user name>;
GRANT usage ON schema api TO web_anon;
GRANT SELECT ON api.jobs TO web_anon;
GRANT SELECT ON api.jobs_latest TO web_anon;
GRANT SELECT ON api.traffic_reports TO web_anon;














