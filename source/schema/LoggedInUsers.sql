CREATE TABLE IF NOT EXISTS LoggedInUsers
(
    hostID                  BIGINT UNSIGNED         NOT NULL,
    name                    VARCHAR(64)             NOT NULL,
    terminalType            VARCHAR(8)              NULL,
    terminalNumber          TINYINT UNSIGNED        NULL,
    fromAddress             VARCHAR(64)             NULL,
    loginTime               VARCHAR(64)             NULL,
    idleTimeInSeconds       INTEGER UNSIGNED        NULL,
    allJobsCPUTime          INTEGER UNSIGNED        NULL,
    currentProcessCPUTime   INTEGER UNSIGNED        NULL,
    currentProcess          TINYTEXT                NULL
);