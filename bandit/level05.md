# Level 05

## Level Goal
The password for the next level is stored in a file somewhere under the inhere
directory and has all of the following properties:

* human-readable
* 1033 bytes in size
* not executable


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
