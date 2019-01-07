CREATE TABLE IF NOT EXISTS BashCommandHistories
(
    hostID              BIGINT UNSIGNED     NOT NULL,
    username            VARCHAR(32)         NOT NULL,
    command             MEDIUMTEXT          NOT NULL
);