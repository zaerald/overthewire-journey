# Level 19

## Level Goal
To gain access to the next level, you should use the `setuid` binary in the
homedirectory. Execute it without arguments to find out how to use it. The
password for this level can be found in the usual place (`/etc/bandit_pass`),
after you have used the `setuid` binary.

## Access
```
ssh bandit19@bandit.labs.overthewire.org -p 2220
```
pwd: IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x

## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## List the files
```
l

total 28K
drwxr-xr-x  2 root     root     4.0K May  7  2020 .
drwxr-xr-x  2 root     root     4.0K May  7  2020 .
drwxr-xr-x 41 root     root     4.0K May  7  2020 ..
-rwsr-x---  1 bandit20 bandit19 7.2K May  7  2020 bandit20-do
-rw-r--r--  1 root     root      220 May 15  2017 .bash_logout
-rw-r--r--  1 root     root     3.5K May 15  2017 .bashrc
-rw-r--r--  1 root     root      675 May 15  2017 .profile
```
My first time to encounter `-rwsr-x---` having an `s` bit in the file permission.

## TRY to read the file
```
less bandit20-do
```
It's gibberish!

## TRY to execute the file
```
./bandit20-do

Run a command as another user.
Example: ./bandit20-do id
```
Is it the user id?

## Get the id of the current user
```
id

uid=11019(bandit19) gid=11019(bandit19) groups=11019(bandit19)
```

## TRY to execute the file with my ID - FAIL
```
./bandit20-do 11019

env: ‘11019’: No such file or directory
```
I do not understand what `setuid` really is for. Time to dig into the resources!

## Identify the `/etc/bandit_pass` directory
```
ls -ldh /etc/bandit_pass

drwxr-xr-x 2 root root 4.0K May  7  2020 /etc/bandit_pass
```

## TRY to execute the file with the pass directory - FAIL
```
./bandit20-do /etc/bandit_pass

env: ‘/etc/bandit_pass’: Permission denied
```
I do not know how to use the binary file. What `id` does it need for the argument?

## TRY to perform what is displayed from the error message
```
./bandit20-do id

uid=11019(bandit19) gid=11019(bandit19) euid=11020(bandit20) groups=11019(bandit19)
```
FML. It was actually an example and not an argument

## Display the password
```
./bandit20-do cat /etc/bandit_pass/bandit20
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
```

# Flag
```
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
```

# Resources
* [setuid - wikipedia](https://en.wikipedia.org/wiki/Setuid)
* [Linux Command Line (25) setuid](https://youtu.be/V8gexCVHcN0)
* [Linux SetUID, SetGID, Sticky Bit](https://youtu.be/2gHp_CgUets)

# Retrospective
* It is worth noting that when the bit is capital `S` rather than the lowercase `s`, this means that the file doesn't have an executable bit.

## What went well?
* Understood how SetUID, SetGID, and Sticky Bit. It's a different permission to allow other users to perform some escalated privileges or perform in behalf of the owner of the binary file with SetUID permission bit.

## What could have gone better?
* I was a bit dumb that the binary file just actually accepts an arbitrary commands and delegate it to `bandit20` and not accepting an `<id>` argument. More like `./bandit20-do <command>` and not `./bandit20-do <id>`.
* Just tried out what was printed and not assumed that it needs an `id` argument. The filename also implies that it `do`es something, so an arbitrary command could be passed.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
* Learn more about the user permissions

## How other people solved this?

### [</ OverTheWire > Bandit Level 19 → Level 20](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-19-level-20-d6b15b5d803) by </The Girl Who Encrypts>
They have performed some good checks, like:
* Check with `whoami` and it shows that the user is indeed `bandit20`
``` 
./bandit20-do whoami

bandit20
```
* Identify the file, for which I forgot to do
```
file bandit20-do

bandit20-do: setuid ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=8e941f24b8c5cd0af67b22b724c57e1ab92a92a1, not stripped
```

