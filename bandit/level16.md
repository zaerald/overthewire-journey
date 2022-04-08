# Level 16

## Level Goal
The credentials for the next level can be retrieved by submitting the password
of the current level to a port on `localhost` in the range `31000` to `32000`.
First find out which of these ports have a server listening on them. Then find
out which of those speak SSL and which don’t. There is only 1 server that will
give the next credentials, the others will simply send back to you whatever you
send to it.

## Access
```
ssh bandit16@bandit.labs.overthewire.org -p 2220
```
pwd: cluFn7wTiGryunymYOu4RcffSxQluehd


## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## Identify Which Ports are Listening
```
nc -zv localhost 31000-32000

localhost [127.0.0.1] 31960 (?) open
localhost [127.0.0.1] 31790 (?) open
localhost [127.0.0.1] 31691 (?) open
localhost [127.0.0.1] 31518 (?) open
localhost [127.0.0.1] 31046 (?) open
```

## Identify which are SSL ports
```
echo "cluFn7wTiGryunymYOu4RcffSxQluehd" | openssl s_client -connect localhost:31960 -ign_eof
echo "cluFn7wTiGryunymYOu4RcffSxQluehd" | openssl s_client -connect localhost:31790 -ign_eof
```

## Try
```
echo "cluFn7wTiGryunymYOu4RcffSxQluehd" | openssl s_client -connect localhost:31790 -ign_eof

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
MIICBjCCAW+gAwIBAgIEatsK7TANBgkqhkiG9w0BAQUFADAUMRIwEAYDVQQDDAls
b2NhbGhvc3QwHhcNMjEwODA1MjEyMzAxWhcNMjIwODA1MjEyMzAxWjAUMRIwEAYD
VQQDDAlsb2NhbGhvc3QwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALbshxNY
mdJ/7RpASCHk+XULoBymcRoKY9tPU25zhhPmrFAyv0HNXG/GqPjOxI4MHG627HOf
b00a/ikeDUTVdCiDXhungyUx6W07H3uiHHbfNLs1QGl2GPdBVA+z5DZcNsWJ1QB5
888HEzp8YNWyeHnP+5gy5LqlX5hUkF1eu6C1AgMBAAGjZTBjMBQGA1UdEQQNMAuC
CWxvY2FsaG9zdDBLBglghkgBhvhCAQ0EPhY8QXV0b21hdGljYWxseSBnZW5lcmF0
ZWQgYnkgTmNhdC4gU2VlIGh0dHBzOi8vbm1hcC5vcmcvbmNhdC8uMA0GCSqGSIb3
DQEBBQUAA4GBABVCD/dhWpgN9KC5Eb6hd9ToreRhof44OQaHalJtsayPBBMTK3Lp
KC88rNVJW+cX0z+eUe6en0RIvU56dLNT+zm9cbDvCV1cumz4++nauWes/11eA5aG
2NNgKQHYvT+bOfo3lhOQNwtzpO4MX1sGMjO4dlS4AmxTdjz0UVUPLamk
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
    Session-ID: DCEB73110B6CB2C7ECD36495D3EA204EC6C56FB1413404CBA11DF467D85DB2AB
    Session-ID-ctx:
    Master-Key: 9B43F167C46C4E26BDE136BDD52DDB3645AAB2B5F8B0149888FE82ED2CD42F1742B2DC2A79A37B2B761A67445B983A2C
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - 30 d5 a9 3d 7d a2 f1 16-f5 b3 32 79 c1 92 42 1a   0..=}.....2y..B.
    0010 - d5 fb 25 cb 30 0a 68 3f-f9 ad 2a e3 49 3a c8 e4   ..%.0.h?..*.I:..
    0020 - 6e e7 7e 69 fe 98 b0 e0-45 77 65 fa 29 c4 26 67   n.~i....Ewe.).&g
    0030 - 23 fe 05 d8 52 e5 f3 c4-d7 06 0c e4 27 89 cc 32   #...R.......'..2
    0040 - 8c d0 5d 96 9b fc 03 e2-f4 c9 e4 e0 dd ab 89 27   ..]............'
    0050 - 16 94 ff 73 9c 23 bc f0-f9 73 df ef e6 df 7d ef   ...s.#...s....}.
    0060 - 0d 57 cf 6b 58 48 6c 8a-7f 80 43 14 14 0c 3e 19   .W.kXHl...C...>.
    0070 - ec 38 49 c6 41 8f 21 9c-fd 6e 62 b1 ed 97 23 ea   .8I.A.!..nb...#.
    0080 - 0e 8f f4 04 61 07 1a b0-e1 c6 10 7a d2 83 92 83   ....a......z....
    0090 - 4e c4 26 bb c9 24 40 43-9c a2 f3 f0 d9 09 58 ad   N.&..$@C......X.

    Start Time: 1632914419
    Timeout   : 7200 (sec)
    Verify return code: 18 (self signed certificate)
    Extended master secret: yes
---
Correct!
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

closed
```

## Prepare for Next Level
```
rm -rf /tmp/zero
mkdir /tmp/zero
vim /tmp/zero/sshkey.private
chmod 400 /tmp/zero/sshkey.private
ssh -i /tmp/zero/sshkey.private bandit17@localhost
```

# Flag
```
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
```

# Resources
* [How to Check Remote Ports are Reachable Using ‘nc’ Command](https://www.tecmint.com/check-remote-port-in-linux)


# Retrospective
* Forgot how to scan the current ports using `nc`.
* Is there a better way to scan with specific type? For this case we can check for ports that are open that accepts SSL.


## What went well?
Properly scanned the open ports, but manually check for SSL open type.

## What could have gone better?
A command that'll loop the list of scanned ports and return back which one is SSL.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
Improve knowledge in automating SSL scans

## How other people solved this?

### [</ OverTheWire > Bandit Level 16 → Level 17](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-16-level-17-958bd0bfcbc4) by </The Girl Who Encrypts>

They have used the `nmap` instead of `nc`
```
nmap -p 31000-32000 localhost
```

Run the same to what I did, pass the password to the shortlisted ports.
```
cat /etc/bandit_pass/bandit16 | openssl s_client -connect localhost:31046 -quiet 
cat /etc/bandit_pass/bandit16 | openssl s_client -connect localhost:31518 -quiet
cat /etc/bandit_pass/bandit16 | openssl s_client -connect localhost:31691 -quiet
cat /etc/bandit_pass/bandit16 | openssl s_client -connect 
localhost:31790 -quiet
cat /etc/bandit_pass/bandit16 | openssl s_client -connect localhost:31960 -quiet
```

