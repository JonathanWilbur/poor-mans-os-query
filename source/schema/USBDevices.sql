CREATE TABLE IF NOT EXISTS USBDevices
(
    hostID              BIGINT UNSIGNED         NOT NULL,
    busNumber           TINYINT UNSIGNED        NOT NULL,
    deviceNumber        TINYINT UNSIGNED        NOT NULL,
    usbVendorCode       SMALLINT UNSIGNED       NOT NULL,
    usbProductCode      SMALLINT UNSIGNED       NOT NULL,
    deviceDescription   TINYTEXT                NULL
);