CREATE TABLE IF NOT EXISTS RubyGems
(
    hostID          BIGINT UNSIGNED     NOT NULL,
    name            VARCHAR(64)         NOT NULL PRIMARY KEY,
    version         VARCHAR(16)         NOT NULL,
    homepage        TINYTEXT            NULL,
    license         VARCHAR(16)         NULL,
    installedAt     TINYTEXT            NULL,
    description     TINYTEXT            NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id)
);