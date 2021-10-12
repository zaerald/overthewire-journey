# Level 25

## Level Goal
Logging in to bandit26 from bandit25 should be fairly easy… The shell for user
bandit26 is not `/bin/bash`, but something else. Find out what it is, how it
works and how to break out of it.

## Access
```
ssh bandit25@bandit.labs.overthewire.org -p 2220
```
pwd: uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit25
```

This level is a bit confusing to solve. Let's try to navigate things around first.

## List available files
```
l

...
-rw-r-----  1 bandit25 bandit25   33 May 14  2020 .bandit24.password
-r--------  1 bandit25 bandit25 1.7K May  7  2020 bandit26.sshkey
-rw-r--r--  1 root     root      220 May 15  2017 .bash_logout
-rw-r--r--  1 root     root     3.5K May 15  2017 .bashrc
-rw-r-----  1 bandit25 bandit25    4 May 14  2020 .pin
-rw-r--r--  1 root     root      675 May 15  2017 .profile
```

## View file contents
```
tail -n +1 .bandit24.password bandit26.sshkey .pin
==> .bandit24.password <==
UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ

==> bandit26.sshkey <==
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEApis2AuoooEqeYWamtwX2k5z9uU1Afl2F8VyXQqbv/LTrIwdW
pTfaeRHXzr0Y0a5Oe3GB/+W2+PReif+bPZlzTY1XFwpk+DiHk1kmL0moEW8HJuT9
/5XbnpjSzn0eEAfFax2OcopjrzVqdBJQerkj0puv3UXY07AskgkyD5XepwGAlJOG
xZsMq1oZqQ0W29aBtfykuGie2bxroRjuAPrYM4o3MMmtlNE5fC4G9Ihq0eq73MDi
1ze6d2jIGce873qxn308BA2qhRPJNEbnPev5gI+5tU+UxebW8KLbk0EhoXB953Ix
3lgOIrT9Y6skRjsMSFmC6WN/O7ovu8QzGqxdywIDAQABAoIBAAaXoETtVT9GtpHW
qLaKHgYtLEO1tOFOhInWyolyZgL4inuRRva3CIvVEWK6TcnDyIlNL4MfcerehwGi
il4fQFvLR7E6UFcopvhJiSJHIcvPQ9FfNFR3dYcNOQ/IFvE73bEqMwSISPwiel6w
e1DjF3C7jHaS1s9PJfWFN982aublL/yLbJP+ou3ifdljS7QzjWZA8NRiMwmBGPIh
Yq8weR3jIVQl3ndEYxO7Cr/wXXebZwlP6CPZb67rBy0jg+366mxQbDZIwZYEaUME
zY5izFclr/kKj4s7NTRkC76Yx+rTNP5+BX+JT+rgz5aoQq8ghMw43NYwxjXym/MX
c8X8g0ECgYEA1crBUAR1gSkM+5mGjjoFLJKrFP+IhUHFh25qGI4Dcxxh1f3M53le
wF1rkp5SJnHRFm9IW3gM1JoF0PQxI5aXHRGHphwPeKnsQ/xQBRWCeYpqTme9amJV
tD3aDHkpIhYxkNxqol5gDCAt6tdFSxqPaNfdfsfaAOXiKGrQESUjIBcCgYEAxvmI
2ROJsBXaiM4Iyg9hUpjZIn8TW2UlH76pojFG6/KBd1NcnW3fu0ZUU790wAu7QbbU
i7pieeqCqSYcZsmkhnOvbdx54A6NNCR2btc+si6pDOe1jdsGdXISDRHFb9QxjZCj
6xzWMNvb5n1yUb9w9nfN1PZzATfUsOV+Fy8CbG0CgYEAifkTLwfhqZyLk2huTSWm
pzB0ltWfDpj22MNqVzR3h3d+sHLeJVjPzIe9396rF8KGdNsWsGlWpnJMZKDjgZsz
JQBmMc6UMYRARVP1dIKANN4eY0FSHfEebHcqXLho0mXOUTXe37DWfZza5V9Oify3
JquBd8uUptW1Ue41H4t/ErsCgYEArc5FYtF1QXIlfcDz3oUGz16itUZpgzlb71nd
1cbTm8EupCwWR5I1j+IEQU+JTUQyI1nwWcnKwZI+5kBbKNJUu/mLsRyY/UXYxEZh
ibrNklm94373kV1US/0DlZUDcQba7jz9Yp/C3dT/RlwoIw5mP3UxQCizFspNKOSe
euPeaxUCgYEAntklXwBbokgdDup/u/3ms5Lb/bm22zDOCg2HrlWQCqKEkWkAO6R5
/Wwyqhp/wTl8VXjxWo+W+DmewGdPHGQQ5fFdqgpuQpGUq24YZS8m66v5ANBwd76t
IZdtF5HXs2S5CADTwniUS5mX1HO9l5gUkk+h0cH5JnPtsMCnAUM+BRY=
-----END RSA PRIVATE KEY-----

==> .pin <==
2588
```
I do not understand why we have a pin and a password for `bandit24`.

## TRY to use the private ssh key - FAIL
```
ssh -i bandit26.sshkey bandit26@bandit.labs.overthewire.org -p 2220

ssh: connect to host bandit.labs.overthewire.org port 2220: Connection timed out
```
It timeouts...Can I use a different shell to connect with ssh? 
Let's check it with `man ssh`.  I can't seem to find something that is useful.

## TRY to execute a command when connecting - FAIL
```
ssh -i bandit26.sshkey bandit26@bandit.labs.overthewire.org -p 2220 echo $SHELL

ssh: connect to host bandit.labs.overthewire.org port 2220: Connection timed out
```
It timeouts, and the command fails. How can I find out what shell the `bandit26` use?

## TRY to find clues by scanning ports
```
nc -zv localhost 1-9999

localhost [127.0.0.1] 6012 (?) open
localhost [127.0.0.1] 6011 (?) open
localhost [127.0.0.1] 6010 (?) open
localhost [127.0.0.1] 113 (auth) open
localhost [127.0.0.1] 22 (ssh) open
```
What's the `auth` here at port 113

### TRY Connect to open ports
```
nc -v localhost 113

localhost [127.0.0.1] 113 (auth) open

0 , 0 : ERROR : UNKNOWN-ERROR


nc -v localhost 6012
nc -v localhost 6011
nc -v localhost 6010

```
60xx ports just timeouts.

## TRY to connect via ssh verbosely
```
ssh -vi bandit26.sshkey bandit26@bandit.labs.overthewire.org -p 2220

OpenSSH_7.4p1 Debian-10+deb9u7, OpenSSL 1.0.2u  20 Dec 2019
debug1: Connecting to bandit.labs.overthewire.org [176.9.9.172] port 2220.

debug1: connect to address 176.9.9.172 port 2220: Connection timed out
ssh: connect to host bandit.labs.overthewire.org port 2220: Connection timed out
```
It also timeouts. I'm not sure on how can I approach this now.

# Flag
```
```

# Resources


# Retospective
- Thoughts/Questions to be answered for future.

## What went well?


## What could have gone better?


## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?


## How other people solved this?

