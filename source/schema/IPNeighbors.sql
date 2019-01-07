CREATE TABLE IF NOT EXISTS IPNeighbors
(
    hostID              BIGINT UNSIGNED         NOT NULL,
    neighborIPAddress   VARCHAR(15)             NOT NULL,
    device              VARCHAR(16)             NOT NULL,
    linkLayerAddress    CHAR(17)                NOT NULL,
    state               VARCHAR(16)             NOT NULL
);