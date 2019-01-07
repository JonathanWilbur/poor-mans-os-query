CREATE TABLE IF NOT EXISTS PasswdAccounts
(
    hostID              BIGINT UNSIGNED         NOT NULL,
    name                VARCHAR(32)             NOT NULL COMMENT 'This is the user''s login name. It should not contain capital letters.',
    uid                 INTEGER UNSIGNED        NOT NULL COMMENT 'The privileged root login account (superuser) has the user ID 0.',
    gid                 INTEGER UNSIGNED        NOT NULL COMMENT 'This is the numeric primary group ID for this user. (Additional groups for the user are defined in the system group file; see group(5)).',
    comment             TINYTEXT                NULL COMMENT 'This field (sometimes called the "comment field") is optional and used only for informational purposes. Usually, it contains the full username.', 
    directory           TINYTEXT                NOT NULL COMMENT 'This is the user''s home directory: the initial directory where the user is placed after logging in. The value in this field is used to set the HOME environment variable.',
    shell               TINYTEXT                NOT NULL COMMENT 'This is the program to run at login (if empty, use /bin/sh). If set to a nonexistent executable, the user will be unable to login through login(1). The value in this field is used to set the SHELL environment variable.'
);