-- db/schema.sql
-- Member 5 (DB Admin): PostgreSQL schema design for week2-node-express
-- Run: psql -U postgres -d week2db -f db/schema.sql

CREATE TABLE IF NOT EXISTS users (
  id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        VARCHAR(100) NOT NULL CHECK (length(trim(name)) > 0),
  email       VARCHAR(150) NOT NULL CHECK (email LIKE '%_@_%._%'),
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Case-insensitive unique email (John@x.com == john@x.com)
CREATE UNIQUE INDEX IF NOT EXISTS users_email_lower_uidx
  ON users (LOWER(email));

COMMENT ON TABLE  users            IS 'Application users';
COMMENT ON COLUMN users.id         IS 'Auto-generated primary key';
COMMENT ON COLUMN users.name       IS 'Full name, required, max 100 chars';
COMMENT ON COLUMN users.email      IS 'Unique (case-insensitive), max 150 chars';
COMMENT ON COLUMN users.created_at IS 'Row creation time (UTC)';