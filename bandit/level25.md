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

## TRY to connect with localhost - PASS
```
ssh -i bandit26.sshkey bandit26@localhost

...

  Enjoy your stay!

  _                     _ _ _   ___   __
 | |                   | (_) | |__ \ / /
 | |__   __ _ _ __   __| |_| |_   ) / /_
 | '_ \ / _` | '_ \ / _` | | __| / / '_ \
 | |_) | (_| | | | | (_| | | |_ / /| (_) |
 |_.__/ \__,_|_| |_|\__,_|_|\__|____\___/
Connection to localhost closed.
```

I forgot that when connecting to the same host, I do not need to provide the
hostname and the port.

## Look for bandit26 passwd file
```
cat /etc/passwd | grep bandit26

bandit26:x:11026:11026:bandit level 26:/home/bandit26:/usr/bin/showtext
```
It's using `/usr/bin/showtext`

## Analyze the `showtext` file
```
cat /usr/bin/showtext

#!/bin/sh

export TERM=linux

more ~/text.txt
exit 0
```
First time seeing the `TERM` environment variable. Let's look for an answer: [this][term1] and [this][term2]..
It executes `more` to `~/text.txt` file then exits. Can I just change the `more` binary,
by changing `PATH` environment variable?

[term1]: https://unix.stackexchange.com/questions/198794/where-does-the-term-environment-variable-default-get-set
[term2]: https://askubuntu.com/questions/920908/what-does-export-term-linux-actually-do-when-inside-a-script

## Check file permission
```
ls -lah /home/bandit26/text.txt

-rw-r----- 1 bandit26 bandit26 258 May  7  2020 /home/bandit26/text.txt
```
I do not have the right permission to view the file for the current user.
But it just seems that it's just the ASCII art shown when logging in...

## TRY to mess up `more` command - FAIL
```
# create empty directory
$ cd $(mktemp -d)
/tmp/tmp.9E8ImbEyBF

# use vim instead
$ which vim
/usr/bin/vim

$ ln -s /usr/bin/vim more
$ ls

more

# check PATH
$ echo $PATH

/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

# update PATH
$ export PATH=/tmp/tmp.9E8ImbEyBF:$PATH

# check if more is vim
$ more --version

VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Jun 21 2019 04:10:35)
...

# try to see if the `PATH` would be inherited for the same host
$ cd ~
$ ssh -i bandit26.sshkey bandit26@localhost
```

- I wasn't able to override the command, turns out that when logging in the `$PATH`
  is not inherited. It uses its own environment variables, and realizing that it
  is logical to use its own environment variables and not inherit them 🤦.

- Is the `TERM=linux` the hint? I can't seem to find a hint for that.
- Is there more for `more` command? Let's scan the man page.

## Scanning `more` man page
```
man more
```
I can't find anything that will help me, as I can't pass any **OPTIONS** directly.
Why do they need to set `TERM=linux`?

## Reproducing the script
This way I can investigate further and doesn't need to wait when ssh-ing.

```text
$ cd $(mktemp -d)
# /tmp/tmp.yET9YKOl0l

$ touch test.sh

#!/bin/sh

export TERM=linux

more /tmp/tmp.yET9YKOl0l/text.txt
exit 0

$ chmod u+x test.sh

$ touch text.txt
  _                     _ _ _   ___   __
 | |                   | (_) | |__ \ / /
 | |__   __ _ _ __   __| |_| |_   ) / /_
 | '_ \ / _` | '_ \ / _` | | __| / / '_ \
 | |_) | (_| | | | | (_| | | |_ / /| (_) |
 |_.__/ \__,_|_| |_|\__,_|_|\__|____\___/
```

### Observing the script behavior
- Comparing this to `less` command, when the `less` command reads a file it stays
there. The `more` command just exits after reading thus it continues to 
`exit 0` and `ssh` wouldn't work.
- How can I make the `more` command have a similar behavior? Can I pass a
  command argument? But, it's a script that I do not have a write permission so
  I wouldn't be able to pass anything.
- Reading from man page of `more` I can invoke a vi editor which can invoke a subshell.
- Playing with `more`, it won't exit the program as long as there are more
  content to the file! Previously, checked the file permission and we do not
  have any write access...

## TRY to play with `more` font size
If we can't change the file content of the file, let's find out if we can force
the `more` to not suspend as it can't print everything if the font is VERY
large.

### `more` with small font size
![more small text](level25/test-small-text.png)

### `more` with LARGE text
![more large text](level25/test-large-text.png)

IT WORKS!!! We can now invoke the `vi` editor and invoke a subshell from there.

### `more` invoking `vi` editor
We can invoke the `vi` editor from `more`, stated in the man page by just pressing `v`
> Start up an editor at current line.  The editor is taken from the environment
> variable VISUAL if defined, or EDITOR if VISUAL is not defined, or defaults
> to vi if neither VISUAL nor EDITOR is defined.

We just need to ensure that `$EDITOR` contains `vi` or both `$EDITOR` and `$VISUAL` is empty.

```
echo $EDITOR
# empty
echo $VISUAL
# empty
```

![invoke vi editor](level25/test-invoke-vi-editor.png)

### Invoking commands from `vi` editor
```
:!echo $SHELL

/bin/bash
```

![run command from vi](level25/test-run-command.png)

Output

![command output](level25/test-command-output.png)

- Our testing works for invoking a command from `more`. It'll only work for `ssh`
  if the `bandit26` user doesn't set the `$EDITOR` or `$VISUAL` 
  into something else.

## TRY to perform the same steps

### Overview
1. Increase the font size
2. Perform `ssh`
3. Invoke `vi`
4. Retrieve password file by editing `:e /etc/bandit_pass/bandit26`

### 1. Increase the font size

![increase font size](level25/attempt01-increase-font-size.png)


### 2. Perform `ssh`
`ssh` performed and `more` suspended

![more suspended](level25/attempt01-more-suspended.png)

### 3. Invoke `vi`

![invoke vi](level25/attempt01-invoke-vi.png)
Phew, we can properly invoke `vi` editor. Fortunately the environment variables
was set to `vi` or undefined.

### 4. Retrieve password file by editing `:e /etc/bandit_pass/bandit26`

![edit password file](level25/attempt01-edit-bandit-pw.png)

Viewing the password content
![get flag](level25/attempt01-get-flag.png)

# Flag
```
5czgV9L3Xx8JPOyRbXh6lQbmIOWvPT6Z
```

# Retospective
- It's a bit odd to solve this by resizing the font size lol.
- This took me while to solve and did some multiple iterations.

## What went well?
- I know that we can invoke commands or subshell from `vi`, as I've been using
  `vim` for my editor.
- Scanning `more` man page helped me a lot, as I noticed that we can invoke
  `vi` if some environment varibles are undefiend.

## What could have gone better?
- Understanding how `more` works.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
- Knowledge in `TERM=linux`.

## How other people solved this?

### [OverTheWire’s Bandit 25 -> 26 Shell](https://medium.com/@coturnix97/overthewires-bandit-25-26-shell-355d78fd2f4d) by coturnix97

They have resized their terminal, and wasn't surprised as I have resized the
font. Was expecting that they have managed to edit the `text.txt` file and add
more contents from it.

### [OverTheWire: Bandit Level 25](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-25-level-26-323defac0551) by S.P.

They have also resized their terminal.

