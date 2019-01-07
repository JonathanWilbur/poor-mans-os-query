CREATE TABLE IF NOT EXISTS BlockDevices
(
    hostID                          BIGINT UNSIGNED     NOT NULL,
    name                            VARCHAR(64)         NOT NULL,
    kname                           VARCHAR(64)         NOT NULL,
    majorNumber                     SMALLINT UNSIGNED   NOT NULL,
    minorNumber                     SMALLINT UNSIGNED   NOT NULL,
    fileSystemType                  VARCHAR(8)          NULL,
    mountPoint                      VARCHAR(64)         NULL,
    label                           VARCHAR(64)         NULL,
    uuid                            VARCHAR(68)         NULL UNIQUE,
    partitionType                   TINYINT UNSIGNED    NULL,
    partitionLabel                  VARCHAR(64)         NULL,
    partitionUUID                   VARCHAR(68)         NULL UNIQUE,
    partitionFlags                  TINYINT UNSIGNED    NULL,
    readAhead                       SMALLINT UNSIGNED   NULL,
    readOnly                        BOOLEAN             NULL,
    removable                       BOOLEAN             NULL,
    hotpluggable                    BOOLEAN             NULL,
    model                           VARCHAR(16)         NULL,
    serialNumber                    VARCHAR(32)         NULL,
    size                            VARCHAR(8)          NULL,
    state                           VARCHAR(8)          NULL,
    ownerName                       VARCHAR(32)         NULL,
    groupName                       VARCHAR(32)         NULL,
    mode                            VARCHAR(10)         NULL, -- TODO: Add check here
    alignment                       SMALLINT UNSIGNED   NULL,
    minimumIOSize                   SMALLINT UNSIGNED   NULL,
    optimumIOSize                   SMALLINT UNSIGNED   NULL,
    physicalSectorSize              SMALLINT UNSIGNED   NULL,
    logicalSectorSize               SMALLINT UNSIGNED   NULL,
    rotationalDevice                BOOLEAN             NULL,
    ioSchedulerName                 VARCHAR(32)         NULL,
    requestQueueSize                SMALLINT UNSIGNED   NULL,
    deviceType                      VARCHAR(8)          NULL,
    discardAlignmentOffset          VARCHAR(8)          NULL,
    discardGranularity              VARCHAR(8)          NULL,
    discardMaximumBytes             VARCHAR(8)          NULL,
    discardZeroesBytes              VARCHAR(8)          NULL,
    writeSameMaximumBytes           VARCHAR(8)          NULL,
    uniqueStorageIdentifier         VARCHAR(64)         NULL,
    addsRandomness                  BOOLEAN             NULL,
    internalParentKernelDeviceName  VARCHAR(64)         NULL,
    scsiHost                        TINYINT UNSIGNED    NULL,
    scsiChannel                     TINYINT UNSIGNED    NULL,
    scsiTarget                      TINYINT UNSIGNED    NULL,
    scsiLUN                         TINYINT UNSIGNED    NULL,
    transportType                   VARCHAR(8)          NULL,
    subsystems                      VARCHAR(32)         NULL,
    revision                        VARCHAR(4)          NULL,
    vendor                          VARCHAR(8)          NULL,
    zoneModel                       VARCHAR(8)          NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    UNIQUE INDEX (hostID, majorNumber, minorNumber),
    UNIQUE INDEX (hostID, scsiHost, scsiChannel, scsiTarget, scsiLUN)
);