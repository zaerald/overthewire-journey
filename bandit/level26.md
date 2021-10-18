# Level 26

## Level Goal
Good job getting a shell! Now hurry and grab the password for bandit27!

## Access
Perform the Level 25.

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit26
```

The level goal is a bit confusing, can I access the password for `bandit27` with `bandit26` user?

## TRY to view the `bandit27` password - FAIL
```
:e /etc/bandit_pass/bandit27

...
<it_pass/bandit27" [Permission Denied]
```
I'm getting a permission denied.

## TRY invoke some commands - FAIL
```
:sh
# nothing happened

:echo $SHELL
bash
```

## TRY to output the command to Vim buffer - FAIL
Run this to the vim command
```
:read !echo $SHELL
```

Nothing happened

## TRY to inoke command from vim buffer to the shell - FAIL
We can execute a command by 'writing' from vim buffer to the `$SHELL` or `/bin/bash`
```
# write this to the vim buffer
echo 'test command'
```

Run this to the vim command
```
:w !$SHELL
```

There still no output

## TRY to execute a subshell without going inside vim - FAIL
```
!echo 'test'
```
Doesn't work 😭

## TRY to create files to the temporary directory - FAIL
- Create files from the `/tmp/` directory and see if we can write from commands.
```
:e /tmp/ihavesomerandomfolder/myfile.txt
```

- Create a script and invoke it, then write to another file
```
echo 'test' > /tmp/ihavesomerandomfolder/out.txt

:w !/bin/bash
```

- Read the file
```
:e /tmp/ihavesomerandomfolder/out.txt
```
The file content is empty 🤧

Whenever I try to invoke some commands, the `text.txt` file content shows up.
Even though I have written the commands from vim buffer to the `$SHELL` or `/bin/bash`, it
seems that the commands are not invoked properly. 

## Let's verify the subshell invoked by vim
```
:set shell?

shell=/usr/bin/showtext
```
Oh! It was using the `/usr/bin/showtext` for it's subshell.
This explains whenever we invoke commands, the `text.txt` file content shows up!
Where does it inherit it? From our login? I do not know how it works.

## Investigating why our `shell` was set to `/usr/bin/showtext`
Let's check in `bandit25` user and see the help page and the `$SHELL` environment.

- Display `$SHELL`
```
echo $SHELL

/bin/bash
```

- Invoke vim
```
vim
```

- Check for `shell` value
```
:set shell?

/bin/bash
```

- Verify if changing `$SHELL` affects vim `shell`
```
export SHELL=/bin/bash/TEST
echo $SHELL
```

- Invoke vim and view the `shell` value
```
vim

:set shell?

/bin/bash/TEST
```
It's using the `$SHELL` environment variable. I'll assume that vim 
will pick this up. Let's verify it on `bandit26` shell.


## Invoke the vim from more again
- Verify the `shell` value again
```
:set shell?

/usr/bin/showtext
```

- Update `shell` value to `/bin/bash`
```
:set shell=/bin/bash
```

## Spawn a shell and check user
```
:sh

$whoami
bandit26
```

## View the `$SHELL` value
```
echo $SHELL

/usr/bin/showtext
```
The vim used the `$SHELL` environment variable for its `shell` config.

## List the available files
```
ls -lah

...
-rwsr-x---  1 bandit27 bandit26 7.2K May  7  2020 bandit27-do
-rw-r--r--  1 root     root      220 May 15  2017 .bash_logout
-rw-r--r--  1 root     root     3.5K May 15  2017 .bashrc
-rw-r--r--  1 root     root      675 May 15  2017 .profile
drwxr-xr-x  2 root     root     4.0K May  7  2020 .ssh
-rw-r-----  1 bandit26 bandit26  258 May  7  2020 text.txt
```
We have a setuid permission bit for `bandit27-do` and looks like this is what
we did in previous level.

## Check `bandit27-do` behavior
```
./bandit27-do whoami

bandit27
```
Confirmed that it's just the same.

## Retrieve `bandit27` password
```
./bandit27-do cat /etc/bandit_pass/bandit27

3ba3118a22e93127a4ed485be72ef5ea
```

# Flag
```
3ba3118a22e93127a4ed485be72ef5ea
```

# Retospective

## What went well?
- I have learned that vim uses `$SHELL` to set the `shell` config.
- Know a bit about vim and managed to explore to access a subshell.

## What could have gone better?
- Knowing that even though we're writing the vim buffer to `/bin/bash` it's
  still invoking a subshell to perform that command. I could've noticed it
  in a few more tries.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
- Improve knowledge in common usage of environment variables.

## How other people solved this?

### [OverTheWire: Bandit Level 26](https://medium.com/secttp/overthewire-bandit-level-26-82c82ae45e5) by S.P.

They have also set the `shell` config for the vim.

### [</ OverTheWire > Bandit Level 26 → Level 27](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-26-level-27-2d55a28fcd0a) by </ The Girl Who Encrypts >

They also did the same thing.

