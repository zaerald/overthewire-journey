# Level 05

## Access
```
ssh bandit5@bandit.labs.overthewire.org -p 2220
```
pwd: koReBOKuIDDepwhWk7jZC0RTdopnAYKh

## File with properties
* human-readable
* 1033 bytes in size
* not executable

## Finding file
### Find command
```
find ~/inhere -type f -size 1033c ! -executable
```

### Find file with ls | vim -
```
ls -laR ~/inhere | vim -

/1033
```

## Read file
```
cat ./inhere/maybehere07/file2
DXjZPULLxYr17uwoI01bNLQbtFemEgo7
```
