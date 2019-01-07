CREATE TABLE IF NOT EXISTS Snapshots
(
    id SERIAL PRIMARY KEY,
    hostID              BIGINT UNSIGNED     NOT NULL,
    hostname            TINYTEXT            NULL,
    licenseUUID         VARCHAR(68)         NOT NULL UNIQUE,
    forTestingPurposes  BOOLEAN             NULL
);