-- Useful documentation: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security_guide/sec-understanding_audit_log_files
CREATE TABLE IF NOT EXISTS SELinuxAuditLogEntries
(
    id SERIAL PRIMARY KEY,
    hostname        VARCHAR(256)        NOT NULL,

    -- First Record
    entryType       VARCHAR(64)         NOT NULL,
    entryTime       TIMESTAMP           NOT NULL,
    auditID         INTEGER UNSIGNED    NOT NULL,
    architecture    CHAR(8)             NULL,
    syscall         INTEGER UNSIGNED    NULL,
    success         BOOLEAN             NULL,
    exit            INTEGER             NULL,
    -- a0              
    -- a1
    -- a2
    -- a3
    items           INTEGER UNSIGNED    NULL,
    ppid            INTEGER UNSIGNED    NULL,
    pid             INTEGER UNSIGNED    NULL,
    auid            INTEGER UNSIGNED    NULL,
    uid             INTEGER UNSIGNED    NULL,
    gid             INTEGER UNSIGNED    NULL,
    euid            INTEGER UNSIGNED    NULL,
    suid            INTEGER UNSIGNED    NULL,
    fsuid           INTEGER UNSIGNED    NULL,
    egid            INTEGER UNSIGNED    NULL,
    sgid            INTEGER UNSIGNED    NULL,
    fsgid           INTEGER UNSIGNED    NULL,
    tty             VARCHAR(8)          NULL,
    sessionID       INTEGER UNSIGNED    NULL,
    command         VARCHAR(1024)       NULL,
    executable      VARCHAR(1024)       NULL,
    subject         VARCHAR(1024)       NULL,
    auditKey        VARCHAR(64)         NULL,

    -- Second Record
    
);