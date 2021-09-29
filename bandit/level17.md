# Level 17

## Level Goal
There are 2 files in the homedirectory: `passwords.old` and `passwords.new`. The password for the next level is in `passwords.new` and is the only line that has been changed between `passwords.old` and `passwords.new`

NOTE: if you have solved this level and see ‘Byebye!’ when trying to log into bandit18, this is related to the next level, bandit19

## Access
See `level16` preparation section.

## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## Viewing Files
Just to have a feeling of what the content of the files.
```
less passwords.old
less passwords.new
```

## Perform `diff`
```
diff passwords.old passwords.new

42c42
< w0Yfolrc5bwjS4qw5mq1nnQi6mF03bii
---
> kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd

```

# Flag
```
kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd
```

# Retospective

## What went well?
* Fortunately, `diff`-ing files is not new to me, as I always check for changes in my code.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
Learn what other parameters are available to the `diff` tool.

## How other people solved this?

### [OverTheWire: Bandit Level 17](https://medium.com/@secttp/overthewire-bandit-level-17-3b32603ee3b0) by S.P.

They have used the same solution but with different parameter order.
