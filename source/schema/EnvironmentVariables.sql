CREATE TABLE IF NOT EXISTS EnvironmentVariables
(
    hostID              BIGINT UNSIGNED     NOT NULL,
    variableName        VARCHAR(32)         NOT NULL,
    variableValue       MEDIUMTEXT          NOT NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    PRIMARY KEY (hostID, variableName)
);