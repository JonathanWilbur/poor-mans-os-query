CREATE TABLE IF NOT EXISTS SSHKnownHosts
(
    hostID          BIGINT UNSIGNED         NOT NULL,
    hosts           VARCHAR(256)            NOT NULL,
    keyType         VARCHAR(32)             NOT NULL,
    publicKey       BLOB                    NOT NULL,
    comment         TINYTEXT                NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    PRIMARY KEY (hostID, hosts)
);