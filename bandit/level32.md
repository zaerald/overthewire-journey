# Level 32

## Level Goal
After all this git stuff its time for another escape. Good luck!

## Access
```
ssh bandit32@bandit.labs.overthewire.org -p 2220
```
pwd: 56a9bf19c63d650ce78e6ec0354ee45e

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit32
```

## Welcome message
After logging in, I am greeted with a different welcome message.
```
WELCOME TO THE UPPERCASE SHELL
>>
```

## TRY some shell commands - FAIL
```
>> whoami
sh: 1: WHOAMI: not found
>> ls
sh: 1: LS: not found
>> id
sh: 1: ID: not found
```
- First thing to note is that every command was changed to an UPPERCASE, as it's
the `UPPERCASE SHELL` and it feels like an UPPERCASE S**HELL**.
- It seems that the shell being used is `sh`.
- Are there commands that are already UPPERCASE-d?
- I need to find out a way for these commands to be translated into a lowercase.

## TRY random characters
```
>> !@#%V$Q^@
sh: 1: !@#%V^@: not found
>> !@#!@#!@#
sh: 1: !@#!@#!@#: not found
>> )@)*$^@$*)^
sh: 1: Syntax error: ")" unexpected
>>
>> \
>> \c
sh: 1: C: not found
>> <>
sh: 2: Syntax error: newline unexpected
>> >
sh: 2: Syntax error: newline unexpected
>> >test
sh: 1: cannot create TEST: Permission denied
>> <
sh: 2: Syntax error: newline unexpected
>> tr <
sh: 2: Syntax error: newline unexpected
>> tr A-Z a-z
sh: 1: TR: not found
>> /bin/bash
sh: 1: /BIN/BASH: not found
```
I can't find a clue here...

## TRY ^D if it'll exit the UPPERCASE shell and go into a normal shell - FAIL
```
>> Connection to bandit.labs.overthewire.org closed.
```
It closed the connection 😅.
- Review [sh](https://man7.org/linux/man-pages/man1/sh.1p.html) man page

## TRY to see if the `--` will end the argument
```
>> : -- echo 'test'
>> echo $?
sh: 1: ECHO: not found
>> : -- sh
>> pwd
sh: 1: PWD: not found
```
This looks like a clue.

## TRY to use environment variables - FAIL
```
>> $PWD
sh: 1: /home/bandit32: Permission denied
>> $PATH
sh: 1: /usr/local/bin:/usr/bin:/bin:/usr/games: not found
>> $ENV
>> $FCEDIT
>> $SHELL
WELCOME TO THE UPPERCASE SHELL
>> $USER
sh: 1: bandit32: not found
>> $SSH_TTY
sh: 1: /dev/pts/49: Permission denied
>> $TERM
sh: 1: xterm-256color: not found
>> $MAIL
sh: 1: /var/mail/bandit32: not found
>> $SHLVL
>> $PATH
sh: 1: /usr/local/bin:/usr/bin:/bin:/usr/games: not found
>> $SSH_CONNECTION
sh: 1: 119.95.246.189: not found
```
- Is there an environment variable that can execute?

## TRY to assign to a variable - FAIL
```
>> TEST=/bin/bash
>> $TEST
>>
```

## TRY bash expansions and positional parameters - PASS
```
>> !!
sh: 1: !!: not found
>> $!
>> $?
sh: 1: 0: not found
>> !-10
sh: 1: !-10: not found
>> %
sh: 1: %: not found
>> $9
>> $1
>> $2
>> $3
>> $4
sh: 1: $: not found
>> $5
>> $6
>> $7
>> $8
>> $9
>> $0
$ whoami
bandit33
```
Just brute-forced it lol. 

## Investigating the `uppershell`
Remembered that `$0` will expand to the name of the shell. 
But our shell is the `uppershell`.

```
echo $SHELL

/home/bandit32/uppershell
```

Why did it work if our `$SHELL` is pointed to the `uppershell`? It should spawn
another `uppershell` right? Should be similar to what happend when we invoked
an environment variable, it just spawned another shell
```
>> $SHELL
WELCOME TO THE UPPERCASE SHELL
```

- View file type
```
file /home/bandit32/uppershell

/home/bandit32/uppershell: setuid ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=e6a8ed571599ce2bfa8b77145dbfc4eb933c1477, not stripped
```
So it's an executable file, and the commands we run are maybe just passed like
`sh @` and thus invoking `$0` will result into invoking the `/bin/sh sh`.

## Retrieve the password
```
cat /etc/bandit_pass/bandit33

c9c3199ddf4121b10cf581a98d51caee
```

# Flag
```
c9c3199ddf4121b10cf581a98d51caee
```

# Resources
- [man sh](https://man7.org/linux/man-pages/man1/sh.1p.html)


# Retospective

## What went well?
- Knowledge in shell environment variables that gave me an idea that we can
  invoke them and basically got lucky in the positional arguments.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
- Learn more about different types of shell, like login shell, interactive shell, etc.
- Knowing more about the positional parameters and shell expansions

## How other people solved this?

### [</ OverTheWire > Bandit Level 32 → Level 33](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-32-level-33-b98a171b4eca) by </ The Girl Who Encrypts >

They have also used the `$0` positional parameter.

