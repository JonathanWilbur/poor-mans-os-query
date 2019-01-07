CREATE TABLE IF NOT EXISTS APTRepositories
(
    hostID                  BIGINT UNSIGNED NOT NULL,
    isSourceRepository      BOOLEAN         NOT NULL,
    repositoryURI           TINYTEXT        NOT NULL,
    distribution            VARCHAR(16)     NOT NULL,
    components              TINYTEXT        NULL
);