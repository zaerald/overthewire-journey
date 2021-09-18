# Level 06

## Level Goal
The password for the next level is stored *somewhere on the server* and has all of the following properties:

* owned by user bandit7
* owned by group bandit6
* 33 bytes in size

## Access
```
ssh bandit6@bandit.labs.overthewire.org -p 2220
```
pwd: DXjZPULLxYr17uwoI01bNLQbtFemEgo7

## File with properties
* owned by user bandit7
* owned by group bandit6
* 33 bytes in size

## Find file
```
find / -type f -user bandit7 -group bandit6 -size 33c
/var/lib/dpkg/info/bandit7.password
```

## Read file
```
cat /var/lib/dpkg/info/bandit7.password
HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs
```
