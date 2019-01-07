CREATE TABLE IF NOT EXISTS DebianPackages
(
    hostID                  BIGINT UNSIGNED NOT NULL,
    architecture            VARCHAR(8)      NULL, -- amd64
    bugs                    MEDIUMTEXT      NULL, -- 
    conffiles               MEDIUMTEXT      NULL, -- 
    -- configVersion -- 
    conflicts               MEDIUMTEXT      NULL, -- zlib1 (<= 1:1.0.4-7)
    breaks                  MEDIUMTEXT      NULL, -- libxml2 (<< 2.7.6.dfsg-2), texlive-binaries (<< 2009-12)
    depends                 MEDIUMTEXT      NULL, -- libc6 (>= 2.14)
    enhances                MEDIUMTEXT      NULL, -- 
    essential               BOOLEAN         NULL, -- no
    -- filename -- 
    homepage                TINYTEXT        NULL, -- http://zlib.net/
    installedSize           BIGINT UNSIGNED NULL, -- 169
    mD5sum                  CHAR(32)        NULL, -- 9c281a0ef81e257407fe01fa6aa0fa73
    -- mSDOSFilename -- 
    maintainer              TINYTEXT        NULL, -- Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
    -- origin -- 
    package                 TINYTEXT        NULL, -- zlib1g
    pre-Depends             MEDIUMTEXT      NULL, -- 
    priority                VARCHAR(16)     NULL, -- required, important
    -- revision -- 
    section                 VARCHAR(16)     NULL, -- libs
    size                    BIGINT UNSIGNED NULL, -- 
    source                  TINYTEXT        NULL, -- zlib
    status                  TINYTEXT        NULL, -- install ok installed
    suggests                MEDIUMTEXT      NULL, -- 
    -- tag                     TINYTEXT        NULL, -- 
    -- triggersAwaited -- 
    -- triggersPending -- 
    version                 TINYTEXT        NULL, -- 1:1.2.11.dfsg-0ubuntu2
    binaryPackage           TINYTEXT        NULL, -- zlib1g:amd64
    sourcePackage           TINYTEXT        NULL, -- zlib
    sourceVersion           TINYTEXT        NULL, -- 1:1.2.11.dfsg-0ubuntu2
    sourceUpstreamVersion   TINYTEXT        NULL -- 1.2.11.dfsg
);