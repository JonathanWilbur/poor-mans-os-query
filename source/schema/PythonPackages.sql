CREATE TABLE IF NOT EXISTS PythonPackages
(
    hostID              BIGINT UNSIGNED NOT NULL,
    name                VARCHAR(64)     NOT NULL,
    currentVersion      VARCHAR(16)     NULL,
    latestVersion       VARCHAR(16)     NULL,
    packageType         VARCHAR(16)     NULL
);