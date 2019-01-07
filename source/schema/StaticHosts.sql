CREATE TABLE IF NOT EXISTS StaticHosts
(
    hostID                      BIGINT UNSIGNED         NOT NULL,
    internetProtocolAddress     VARCHAR(64)             NOT NULL,
    canonicalName               VARCHAR(256)            NOT NULL,
    aliases                     MEDIUMTEXT              NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id)
);