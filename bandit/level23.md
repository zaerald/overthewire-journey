# Level 23

## Level Goal
A program is running automatically at regular intervals from cron, the
time-based job scheduler. Look in `/etc/cron.d/` for the configuration and see
what command is being executed.

NOTE: This level requires you to create your own first shell-script. This is a
very big step and you should be proud of yourself when you beat this level!

NOTE 2: Keep in mind that your shell script is removed once executed, so you may
want to keep a copy around…

## Access
```
ssh bandit23@bandit.labs.overthewire.org -p 2220
```
pwd: jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n

## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## Review the content of the files under `/etc/cron.d`
```
tail 1 /etc/cron.d/* 2> /dev/null

==> /etc/cron.d/cronjob_bandit15_root <==
* * * * * root /usr/bin/cronjob_bandit15_root.sh &> /dev/null

==> /etc/cron.d/cronjob_bandit17_root <==
* * * * * root /usr/bin/cronjob_bandit17_root.sh &> /dev/null

==> /etc/cron.d/cronjob_bandit22 <==
@reboot bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
* * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null

==> /etc/cron.d/cronjob_bandit23 <==
@reboot bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
* * * * * bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null

==> /etc/cron.d/cronjob_bandit24 <==
@reboot bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
* * * * * bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null

==> /etc/cron.d/cronjob_bandit25_root <==
* * * * * root /usr/bin/cronjob_bandit25_root.sh &> /dev/null
```

## Identify the files used in cron
```
more $(ls /usr/bin | grep -Eo "cronjob_bandit[0-9]{1,2}(_root)?.sh" | awk '{print "/usr/bin/"$1}' | paste -s) 2> /dev/null | cat

::::::::::::::
/usr/bin/cronjob_bandit23.sh
::::::::::::::
#!/bin/bash

myname=$(whoami)
mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)

echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"

cat /etc/bandit_pass/$myname > /tmp/$mytarget
::::::::::::::
/usr/bin/cronjob_bandit24.sh
::::::::::::::
#!/bin/bash

myname=$(whoami)

cd /var/spool/$myname
echo "Executing and deleting all scripts in /var/spool/$myname:"
for i in * .*;
do
    if [ "$i" != "." -a "$i" != ".." ];
    then
        echo "Handling $i"
        owner="$(stat --format "%U" ./$i)"
        if [ "${owner}" = "bandit23" ]; then
            timeout -s 9 60 ./$i
        fi
        rm -f ./$i
    fi
done
```
This tells that scripts are executed under `/var/spool/bandit24`


# Flag

# Resources



# Retospective
* Thoughts/Questions to be answered for future.

## What went well?


## What could have gone better?


## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?


## How other people solved this?

