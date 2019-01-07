CREATE TABLE IF NOT EXISTS NPMPackages
(
    hostID              BIGINT UNSIGNED         NOT NULL,
    name                VARCHAR(64)             NOT NULL,
    version             VARCHAR(16)             NOT NULL,
    path                TINYTEXT                NULL,
    resolved            TINYTEXT                NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id)
);