CREATE TABLE IF NOT EXISTS UnixProcessSchedulingPolicies
(
    id              TINYINT UNSIGNED    NOT NULL PRIMARY KEY,
    shortCode       VARCHAR(4)          NOT NULL UNIQUE CHECK (shortCode RLIKE '^[A-Z]+'),
    enumString      VARCHAR(16)         NOT NULL UNIQUE CHECK (enumString RLIKE '^[A-Z_]+'),
    description     TINYTEXT            NULL
);

INSERT INTO UnixProcessSchedulingPolicies
VALUES
    (0, 'TS', 'SCHED_OTHER', NULL),
    (1, 'FF', 'SCHED_FIFO', NULL),
    (2, 'RR', 'SCHED_RR', NULL),
    (3, 'B', 'SCHED_BATCH', NULL),
    (4, 'ISO', 'SCHED_ISO', NULL),
    (5, 'IDL', 'SCHED_IDLE', NULL)
;

CREATE TABLE IF NOT EXISTS RunningProcesses
(
    hostID          BIGINT UNSIGNED         NOT NULL,
    pid             INTEGER UNSIGNED        NOT NULL COMMENT 'A number representing the process ID.',
    ppid            INTEGER UNSIGNED        NULL COMMENT 'Parent process ID.',
    tpgid           INTEGER UNSIGNED        NULL COMMENT 'ID of the foreground process group on the tty (terminal) that the process is connected to, or -1 if the process is not connected to a tty.',
    pgrp            INTEGER UNSIGNED        NULL COMMENT 'Process group ID or, equivalently, the process ID of the process group leader.',
    tid             INTEGER UNSIGNED        NULL COMMENT 'The unique number representing a dispatchable entity.',
    pidns           BIGINT UNSIGNED         NULL COMMENT 'Unique inode number describing the namespace the process belongs to.',
    ipcns           BIGINT UNSIGNED         NULL COMMENT 'Unique inode number describing the namespace the process belongs to.',
    netns           BIGINT UNSIGNED         NULL COMMENT 'Unique inode number describing the namespace the process belongs to.',
    mntns           BIGINT UNSIGNED         NULL COMMENT 'Unique inode number describing the namespace the process belongs to.',
    utsns           BIGINT UNSIGNED         NULL COMMENT 'Unique inode number describing the namespace the process belongs to.',
    userns          BIGINT UNSIGNED         NULL COMMENT 'Unique inode number describing the namespace the process belongs to.',
    ouid            INTEGER UNSIGNED        NULL COMMENT 'Displays the Unix user identifier of the owner of the session of a process, if systemd support has been included.',
    euser           VARCHAR(32)             NULL COMMENT 'Effective user name.',
    ruser           VARCHAR(32)             NULL COMMENT 'Real user ID.',
    egroup          VARCHAR(32)             NULL COMMENT 'Effective group ID of the process.',
    rgroup          VARCHAR(32)             NULL COMMENT 'Real group name.',
    fuser           VARCHAR(32)             NULL COMMENT 'Filesystem access user ID.',
    fgroup          VARCHAR(32)             NULL COMMENT 'Filesystem access group ID.',
    suser           VARCHAR(32)             NULL COMMENT 'Saved user name.',
    sgroup          VARCHAR(32)             NULL COMMENT 'Saved group name.',
    supgrp          VARCHAR(32)             NULL COMMENT 'Group names of supplementary groups, if any.',
    ignored         BIGINT UNSIGNED         NULL COMMENT 'Mask of the ignored signals, see signal(7).',           
    pending         BIGINT UNSIGNED         NULL COMMENT 'Mask of the pending signals.',
    machine         VARCHAR(64)             NULL COMMENT 'Displays the machine name for processes assigned to VM or container, if systemd support has been included.', -- REVIEW
    cgroup          VARCHAR(32)             NULL COMMENT 'Display control groups to which the process belongs.', -- 10:pids:/user.slice/user-10
    unit            VARCHAR(32)             NULL COMMENT 'Displays the systemd unit to which a process belongs, if systemd support has been included.',
    tty             VARCHAR(8)              NULL COMMENT 'Controlling tty (terminal).',
    seat            VARCHAR(64)             NULL COMMENT 'Displays the identifier associated with all hardware devices assigned to a specific workplace, if systemd support has been included.', -- REVIEW
    session         INTEGER UNSIGNED        NULL COMMENT 'Session ID or, equivalently, the process ID of the session leader.',
    lsession        INTEGER UNSIGNED        NULL COMMENT 'Displays the login session identifier of a process, if systemd support has been included.',
    slice           VARCHAR(32)             NULL COMMENT 'Displays the slice unit to which a process belongs, if systemd support has been included.',
    uunit           VARCHAR(64)             NULL COMMENT 'Displays user unit to which a process belongs, if systemd support has been included.', -- REVIEW
    etimes          INTEGER UNSIGNED        NULL COMMENT 'Elapsed time since the process was started, in seconds.',
    sched           TINYINT UNSIGNED        NULL COMMENT 'Scheduling class of the process.', -- REVIEW
    cputime         TIME                    NULL COMMENT 'Cumulative CPU time.', -- REVIEW: Do you actually want this, when you have etimes?
    ni              TINYINT SIGNED          NULL COMMENT 'The process nice value. This ranges from 19 (nicest) to -20 (not nice to others).' CHECK (ni >= -20 AND ni <= 19),
    pri             TINYINT UNSIGNED        NULL COMMENT 'Priority of the process. Higher number means lower priority.' CHECK (pri <= 139),
    psr             TINYINT UNSIGNED        NULL COMMENT 'Processor that process is currently assigned to.',
    rtprio          VARCHAR(64)             NULL COMMENT 'Realtime priority.', -- REVIEW
    state           VARCHAR(4)              NULL COMMENT 'Minimal state display.',
    sgi_p           CHAR                    NULL COMMENT 'Processor that the process is currently executing on.',
    nlwp            INTEGER UNSIGNED        NULL COMMENT 'Number of lwps (threads) in the process.',
    esp             BIGINT UNSIGNED         NULL COMMENT 'The process stack pointer.',
    eip             BIGINT UNSIGNED         NULL COMMENT 'The process instruction pointer.',
    stackp          BIGINT UNSIGNED         NULL COMMENT 'Address of the bottom (start) of stack for the process.',
    drs             BIGINT UNSIGNED         NULL COMMENT 'Data resident set size, the amount of physical memory devoted to other than executable code.',
    maj_flt         BIGINT UNSIGNED         NULL COMMENT 'The number of major page faults that have occurred with this process.',
    min_flt         BIGINT UNSIGNED         NULL COMMENT 'The number of minor page faults that have occurred with this process.',
    nwchan          BIGINT UNSIGNED         NULL COMMENT 'Address of the kernel function where the process is sleeping (use wchan if you want the kernel function name).',
    pmem            FLOAT UNSIGNED          NULL COMMENT 'Ratio of the process''s resident set size  to the physical memory on the machine, expressed as a percentage.',
    rssize          BIGINT UNSIGNED         NULL COMMENT 'Resident set size, the non-swapped physical memory that a task has used (in kiloBytes).',
    size            BIGINT UNSIGNED         NULL COMMENT 'Approximate amount of swap space that would be required if the process were to dirty all writable pages and then be swapped out.',
    sz              BIGINT UNSIGNED         NULL COMMENT 'Size in physical pages of the core image of the process.',
    vsz             BIGINT UNSIGNED         NULL COMMENT 'Virtual memory size of the process in KiB (1024-byte units).',
    label           TINYTEXT                NULL COMMENT 'Security label, most commonly used for SELinux context data.',
    flags           CHAR                    NULL COMMENT 'Flags associated with the process.', -- REVIEW
    args            MEDIUMTEXT              NULL COMMENT 'Command with all its arguments as a string.',
    PRIMARY KEY (hostID, pid),
    FOREIGN KEY (sched) REFERENCES UnixProcessSchedulingPolicies (id)
);

-- The following user-defined format specifiers may contain spaces: args, cmd, comm, command, fname, ucmd, ucomm, lstart, bsdstart, start.
-- REPLACE: ", -, " ", *, " ", ?, "