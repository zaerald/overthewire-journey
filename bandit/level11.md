# Level 11

## Level Goal
The password for the next level is stored in the file `data.txt`, where all
lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

## Access
```
ssh bandit11@bandit.labs.overthewire.org -p 2220
```
pwd: IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR

## Identify File
```
file data.txt
```

## Rotate 13
```
tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt

The password is 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
```

# Flag
```
5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
```

