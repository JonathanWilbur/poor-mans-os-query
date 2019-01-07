CREATE TABLE IF NOT EXISTS NetworkLinkLayerInterfaces
(
    hostID              BIGINT UNSIGNED     NOT NULL,
    hardwareInterfaceID BIGINT UNSIGNED     NOT NULL,
    linkLayerType       VARCHAR(16)         NOT NULL,
    macAddress          CHAR(17)            NOT NULL,
    broadcastMACAddress CHAR(17)            NOT NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    FOREIGN KEY (hardwareInterfaceID) REFERENCES NetworkHardwareInterfaces (id)
);