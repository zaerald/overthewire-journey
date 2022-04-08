# Level 12

## Level Goal
The password for the next level is stored in the file `data.txt`, which is a
hexdump of a file that has been repeatedly compressed. For this level it may be
useful to create a directory under `/tmp` in which you can work using `mkdir`.
For example: `mkdir /tmp/myname123`. Then copy the datafile using `cp`, and
rename it using `mv` (read the manpages!)

## Access
```
ssh bandit12@bandit.labs.overthewire.org -p 2220
```
pwd: 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu

## Identify file
```
file data.txt
mydata.txt: ASCII text
```

## Move file into a /tmp directory
```
mkdir /tmp/zero
cp data.txt /tmp/zero
cd /tmp/zero
```

## Create backup
```
cp data.txt data.txt.bak
```

## Reverse the binary file
```
xxd -r data.txt > somedata
```
## Identify file
```
file somedata

somedata: gzip compressed data, was "data2.bin", last modified: Thu May  7 18:14:30 2020, max compression, from Unix
```

## Decompress data with `gzip`
### Try to decompress
```
gzip -d somedata

gzip: somedata: unknown suffix -- ignored
```

### Add suffix and decompress
```
cp somedata somedata.gz
gzip -d somedata.gz

gzip: somedata already exists; do you wish to overwrite (y or n)? y
```

## Identify the decompressed data
```
file somedata

somedata: bzip2 compressed data, block size = 900k
```

## Decompress data with `bzip2`
### Try to decompress
```
bzip2 -d somedata

bzip2: Can't guess original name for somedata -- using somedata.out
```

### Add suffix and decompress
```
mv somedata somedata.bz2
bzip2 -d somedata.bz2
```

## Identify the decompressed data
```
file somedata

somedata: gzip compressed data, was "data4.bin", last modified: Thu May  7 18:14:30 2020, max compression, from Unix
```
## Decompress data with `gzip`
```
mv somedata somedata.gz
gzip -d somedata.gz
```
## Identify the decompressed data
```
file somedata

somedata: POSIX tar archive (GNU)
```

### Decompress data with `tar`
```
tar -xvf somedata

data5.bin
```

## Identify `data5.bin` file
```
file data5.bin

data5.bin: POSIX tar archive (GNU)
```

## Decompress `data5.bin` file
```
tar -xvf data5.bin

data6.bin
```

## Identify `data6.bin` file
```
file data6.bin

data6.bin: bzip2 compressed data, block size = 900k
```

## Decompress with `bzip2`
```
mv data6.bin data6.bz2
bzip2 -d data6.bz2
```

## Identify `data6` file
```
file data6

data6: POSIX tar archive (GNU)
```

## Decompress `data6` file
```
tar -xvf data6

data8.bin
```

## Identify `data8.bin` file
```
file data8.bin

data8.bin: gzip compressed data, was "data9.bin", last modified: Thu May  7 18:14:30 2020, max compression, from Unix
```

## Decompress `data8.bin` file
```
mv data8.bin data8.gz
gzip -d data8.gz
```

## Identify `data8` file
```
file data8

data8: ASCII text
```

## Read `data8` file
```
less data8

The password is 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL
```

# Flag
```
8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL
```

# Retrospective
* Is there a way to use `gzip` without adding a suffix? This can work with `tar`.
* Is there a way to decompress everything down to the text file easily (recursive)?

