# Level 28

## Level Goal
There is a git repository at
`ssh://bandit28-git@localhost/home/bandit28-git/repo`.
The password for the user bandit28-git is the same as for the user bandit28.

Clone the repository and find the password for the next level.

## Access
```
ssh bandit28@bandit.labs.overthewire.org -p 2220
```
pwd: 0ef186ac70e04ea33b4c1853d2526fa2

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit28
```

## Create temporary directory
```
cd $(mktemp -d) 
# /tmp/tmp.4mFY9hb93N
```

## Clone the repository
```
git clone ssh://bandit28-git@localhost/home/bandit28-git/repo
```

## Change directory and list files
```
cd repo

ls -lah

...
drwxr-sr-x 8 bandit28 root 4.0K Oct 18 15:18 .git
-rw-r--r-- 1 bandit28 root  111 Oct 18 15:18 README.md
```

## Read the README.md file
```
less README.md

# Bandit Notes
Some notes for level29 of bandit.

## credentials

- username: bandit29
- password: xxxxxxxxxx
```
It's a clue but not really a clue.

## View git history
```
git log --oneline --all --decorate --graph

* edd935d (HEAD -> master, origin/master, origin/HEAD) fix info leak
* c086d11 add missing data
* de2ebe2 initial commit of README.md
```

- It's just few commits, let's view the full log.
```
git log

commit edd935d60906b33f0619605abd1689808ccdd5ee
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    fix info leak

commit c086d11a00c0648d095d04c089786efef5e01264
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    add missing data

commit de2ebe2d5fd1598cd547f4d56247e053be3fdc38
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    initial commit of README.md
```
There's an interesting commit for the latest one. Let's see the diff.

## View commit diff
There are multiple ways to do this, but it's just the recent one so I'll just
check the relative to the `HEAD`.
```
git diff HEAD^

diff --git a/README.md b/README.md
index 3f7cee8..5c6457b 100644
--- a/README.md
+++ b/README.md
@@ -4,5 +4,5 @@ Some notes for level29 of bandit.
 ## credentials

 - username: bandit29
-- password: bbc96594b4e001778eee9975372716b2
+- password: xxxxxxxxxx
```
We can also do `git show <commit-sha>`
They just removed the password from the `README.md` file.

## View other commit changes
```
git show c086d11a00c0648d095d04c089786efef5e01264
# This commit added the password.


git show de2ebe2d5fd1598cd547f4d56247e053be3fdc38
# This commit created the initial notes.
```

# Flag
```
bbc96594b4e001778eee9975372716b2
```
# Retospective

## What went well?
- I know how to use git.
  My expectation from previous level was met with this level.

## How other people solved this?

### [OverTheWire: Bandit Level 28](https://medium.com/secttp/overthewire-bandit-level-28-2a5453c6e76c) by S.P.

They have used a different command to show the changes from the `HEAD` commit.
```
git log -p -1
```

### [</ OverTheWire > Bandit Level 28 → Level 29](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-28-level-29-87d26873773d) by </ The Girl Who Encrypts >

They used `git show` to view all the change diff of all the commits.

