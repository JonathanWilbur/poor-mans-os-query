CREATE TABLE IF NOT EXISTS PeripheralComponentInterconnectDevices
(
    hostID              BIGINT UNSIGNED             NOT NULL PRIMARY KEY,
    domain              TINYINT UNSIGNED            NULL,
    bus                 TINYINT UNSIGNED            NOT NULL,
    device              TINYINT UNSIGNED            NOT NULL,
    functionNumber      TINYINT UNSIGNED            NOT NULL,
    deviceType          VARCHAR(64)                 NOT NULL,
    deviceName          TINYTEXT                    NULL
);