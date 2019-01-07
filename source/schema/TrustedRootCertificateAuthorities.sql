CREATE TABLE IF NOT EXISTS TrustedRootCertificateAuthorities
(
    hostID              BIGINT UNSIGNED         NOT NULL,
    name                TINYTEXT                NOT NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    PRIMARY KEY (hostID, name)
);