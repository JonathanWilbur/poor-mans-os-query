CREATE TABLE IF NOT EXISTS NetworkScripts
(
    hostID              BIGINT UNSIGNED     NOT NULL,
    bootproto           VARCHAR(8)          NULL,
    broadcast           VARCHAR(16)         NULL,
    defroute            BOOLEAN             NULL,
    demand              BOOLEAN             NULL,
    device              VARCHAR(16)         NULL,
    dhcp_fqdn           TINYTEXT            NULL,
    dhcp_hostname       TINYTEXT            NULL,
    dns1                TINYTEXT            NULL,
    dns2                TINYTEXT            NULL,  
    hwaddr              CHAR(17)            NULL,
    idletimeout         INTEGER UNSIGNED    NULL,
    initstring          TINYTEXT            NULL,
    ipaddr              VARCHAR(16)         NULL,
    ipv6addr            VARCHAR(39)         NULL,
    ipv6init            BOOLEAN             NULL,
    linespeed           INTEGER UNSIGNED    NULL,
    modemport           VARCHAR(16)         NULL,
    mtu                 INTEGER UNSIGNED    NULL,
    name                VARCHAR(16)         NULL,
    netboot             BOOLEAN             NULL,
    network             VARCHAR(16)         NULL,
    onboot              BOOLEAN             NULL,
    papname             VARCHAR(16)         NULL,
    peerdns             BOOLEAN             NULL,
    persist             BOOLEAN             NULL,
    prefix              TINYINT UNSIGNED    NULL,
    remip               VARCHAR(16)         NULL,
    srcaddr             VARCHAR(16)         NULL,
    type                VARCHAR(16)         NULL,
    userctl             BOOLEAN             NULL,
    uuid                VARCHAR(36)         NULL,
    wvdialsect          TINYTEXT            NULL,

    address0            VARCHAR(16)         NULL,
    address1            VARCHAR(16)         NULL,
    address2            VARCHAR(16)         NULL,
    address3            VARCHAR(16)         NULL,
    address4            VARCHAR(16)         NULL,
    address5            VARCHAR(16)         NULL,
    address6            VARCHAR(16)         NULL,
    address7            VARCHAR(16)         NULL,
    address8            VARCHAR(16)         NULL,
    address9            VARCHAR(16)         NULL,

    gateway0            VARCHAR(16)         NULL,
    gateway1            VARCHAR(16)         NULL,
    gateway2            VARCHAR(16)         NULL,
    gateway3            VARCHAR(16)         NULL,
    gateway4            VARCHAR(16)         NULL,
    gateway5            VARCHAR(16)         NULL,
    gateway6            VARCHAR(16)         NULL,
    gateway7            VARCHAR(16)         NULL,
    gateway8            VARCHAR(16)         NULL,
    gateway9            VARCHAR(16)         NULL,

    netmask0            VARCHAR(16)         NULL,
    netmask1            VARCHAR(16)         NULL,
    netmask2            VARCHAR(16)         NULL,
    netmask3            VARCHAR(16)         NULL,
    netmask4            VARCHAR(16)         NULL,
    netmask5            VARCHAR(16)         NULL,
    netmask6            VARCHAR(16)         NULL,
    netmask7            VARCHAR(16)         NULL,
    netmask8            VARCHAR(16)         NULL,
    netmask9            VARCHAR(16)         NULL
);