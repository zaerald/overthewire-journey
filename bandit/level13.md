# Level 13

## Level Goal
The password for the next level is stored in `/etc/bandit_pass/bandit14` and can
only be read by user `bandit14`. For this level, you don’t get the next
password, but you get a private SSH key that can be used to log into the next
level. Note: `localhost` is a hostname that refers to the machine you are
working on.

## Access
```
ssh bandit13@bandit.labs.overthewire.org -p 2220
```
pwd: 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL

## List Files
```
# adding alias to make life easier
alias l='ls -lah'
l

total 24K
drwxr-xr-x  2 root     root     4.0K May  7  2020 .
drwxr-xr-x 41 root     root     4.0K May  7  2020 ..
-rw-r--r--  1 root     root      220 May 15  2017 .bash_logout
-rw-r--r--  1 root     root     3.5K May 15  2017 .bashrc
-rw-r--r--  1 root     root      675 May 15  2017 .profile
-rw-r-----  1 bandit14 bandit13 1.7K May  7  2020 sshkey.private
```

## Login with private SSH key - FAIL
```
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
```
It just hangs and results to Connection timed out.

## Copy file from server - FAIL
```
scp -P 2220 ubandit13@bandit.labs.overthewire.org:/home/bandit13/sshkey.private $HOME/scratch
```
Dunno why, but tried to copy on my local machine and try it. Access denied

## Add SSH Private Key
```
ssh-add sshkey.private

Identity added: sshkey.private (sshkey.private)
```
Forgot that you have to add the key to the agent first 🤦.

## Relogin again - FAIL
```
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
```
Still fails to login

## Test SSH connection - FAIL
```
ssh -T bandit.labs.overthewire.org
ssh -T bandit14@bandit.labs.overthewire.org
```

## Try SSH `localhost` with port - FAIL
```
ssh -i sshkey.private bandit14@localhost -p 2220

ssh: connect to host localhost port 2220: Connection refused
```
## SSH `localhost` without port
```
ssh -i sshkey.private bandit14@localhost
```

## I'm In! *hacker voice* 😜
```
echo $USER

bandit14
```

# Flag
```
sshkey.private
```

# Retospective
* My first time ssh with the same server, and I do not need to provide the host, just the `localhost` should be fine.
* I'm not sure if I needed to perform `ssh-add sshkey.private`. I can't verify it yet.
* Just keep in mind that the ssh private key should be around `600` or `400`, which means that it should only be *read/write* or just *read* permission.

## What went well?
Was able to figure out that I need to use `localhost` from the *Level Goal* with its *Note*.

## What could have gone better?
Knowing that I do not need to use the host whenever it's the same server I'm trying to ssh into.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
Improve knowledge in how ssh works within the same server, as I also do not need to provide the `port`. I do not understand if ssh to user `bandit14` does not allow port or does it already use the port used when accessing user `bandit13`.
