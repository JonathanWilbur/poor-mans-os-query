CREATE TABLE IF NOT EXISTS NetworkInternetLayerInterfaces
(
    hostID              BIGINT UNSIGNED     NOT NULL,
    hardwareInterfaceID BIGINT UNSIGNED     NOT NULL,
    ipAddress           VARCHAR(15)         NOT NULL,
    cidrPrefixLength    TINYINT UNSIGNED    NOT NULL,
    broadcastAddress    VARCHAR(15)         NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    FOREIGN KEY (hardwareInterfaceID) REFERENCES NetworkHardwareInterfaces (id)
);