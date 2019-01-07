CREATE TABLE IF NOT EXISTS Services
(
    hostID              BIGINT UNSIGNED     NOT NULL,
    name                VARCHAR(16)         NOT NULL,
    port                SMALLINT UNSIGNED   NOT NULL,
    transportProtocol   VARCHAR(8)          NOT NULL,
    aliases             VARCHAR(64)         NULL,
    description         TINYTEXT            NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id)
);