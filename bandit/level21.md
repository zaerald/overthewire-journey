# Level 21

## Level Goal
A program is running automatically at regular intervals from cron, the
time-based job scheduler. Look in `/etc/cron.d/` for the configuration and see
what command is being executed.

## Access
```
ssh bandit21@bandit.labs.overthewire.org -p 2220
```
pwd: gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr

## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## Identify the content of the directory
```
l /etc/cron.d

...
-rw-r--r--  1 root root   62 May 14  2020 cronjob_bandit15_root
-rw-r--r--  1 root root   62 Jul 11  2020 cronjob_bandit17_root
-rw-r--r--  1 root root  120 May  7  2020 cronjob_bandit22
-rw-r--r--  1 root root  122 May  7  2020 cronjob_bandit23
-rw-r--r--  1 root root  120 May 14  2020 cronjob_bandit24
-rw-r--r--  1 root root   62 May 14  2020 cronjob_bandit25_root
-rw-r--r--  1 root root  102 Oct  7  2017 .placeholder
```

So I'm working with cronjobs.

## View the content of `.placeholder`
```
less /etc/cron.d/.placeholder

# DO NOT EDIT OR REMOVE
# This file is a simple placeholder to keep dpkg from removing this directory
```
Just curious about this file.

## List cron
```
crontab -l

crontabs/bandit21/: fopen: Permission denied
```

## Edit cron
```
crontab -e

crontabs/bandit21/: fdopen: Permission denied
```

## Read the contents under the directory
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
They are running some scripts under `/usr/bin/*`


## Identify the file `/usr/bin/
```
less /usr/bin/cronjob_bandit22.sh

#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```
It writes the password of user `bandit22` to some temporary file.

## Read the temporary file
```
cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv

Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI
```

## Others - Identify the bandit files under `/usr/bin`
```
cat $(ls /usr/bin | grep -Eo "cronjob_bandit[0-9]{1,2}(_root)?.sh" | awk '{print "/usr/bin/"$1}' | paste -s)

cat: /usr/bin/cronjob_bandit15_root.sh: Permission denied
cat: /usr/bin/cronjob_bandit17_root.sh: Permission denied
#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat: /usr/bin/cronjob_bandit23.sh: Permission denied
cat: /usr/bin/cronjob_bandit24.sh: Permission denied
cat: /usr/bin/cronjob_bandit25_root.sh: Permission denied 
```

# Flag
```
Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI
```

# Resources

# Retospective

## What went well?
* I have used my knowledge in cron jobs.

## What could have gone better?
* If I can just edit the `crontab` but remembered that it's a shared server and other people might crete scripts from `/tmp` and execute it from cronjobs.


## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
* Improve more knowledge in scripting.

## How other people solved this?

### [</ OverTheWire > Bandit Level 21 → Level 22](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-21-level-22-37f933ab3a57) by </ The Girl Who Encrypts >

Similar solution to what I did.
