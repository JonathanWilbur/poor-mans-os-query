CREATE TABLE IF NOT EXISTS Files
(
    hostID                      BIGINT UNSIGNED     NOT NULL,
    directory                   VARCHAR(256)        NOT NULL,
    fileName                    VARCHAR(256)        NOT NULL,
    inodeNumber                 BIGINT UNSIGNED     NULL,
    depth                       TINYINT UNSIGNED    NULL,
    userID                      INTEGER UNSIGNED    NULL,
    groupID                     INTEGER UNSIGNED    NULL,
    lastAccessTime              TIMESTAMP           NULL,
    lastModifyTime              TIMESTAMP           NULL,
    creationTime                TIMESTAMP           NULL,
    sizeInBytes                 BIGINT UNSIGNED     NULL,
    deviceNumber                INTEGER UNSIGNED    NULL,
    fileSystemType              VARCHAR(16)         NULL,
    objectOfSymbolicLink        VARCHAR(4096)       NULL,
    fileType                    CHAR                NULL, -- f, d, ...?
    mode                        VARCHAR(4)          NULL,
    selinuxContext              VARCHAR(256)        NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id),
    PRIMARY KEY (hostID, directory, fileName)
);