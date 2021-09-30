# Level 18

## Level Goal
The password for the next level is stored in a file `readme` in the
homedirectory.  Unfortunately, someone has modified `.bashrc` to log you out
when you log in with SSH.

## Access
```
ssh bandit18@bandit.labs.overthewire.org -p 2220
```
pwd: kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd

## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## Tried to access
```
ssh bandit18@bandit.labs.overthewire.org -p 2220

Byebye !                                                                                                                Connection to bandit.labs.overthewire.org closed. 
```
Is there a way for me to just get the file?

## Pull out the `readme` file from the server
```
scp -P 2220 bandit18@bandit.labs.overthewire.org:/home/bandit18/readme .

cat readme
IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x
```

## View what `.bashrc` file does
Just got curious on how they kick out the user whenever they try to access via ssh. Was it just `exit` at the end?
```
scp -P 2220 bandit18@bandit.labs.overthewire.org:/home/bandit18/.bashrc .

tail -3 .bashrc
echo 'Byebye !'
exit 0
```
They just added the `exit 0` as ssh tries to login as the user and `.bashrc` gets loaded.


# Flag
```
IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x
```

# Retospective

## What went well?
* I have an idea to solve by pulling the file from the server.

## What could have gone better?
* By properly specifying the port. I have added it at the last parameter.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
* Understanding the `-t` available parameter in `ssh`.
manpage says "-t' Force pseudo-tty allocation".
* I need to improve my understanding what are the `tty`.

## How other people solved this?

### [OverTheWire: Bandit Level 18](https://medium.com/secttp/overthewire-bandit-level-18-c3932b4f4434) by S.P.

They still used `ssh` but with `-t` parameter.
```
ssh bandit18@bandit.labs.overthewire.org -p 2220 "cat ~/readme"
```
