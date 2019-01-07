CREATE TABLE IF NOT EXISTS NetworkHardwareInterfaces
(
    id SERIAL PRIMARY KEY,
    hostID                      BIGINT UNSIGNED         NOT NULL,
    name                        VARCHAR(16)             NOT NULL, -- #define	IFNAMSIZ	16 in https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/if.h#L33
    maximumTransmissionUnit     SMALLINT UNSIGNED       NOT NULL,
    queueDiscipline             VARCHAR(16)             NOT NULL COMMENT 'See https://en.wikipedia.org/wiki/Network_scheduler.',
    `group`                     VARCHAR(32)             NOT NULL,
    queueLength                 INTEGER UNSIGNED        NOT NULL, -- I don't know if this is actually big enough or not.

    -- Flags described here: http://man7.org/linux/man-pages/man7/netdevice.7.html
    up                          BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Interface is running.',
    broadcast                   BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Valid broadcast address set.',
    debug                       BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Internal debugging flag.',
    loopback                    BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Interface is a loopback interface.',
    pointopoint                 BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Interface is a point-to-point link.',
    running                     BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Resources allocated.',
    noarp                       BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'No arp protocol, L2 destination address not set.',
    promisc                     BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Interface is in promiscuous mode.',
    notrailers                  BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Avoid use of trailers.',
    allmulti                    BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Receive all multicast packets.',
    master                      BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Master of a load balancing bundle.',
    slave                       BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Slave of a load balancing bundle.',
    multicast                   BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Supports multicast',
    portsel                     BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Is able to select media type via ifmap.',
    automedia                   BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Auto media selection active.',
    dynamic                     BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'The addresses are lost when the interface goes down.',
    lower_up                    BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Driver signals L1 up (since Linux 2.6.17)',
    dormant                     BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Driver signals dormant (since Linux 2.6.17)',
    echo                        BOOLEAN                 NOT NULL DEFAULT FALSE COMMENT 'Echo sent packets (since Linux 2.6.25)'
);