CREATE SCHEMA api;

CREATE TABLE IF NOT EXISTS api.jobs (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  end_date TIMESTAMP WITH TIME ZONE NOT NULL,
  message TEXT,
  status TEXT,
  records_processed INTEGER,
  source TEXT NOT NULL,
  destination TEXT NOT NULL
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

CREATE TABLE IF NOT EXISTS api.csr_flex_notes (
    id TEXT PRIMARY KEY,
    created_date TIMESTAMP WITH TIME ZONE,
    emi_id TEXT NOT NULL,
    flex_attribute_codes TEXT,
    flex_attribute_value TEXT,
    flex_question_code TEXT NOT NULL,
    flex_question_desc TEXT,
    sr_number TEXT NOT NULL,
    SR_PARENT TEXT NOT NULL
);

alter table api.csr_flex_notes drop column flex_question_desc;

CREATE ROLE super_user NOLOGIN;
GRANT super_user TO <authenticated user name>;
GRANT USAGE ON SCHEMA api TO super_user;
GRANT ALL ON api.jobs TO super_user;
GRANT USAGE, SELECT ON SEQUENCE api.jobs_id_seq TO super_user;
GRANT SELECT, UPDATE, INSERT, DELETE ON api.traffic_reports TO super_user;
GRANT USAGE, SELECT ON SEQUENCE api.traffic_reports_id_seq TO super_user;
GRANT SELECT, UPDATE, INSERT, DELETE ON api.csr_flex_notes TO super_user

CREATE ROLE web_anon NOLOGIN;
GRANT web_anon TO <authenticated user name>;
GRANT usage ON schema api TO web_anon;
GRANT SELECT ON api.jobs TO web_anon;
GRANT SELECT ON api.jobs_latest TO web_anon;
GRANT SELECT ON api.traffic_reports TO web_anon;


CREATE TABLE IF NOT EXISTS api.purchasing_master_agreements (
  document_id TEXT PRIMARY KEY,
  document_description TEXT,
);











