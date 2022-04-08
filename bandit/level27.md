# Level 27

## Level Goal
There is a git repository at
`ssh://bandit27-git@localhost/home/bandit27-git/repo`.
The password for the user bandit27-git is the same as for the user bandit27.

## Access
```
ssh bandit27@bandit.labs.overthewire.org -p 2220
```
pwd: 3ba3118a22e93127a4ed485be72ef5ea

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit27
```

## Create temporary directory
```
cd $(mktemp -d)
# /tmp/tmp.8GCD3DuPsC
```

## Clone the repository
```
git clone ssh://bandit27-git@localhost/home/bandit27-git/repo
```

## Change directory and list files
```
cd repo

ls -lah

...
drwxr-sr-x 8 bandit27 root 4.0K Oct 18 15:09 .git
-rw-r--r-- 1 bandit27 root   68 Oct 18 15:09 README
```

## Read the README file
```
less README

0ef186ac70e04ea33b4c1853d2526fa2
```
I was expecting for this level to have passwords from history...
Let's investigate further

## View git history
```
git log --oneline --all --decorate --graph

* 4d1369b (HEAD -> master, origin/master, origin/HEAD) initial commit of README
```
- It has only one commit, let's view the author!
```
git log

Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:47 2020 +0200

    initial commit of README
```
Thanks Ben Dover for creating this game!

# Flag
```
0ef186ac70e04ea33b4c1853d2526fa2
```

# Retrospective

## What went well?
- I'm familiar at working with git repositories.

## How other people solved this?

### [OverTheWire: Bandit Level 27](https://medium.com/secttp/overthewire-bandit-level-27-41b35918d637) by S.P.

They also did the same.

