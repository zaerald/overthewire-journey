# Level 22

## Level Goal
A program is running automatically at regular intervals from cron, the
time-based job scheduler. Look in `/etc/cron.d/` for the configuration and see
what command is being executed.

NOTE: Looking at shell scripts written by other people is a very useful skill.
The script for this level is intentionally made easy to read. If you are having
problems understanding what it does, try executing it to see the debug
information it prints.

## Access
```
ssh bandit22@bandit.labs.overthewire.org -p 2220
```
pwd: Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI

## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## Review the content of the files under `/etc/cron.d`
```
awk '(FNR==1){print ">>>" FILENAME }1' /etc/cron.d/*

>>>/etc/cron.d/cronjob_bandit15_root
* * * * * root /usr/bin/cronjob_bandit15_root.sh &> /dev/null
>>>/etc/cron.d/cronjob_bandit17_root
* * * * * root /usr/bin/cronjob_bandit17_root.sh &> /dev/null
>>>/etc/cron.d/cronjob_bandit22
@reboot bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
* * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
>>>/etc/cron.d/cronjob_bandit23
@reboot bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
* * * * * bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
>>>/etc/cron.d/cronjob_bandit24
@reboot bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
* * * * * bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
>>>/etc/cron.d/cronjob_bandit25_root
* * * * * root /usr/bin/cronjob_bandit25_root.sh &> /dev/null
```

## Identify the files used in cron
```
tail 1 $(ls /usr/bin | grep -Eo "cronjob_bandit[0-9]{1,2}(_root)?.sh" | awk '{print "/usr/bin/"$1}' | paste -s) 2> /dev/null

==> /usr/bin/cronjob_bandit22.sh <==
#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv

==> /usr/bin/cronjob_bandit23.sh <==
#!/bin/bash

myname=$(whoami)
mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)

echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"

cat /etc/bandit_pass/$myname > /tmp/$mytarget
```
I have reused and improved my script from previous level. It now shows the content with the filename.
The script creates an `md5` hash based on the string for the filename that contains the password of `bandit23`. Fortunately, the script outputs the filename. 
## See script permissions
```
l /usr/bin/cronjob_bandit23.sh

-rwxr-x--- 1 bandit23 bandit22 211 May  7  2020 /usr/bin/cronjob_bandit23.sh
```
We can actually run this file to see how it works.

## Execute the script
```
!$

/usr/bin/cronjob_bandit23.sh
Copying passwordfile /etc/bandit_pass/bandit22 to /tmp/8169b67bd894ddbb4412f91573b38db3
```

## Generate the temporary filename and print password
```
name=bandit23
mytarget=$(echo I am user $name | md5sum | cut -d ' ' -f 1) && echo "filename: $mytarget" && cat /tmp/$mytarget

filename: 8ca319486bfbbc3663ea0fbe81326349
jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n
```

# Flag
```
jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n
```

# Retrospective

## What went well?
* I can understand shell scripts.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
* Learn and improve my knowledge in shell scripting. More about POSIX compliant and whatnot.

## How other people solved this?

### [OverTheWire: Bandit Level 22](https://medium.com/secttp/overthewire-bandit-level-22-4b80c885524) by S.P.

They have run the portion of the script to identify the filename
```
myname=bandit23
echo I am user $myname | md5sum | cut -d ' ' -f 1
```

