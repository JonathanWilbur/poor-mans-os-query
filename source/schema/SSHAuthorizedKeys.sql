-- Protocol 1 public keys consist of the following space-separated fields: options, bits, exponent, modulus, comment.
-- Protocol 2 public key consist of: options, keytype, base64-encoded key, comment
CREATE TABLE IF NOT EXISTS SSHAuthorizedKeys
(
    hostID              BIGINT UNSIGNED         NOT NULL,
    options             VARCHAR(256)            NULL,
    keyType             VARCHAR(32)             NOT NULL,
    publicKey           BLOB                    NOT NULL,
    comment             TINYTEXT                NULL,
    FOREIGN KEY (hostID) REFERENCES Hosts (id)
);