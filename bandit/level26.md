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

The level goal is a bit confusing, can I access the password for `bandit27` with `bandit26` user?

## TRY to view the `bandit27` password - FAIL
```
:e /etc/bandit_pass/bandit27

...
<it_pass/bandit27" [Permission Denied]
```
I'm getting a permission denied.

## TRY invoke some commands
```
:sh
# nothing happened

:echo $SHELL
bash
```

## Current Level Password File
```
/etc/bandit_pass/bandit26
```

# Flag
```
```

# Resources



# Retospective
- Thoughts/Questions to be answered for future.

## What went well?


## What could have gone better?


## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?


## How other people solved this?

