# Level 29

## Level Goal
There is a git repository at `ssh://bandit29-git@localhost/home/bandit29-git/repo`.
The password for the user bandit29-git is the same as for the user bandit29.

Clone the repository and find the password for the next level.

## Access
```
ssh bandit29@bandit.labs.overthewire.org -p 2220
```
pwd: bbc96594b4e001778eee9975372716b2

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit29
```

## Create temporary directory
```
cd $(mktemp -d)
# /tmp/tmp.gHNM8JGU4b
```

## Clone the repository
```
git clone ssh://bandit29-git@localhost/home/bandit29-git/repo
```

## Change directory and list files
```
cd repo

ls -lah

...
drwxr-sr-x 8 bandit29 root 4.0K Oct 18 15:35 .git
-rw-r--r-- 1 bandit29 root  131 Oct 18 15:35 README.md
```

## Read the `README.md` file
```
less README.md

# Bandit Notes
Some notes for bandit30 of bandit.

## credentials

- username: bandit30
- password: <no passwords in production!>
```
It's a hint that there's a password in other environment. 
This is a common issue where developers store password in other branches, and
might push it public.

## View git history
```
git log --oneline --all --decorate --graph

* bc83328 (origin/dev) add data needed for development
* 8e6c203 add gif2ascii
| * 786d5be (origin/sploits-dev) add some silly exploit, just for shit and giggles
|/
* 208f463 (HEAD -> master, origin/master, origin/HEAD) fix username
* 18a6fd6 initial commit of README.md
```
Based on the history, there are multiple branches.

## List local and remote branches
```
git branch -a

* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/dev
  remotes/origin/master
  remotes/origin/sploits-dev
```

## View the commits
- Let's look for the `dev` branch first
```
git show bc83328

Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:52 2020 +0200

    add data needed for development

diff --git a/README.md b/README.md
index 1af21d3..39b87a8 100644
--- a/README.md
+++ b/README.md
@@ -4,5 +4,5 @@ Some notes for bandit30 of bandit.
 ## credentials

 - username: bandit30
-- password: <no passwords in production!>
+- password: 5b90576bedb2cc04c86a9e924ce42faf
```
This might be the flag already.

- Checkout `sploits-dev` and check if there are commits.
```
git checkout sploits-dev

git cherry -v master
+ 786d5bea2bd2dcbed2c8896a310c3c5306bc713c add some silly exploit, just for shit and giggles
```
It has one commit ahead the `master` branch.

- View the changes
```
git show 786d5be

commit 786d5bea2bd2dcbed2c8896a310c3c5306bc713c
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:51 2020 +0200

    add some silly exploit, just for shit and giggles

diff --git a/exploits/horde5.md b/exploits/horde5.md
new file mode 100644
index 0000000..8b13789
--- /dev/null
+++ b/exploits/horde5.md
@@ -0,0 +1 @@
+
```
This commit just added `exploits/horde5.md` file with a blank line.

- View other commits
```
git show 8e6c203

commit 8e6c203f885bd4cd77602f8b9a9ea479929ffa57
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:51 2020 +0200

    add gif2ascii

diff --git a/code/gif2ascii.py b/code/gif2ascii.py
new file mode 100644
index 0000000..8b13789
--- /dev/null
+++ b/code/gif2ascii.py
@@ -0,0 +1 @@
+
```
This is similar to the previous commit, it just added `code/gif2ascii.py` file
that contains a blank line.

# Flag
```
5b90576bedb2cc04c86a9e924ce42faf
```

# Retrospective

## What went well?
- My knowledge in git still useful for this level.

## How other people solved this?

### [OverTheWire: Bandit Level 29](https://medium.com/secttp/overthewire-bandit-level-29-9f2ee436c057) by S.P.

They checkout the `dev` branch and performed `git log -p -1`.

### [</ OverTheWire > Bandit Level 29 → Level 30](https://medium.com/@theGirlWhoEncrypts/overthewire-bandit-level-29-level-30-f9d5a4167711) by </ The Girl Who Encrypts >

They have checkout the `dev` branch, and read the `README.md` file.
```
git checkout dev
cat README.md
```

