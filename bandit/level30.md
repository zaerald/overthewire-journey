# Level 30

## Level Goal
There is a git repository at `ssh://bandit30-git@localhost/home/bandit30-git/repo`.
The password for the user bandit30-git is the same as for the user bandit30.

Clone the repository and find the password for the next level.

## Access
```
ssh bandit30@bandit.labs.overthewire.org -p 2220
```
pwd: 5b90576bedb2cc04c86a9e924ce42faf

## Set Aliases
```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File
```
/etc/bandit_pass/bandit30
```

## Create temporary directory
```
cd $(mktemp -d) 
# /tmp/tmp.jkaz0wi42O
```

## Clone the repository
```
git clone ssh://bandit30-git@localhost/home/bandit30-git/repo
```

## Change directory and list files
```
cd repo

ls -lah

...
drwxr-sr-x 8 bandit30 root 4.0K Oct 18 21:36 .git
-rw-r--r-- 1 bandit30 root   30 Oct 18 21:36 README.md
```

## Read the README.md file
```
less README.md

just an epmty file... muahaha
```
lol

## View git history
```
git log --oneline --all --decorate --graph

* 3aefa22 (HEAD -> master, origin/master, origin/HEAD) initial commit of README.md
```
Oh! This is challenging for me.

## View reflog
```
git reflog

3aefa22 HEAD@{0}: clone: from ssh://bandit30-git@localhost/home/bandit30-git/repo
```

## View the list of branches
```
git branch -a

* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
```
There are no clues.

## Fetch and view the list of tags
- Fetch tags
```
git fetch --all --tags --prune
```

- List tags
```
git tag

secret
```
Now this is an interesting tag!


## TRY to checkout tag - FAIL
- Checkout `secret` tag.
```
git checkout tags/secret -b secret

fatal: reference is not a tree: tags/secret
```
Why can't I checkout this tag?


- View tag sha id
```
git show secret

47e603bb428404d265f59c42920d81e5
```

- Show commit sha
```
git checkout 47e603bb428404d265f59c42920d81e5

error: pathspec '47e603bb428404d265f59c42920d81e5' did not match any file(s) known to git.
```
Am I doing the checkout wrong here?

## TRY to describe tag - FAIL
```
git describe --tags

fatal: No tags can describe '3aefa229469b7ba1cc08203e5d8fa299354c496b'.
Try --always, or create some tags.
```

## View git refs
```
git show-ref

3aefa229469b7ba1cc08203e5d8fa299354c496b refs/heads/master
3aefa229469b7ba1cc08203e5d8fa299354c496b refs/remotes/origin/HEAD
3aefa229469b7ba1cc08203e5d8fa299354c496b refs/remotes/origin/master
f17132340e8ee6c159e0a4a6bc6f80e1da3b1aea refs/tags/secret
```

## TRY to create branch from the sha ID
```
git checkout -b mysecret f17132340e8ee6c159e0a4a6bc6f80e1da3b1aea

fatal: reference is not a tree: f17132340e8ee6c159e0a4a6bc6f80e1da3b1aea
```

I do not know how to proceed now. Let's review [git-tag][git-tag] documentation.

## TRY to put `refs/tags/secret` to `.git/HEAD` - FAIL
```
$ cp .git/HEAD /tmp/tmp.jkaz0wi42O

$ echo 'refs/tags/secret' > .git/HEAD

$ git status

fatal: Not a git repository (or any parent up to mount point /tmp)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
```

- Revert
```
cp /tmp/tmp.jkaz0wi42O/HEAD .git/HEAD
```

## List refs
```
ls -lah .git/refs/tags

total 8.0K
drwxr-sr-x 2 bandit30 root 4.0K Oct 18 22:26 .
drwxr-sr-x 5 bandit30 root 4.0K Oct 18 22:26 ..
```
There are no `secret` here...

## Describe `secret` tag
```
git describe secret

error: object f17132340e8ee6c159e0a4a6bc6f80e1da3b1aea is a blob, not a commit
fatal: secret is not a valid 'commit' object
```
It seems that I already found the flag!

## Review tag and compare to refs
- Review tag
```
git show secret

47e603bb428404d265f59c42920d81e5
```

- Compare to refs
```
git show-ref

43aefa229469b7ba1cc08203e5d8fa299354c496b refs/heads/master
3aefa229469b7ba1cc08203e5d8fa299354c496b refs/remotes/origin/HEAD
3aefa229469b7ba1cc08203e5d8fa299354c496b refs/remotes/origin/master
f17132340e8ee6c159e0a4a6bc6f80e1da3b1aea refs/tags/secret7e603bb428404d265f59c42920d81e5
47e603bb428404d265f59c42920d81e5
```
Lol it was already the flag, it looks like a commit sha! 
Now I'm curious how they did this...

# Flag
```
47e603bb428404d265f59c42920d81e5
```

# Resources
- [Git - Git References](https://git-scm.com/book/en/v2/Git-Internals-Git-References)
- [git-tag][git-tag]

[git-tag]: https://git-scm.com/docs/git-tag


# Retospective
A bit dumbness on my end, I thought that the flag was a commit sha!
Performed some things lol, but this helped me review more about git.

## What went well?
- Helped me find out the secret tag.

## What could have gone better?
- If I just realized that the `git show secret` already solved this level, 
  and it was a flag and not a sha.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
- It's nice to know more about git internals.

## How other people solved this?

### [OverTheWire: Bandit Level 30](https://medium.com/secttp/overthewire-bandit-level-30-7ee3996ce583) by S.P.

They have also performed `git show secret` to find the flag.

