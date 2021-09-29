# Level 15

## Level Goal
The password for the next level can be retrieved by submitting the password of the current level to port `30001` on `localhost` using SSL encryption.

Helpful note: Getting “HEARTBEATING” and “Read R BLOCK”? Use -ign_eof and read the “CONNECTED COMMANDS” section in the manpage. Next to ‘R’ and ‘Q’, the ‘B’ command also works in this version of that command…

## Access
```
ssh bandit15@bandit.labs.overthewire.org -p 2220
```
pwd: BfMYroe26WYalil77FoDi9qh59eK5xNr

## Set Aliases
```
alias l='ls -lah'
```

## Try to Connect
```
openssl s_client -connect localhost:30001

CONNECTED(00000003)
depth=0 CN = localhost
verify error:num=18:self signed certificate
verify return:1
depth=0 CN = localhost
verify return:1
---
Certificate chain
 0 s:/CN=localhost
   i:/CN=localhost
---
Server certificate
-----BEGIN CERTIFICATE-----
MIICBjCCAW+gAwIBAgIEHxhZ+zANBgkqhkiG9w0BAQUFADAUMRIwEAYDVQQDDAls
b2NhbGhvc3QwHhcNMjEwODA1MjEyMjEzWhcNMjIwODA1MjEyMjEzWjAUMRIwEAYD
VQQDDAlsb2NhbGhvc3QwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALqNmx6R
csRsPgzRcRsq5oQ4BC9AT/Yu473WbK4SRjHOWwuA4Oqk9w8SLKYZ39FrDEnXSZJw
xqKPR0AH72+l7Itv7X1H07VbeMTQoJVm6NsJm3cuyyxjRwfaIOUFsRtQQyvQlmw7
3CgTbd3wEk1CD+6jlksJj801Vd0uvZh1VVERAgMBAAGjZTBjMBQGA1UdEQQNMAuC
CWxvY2FsaG9zdDBLBglghkgBhvhCAQ0EPhY8QXV0b21hdGljYWxseSBnZW5lcmF0
ZWQgYnkgTmNhdC4gU2VlIGh0dHBzOi8vbm1hcC5vcmcvbmNhdC8uMA0GCSqGSIb3
DQEBBQUAA4GBADjhbe3bTnDWsS4xt8FFg7PJIqNAxF6QjP+7xzJ4yMvWtPP6tVXo
F7SNI52juwH0nFDyM9KOrM/AknWqCYF+yfz6bLD7MaKZ+Kg3DiLaoVJOrVg6Y02+
0vq1rLsqGko5wamCFamx7X9CtFsV0WQjZdA53Na/VwehtlFpf/p20VAi
-----END CERTIFICATE-----
subject=/CN=localhost
issuer=/CN=localhost
---
No client certificate CA names sent
Peer signing digest: SHA512
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 1019 bytes and written 269 bytes
Verification error: self signed certificate
---
New, TLSv1.2, Cipher is ECDHE-RSA-AES256-GCM-SHA384
Server public key is 1024 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES256-GCM-SHA384
    Session-ID: DD8DA99CD0AEE9F9E80305748EA917C44749DFCC085E23AC26892C1B5CF1BAFE
    Session-ID-ctx:
    Master-Key: 76005BB0CF54948897C108C1F2DE32BACFD0A018EA83082009180D1A90C50BA54664F54BB4B6A946A08B03FFB8F1BF11
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - 3a a9 fe 3b 12 a1 ed 2b-8d a6 cf aa 23 c9 12 88   :..;...+....#...
    0010 - a4 d4 51 f5 7e 73 e4 82-2a f7 21 c4 db 14 c3 f7   ..Q.~s..*.!.....
    0020 - 7b eb af 2d f1 14 2b 6d-50 5e 32 40 fa 1a 14 ea   {..-..+mP^2@....
    0030 - 2f ca 84 8b a9 c3 0c c1-de 85 64 44 e6 7d 44 f9   /.........dD.}D.
    0040 - 85 8a 49 b1 e2 8e 2a 60-98 6d 6a d9 f6 04 e0 6d   ..I...*`.mj....m
    0050 - 88 60 fd aa 15 85 3e f4-6b 4b f8 c9 49 a8 d8 f5   .`....>.kK..I...
    0060 - cf 15 3b 89 91 ca 8c bc-c0 d4 f9 2b 67 6b a4 e6   ..;........+gk..
    0070 - 4a 9b 01 47 31 78 85 7a-7d 8a ec 43 4f dc ce 0b   J..G1x.z}..CO...
    0080 - 1f 31 c5 89 35 c5 c2 bc-e2 ac d0 41 da 08 9f be   .1..5......A....
    0090 - 3f 5d a7 39 94 c5 b4 98-57 c4 2c e1 7f 52 71 6a   ?].9....W.,..Rqj

    Start Time: 1632913192
    Timeout   : 7200 (sec)
    Verify return code: 18 (self signed certificate)
    Extended master secret: yes
---
```
**Submit**
```
BfMYroe26WYalil77FoDi9qh59eK5xNr
Correct!
cluFn7wTiGryunymYOu4RcffSxQluehd

closed
```

# Flag
cluFn7wTiGryunymYOu4RcffSxQluehd

# Resources
* [openssl s_client introduction](https://youtu.be/dgsSvHK_lmU)
* [2 Testing TLS with OpenSSL](https://www.feistyduck.com/library/openssl-cookbook/online/ch-testing-with-openssl.html)

# Retospective
First time to use the `s_client` under the `openssl`.

## What went well?
Able to connect to the SSL and submit the payload by reviewing the resources provided.

## What could have gone better?
Improve knowledge in TLS/SSL technologies.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
Understand what `-ign_eof` does, and see what other parameters are available for the `openssl s_client` to see if we can use it in the future.

## How other people solved this?

### [OverTheWire: Bandit Level 15](https://medium.com/secttp/overthewire-bandit-level-15-223a2f5a940d) by S.P.

They used a different command and turns out I can `echo` the payload and pipe it. I haven't used `-ign_eof` though.
```
echo "BfMYroe26WYalil77FoDi9qh59eK5xNr" | openssl s_client -connect localhost:30001 -ign_eof
```
