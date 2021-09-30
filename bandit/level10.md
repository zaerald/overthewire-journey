# Level 10

## Level Goal
The password for the next level is stored in the file `data.txt`, which contains
base64 encoded data

## Access
```
ssh bandit10@bandit.labs.overthewire.org -p 2220
```
pwd: truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk

## Identify File
```
file data.txt
data.txt: ASCII text
```

## Decode File
```
base64 -d data.txt

The password is IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
```

# Flag
```
IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
```
