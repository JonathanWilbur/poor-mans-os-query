CREATE TABLE IF NOT EXISTS InternetProtocolV4Protocols
(
    hostID              BIGINT UNSIGNED     NOT NULL,
    name                VARCHAR(16)          NOT NULL,
    protocolNumber      TINYINT UNSIGNED    NOT NULL,
    aliases             VARCHAR(32)         NULL,
    description         TINYTEXT            NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id)
);