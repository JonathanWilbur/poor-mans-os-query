CREATE TABLE IF NOT EXISTS FSTabMounts
(
    hostID              BIGINT UNSIGNED         NOT NULL PRIMARY KEY,
    source              TINYTEXT                NOT NULL,
    target              TINYTEXT                NOT NULL,
    fileSystem          VARCHAR(16)             NOT NULL,
    options             TINYTEXT                NULL,
    dump                TINYINT UNSIGNED        NULL,
    fsck                TINYINT UNSIGNED        NULL
);