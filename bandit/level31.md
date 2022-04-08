# Level 31

## Level Goal
There is a git repository at `ssh://bandit31-git@localhost/home/bandit31-git/repo`.
The password for the user bandit31-git is the same as for the user bandit31.

Clone the repository and find the password for the next level.

## Access
```
ssh bandit31@bandit.labs.overthewire.org -p 2220
```
pwd: 47e603bb428404d265f59c42920d81e5

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit31
```

## Create temporary directory
```
cd $(mktemp -d)
# /tmp/tmp.L6vlPoUc2i
```

## Clone the repository
```
git clone ssh://bandit31-git@localhost/home/bandit31-git/repo
```

## Change directory and list files
```
cd repo

ls -lah

...
drwxr-sr-x 8 bandit31 root 4.0K Oct 18 22:54 .git
-rw-r--r-- 1 bandit31 root    6 Oct 18 22:54 .gitignore
-rw-r--r-- 1 bandit31 root  147 Oct 18 22:54 README.md
```

## Read the `README.md` file
```
less README.md

This time your task is to push a file to the remote repository.

Details:
    File name: key.txt
    Content: 'May I come in?'
    Branch: master
```

## Read the `.gitignore` file
```
less .gitignore

*.txt
```
It ignores all the `*.txt*` files

## Create `key.txt` file
```
echo 'May I come in?' > key.txt
```

## Do not ignore `key.txt` or force add
- There are multiple ways to add an ignored file.
A. Force add
```
git add -f key.txt
```

B. Do not ignore
```
!key.txt
```
I'm choosing the latter as it is more explicit, 
and performing `git clean -df` will remove `key.txt`.

- Do not ignore the `key.txt` file
```
vim .gitignore

*.txt
!key.txt
```
We need to ensure that the negation comes after `*.txt*` or it wouldn't work.
We can now see the changes to `key.txt`

- Show file change status
```
git status -s

 M .gitignore
?? key.txt
```

## Add `.gitignore` and `key.txt` to tracking files.
```
git add .
```

## Commit the files
```
git commit -m "feat: add key.txt file"

 2 files changed, 2 insertions(+)
 create mode 100644 key.txt
```

## Push the changes
```
git push

Counting objects: 4, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 344 bytes | 0 bytes/s, done.
Total 4 (delta 0), reused 0 (delta 0)
remote: ### Attempting to validate files... ####
remote:
remote: .oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.
remote:
remote: Well done! Here is the password for the next level:
remote: 56a9bf19c63d650ce78e6ec0354ee45e
remote:
remote: .oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.
remote:
To ssh://localhost/home/bandit31-git/repo
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'ssh://bandit31-git@localhost/home/bandit31-git/repo'
```
Found the flag!

# Flag
```
56a9bf19c63d650ce78e6ec0354ee45e
```

# Retrospective

## What went well?
- I know how `.gitignore` works.

## How other people solved this?

### [OverTheWire: Bandit Level 31](https://medium.com/secttp/overthewire-bandit-level-31-ac8ae3c0b41b) by S.P.

They have deleted the `.gitignore` file.

### [BANDIT LEVEL 31 -> LEVEL 32](https://deathc4psapphire.wordpress.com/2018/10/10/bandit-level-31-level-32/) by DEATHC4PSAPPHIRE

They have used the force add `git add key.txt -f`

