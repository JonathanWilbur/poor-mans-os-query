CREATE TABLE IF NOT EXISTS Hosts
(
    id SERIAL                       PRIMARY KEY,
    hostname                        VARCHAR(255)        NOT NULL, -- uname -n or hostname
    kernelName                      VARCHAR(16)         NULL, -- uname -s
    releaseVersion                  VARCHAR(32)         NULL, -- uname -r
    architecture                    VARCHAR(8)          NULL, -- uname -m
    processorType                   VARCHAR(8)          NULL, -- uname -p
    hardwarePlatform                VARCHAR(8)          NULL, -- uname -i
    operatingSystem                 VARCHAR(16)         NULL, -- uname -o
    distroRelease                   VARCHAR(64)         NULL, -- (cat /etc/redhat-release || cat /etc/centos-release || cat /etc/fedora-release || lsb_release -d || echo "NULL")
    biosVendor                      VARCHAR(32)         NULL, -- dmidecode --string bios-vendor
    biosVersion                     VARCHAR(32)         NULL, -- dmidecode --string bios-version
    biosReleaseDate                 DATE                NULL, -- dmidecode --string bios-release-date
    biosMemoryAddress               BIGINT UNSIGNED     NULL, -- dmidecode --type 0 : Address
    biosRuntimeSize                 BIGINT UNSIGNED     NULL, -- dmidecode --type 0 : Runtime Size
    biosROMSize                     BIGINT UNSIGNED     NULL, -- dmidecode --type 0 : ROM Size
    isaSupported                    BOOLEAN             NULL, -- dmidecode --type 0 : Characteristics : ISA is supported
    pciSupported                    BOOLEAN             NULL, -- dmidecode --type 0 : Characteristics : PCI is supported
    bootFromCDSupported             BOOLEAN             NULL, -- dmidecode --type 0 : Characteristics : Boot from CD is supported
    selectableBootSupported         BOOLEAN             NULL, -- dmidecode --type 0 : Characteristics : Selectable boot is supported
    keyboard8042ServicesSupported   BOOLEAN             NULL, -- dmidecode --type 0 : Characteristics : 8042 keyboard services are supported (int 9h)
    cgaMonoVideoServicesSupported   BOOLEAN             NULL, -- dmidecode --type 0 : Characteristics : CGA/mono video services are supported (int 10h)
    acpiSupported                   BOOLEAN             NULL, -- dmidecode --type 0 : Characteristics : ACPI is supported
    systemManufacturer              VARCHAR(32)         NULL, -- dmidecode --string system-manufacturer
    systemProductName               VARCHAR(32)         NULL, -- dmidecode --string system-product-name
    systemVersion                   VARCHAR(16)         NULL, -- dmidecode --string system-version
    systemSerialNumber              VARCHAR(16)         NULL, -- dmidecode --string system-serial-number
    systemUUID                      VARCHAR(68)         NULL, -- dmidecode --string system-uuid
    systemWakeUpType                VARCHAR(32)         NULL, -- dmidecode --type 1 : Wake-up Type
    systemSKUNumber                 VARCHAR(32)         NULL, -- dmidecode --type 1 : SKU NUMBER
    systemFamily                    VARCHAR(32)         NULL, -- dmidecode --type 1 : Family
    baseboardManufacturer           VARCHAR(32)         NULL, -- dmidecode --string baseboard-manufacturer
    baseboardProductName            VARCHAR(32)         NULL, -- dmidecode --string baseboard-product-name
    baseboardVersion                VARCHAR(16)         NULL, -- dmidecode --string baseboard-version
    baseboardSerialNumber           VARCHAR(16)         NULL, -- dmidecode --string baseboard-serial-number
    baseboardAssetTag               VARCHAR(16)         NULL, -- dmidecode --string baseboard-asset-tag
    hostingBoard                    BOOLEAN             NULL, -- dmidecode --type 2 : Board is a hosting board
    locationInChassis               VARCHAR(32)         NULL, -- dmidecode --type 2 : Location In Chassis
    chassisHandle                   MEDIUMINT UNSIGNED  NULL, -- dmidecode --type 2 : Chassis Handle
    baseboardType                   VARCHAR(16)         NULL, -- dmidecode --type 2 : Type
    chassisManufacturer             VARCHAR(32)         NULL, -- dmidecode --string chassis-manufacturer
    chassisType                     VARCHAR(16)         NULL, -- dmidecode --string chassis-type
    chassisLock                     VARCHAR(16)         NULL, -- dmidecode --type 3 : Lock
    chassisVersion                  VARCHAR(16)         NULL, -- dmidecode --string chassis-version
    chassisSerialNumber             VARCHAR(16)         NULL, -- dmidecode --string chassis-serial-number
    chassisAssetTag                 VARCHAR(16)         NULL, -- dmidecode --string chassis-asset-tag
    chassisBootUpState              VARCHAR(16)         NULL, -- dmidecode --type 3 : Boot-up State
    chassisPowerSupplyState         VARCHAR(16)         NULL, -- dmidecode --type 3 : Power Supply State
    chassisThermalState             VARCHAR(16)         NULL, -- dmidecode --type 3 : Thermal State
    chassisSecurityStatus           VARCHAR(16)         NULL, -- dmidecode --type 3 : Security Status
    uptimeInSeconds                 INTEGER UNSIGNED    NULL, -- cat /proc/uptime | sed -r "s/^([[:digit:]]+)\..*/\1/g"
    UNIQUE INDEX (hostname)
);


