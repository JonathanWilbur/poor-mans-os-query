CREATE TABLE IF NOT EXISTS SELinuxBooleans
(
    hostID          BIGINT UNSIGNED     NOT NULL,
    name            TINYTEXT            NOT NULL,
    status          BOOLEAN             NOT NULL
);