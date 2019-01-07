CREATE TABLE IF NOT EXISTS InstalledRPMPackages
(
    hostID                  BIGINT UNSIGNED     NOT NULL,
    name                    VARCHAR(128)        NULL,
    version                 VARCHAR(32)         NULL,
    releaseTag              VARCHAR(32)         NULL,
    epoch                   VARCHAR(16)         NULL,
    summary                 TEXT                NULL,
    description             TEXT                NULL,
    buildtime               TIMESTAMP           NULL,
    buildhost               VARCHAR(128)        NULL,
    installtime             TIMESTAMP           NULL,
    longarchivesize         BIGINT UNSIGNED     NULL,
    longfilesizes           BIGINT UNSIGNED     NULL,
    longsigsize             BIGINT UNSIGNED     NULL,
    size                    BIGINT UNSIGNED     NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    PRIMARY KEY (hostID, name)
);