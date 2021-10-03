# Level 20

## Level Goal
There is a `setuid` binary in the homedirectory that does the following: it makes
a connection to `localhost` on the port you specify as a commandline argument. It
then reads a line of text from the connection and compares it to the password in
the previous level (`bandit20`). If the password is correct, it will transmit the
password for the next level (`bandit21`).

**NOTE:** Try connecting to your own network daemon to see if it works as you think

## Access
```
ssh bandit20@bandit.labs.overthewire.org -p 2220
```
pwd: GbKksEFF4yrVs6il55v6gwY5aVje5f0j


## Set Aliases
```
alias l='ls -lah'
alias v=vim
```

## Identify files
```
l

...
-rw-r--r--  1 root     root      220 May 15  2017 .bash_logout
-rw-r--r--  1 root     root     3.5K May 15  2017 .bashrc
-rw-r--r--  1 root     root      675 May 15  2017 .profile
-rwsr-x---  1 bandit21 bandit20  12K May  7  2020 suconnect
```

## TRY to execute the binary
```
./suconnect

Usage: ./suconnect <portnumber>
This program will connect to the given port on localhost using TCP. If it
will connect to the given port on localhost using TCP. If it receives the
correct password from the other side, the next password is transmitted back. 
```
So the program requires me to provide a `<portnumber>`. What port should I feed?

## TRY to scan for open ports
```
nc -zv localhost 1-65535

localhost [127.0.0.1] 43010 (?) open
localhost [127.0.0.1] 42578 (?) open
localhost [127.0.0.1] 31960 (?) open
localhost [127.0.0.1] 31790 (?) open
localhost [127.0.0.1] 31691 (?) open
localhost [127.0.0.1] 31518 (?) open
localhost [127.0.0.1] 31046 (?) open
localhost [127.0.0.1] 30002 (?) open
localhost [127.0.0.1] 30001 (?) open
localhost [127.0.0.1] 30000 (?) open
localhost [127.0.0.1] 113 (auth) open
localhost [127.0.0.1] 22 (ssh) open
```

## TRY to pass open ports to the program
```
# Couldn't connect
./suconnect 43010
./suconnect 42578

# Accepts input
./suconnect 31960
./suconnect 31790
./suconnect 31691
./suconnect 31518
./suconnect 31046
./suconnect 30001
./suconnect 30000
./suconnect 113

# Lead
./suconnect 30002
```

Found a lead for the `./suconnect 30002`.
Output:
```
Read: I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secr
ERROR: This doesn't match the current password!
```

## TRY to pass the password via pipe - FAIL
```
cat /etc/bandit_pass/bandit20 | ./suconnect 30002

Read: I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secr
ERROR: This doesn't match the current password!
```
It asks for user `bandit24`. But from the "Level Goal", it should ask for the current level 20.

## TRY to pass the password for `bandit24` - FAIL
```
cat /etc/bandit_pass/bandit24 | ./suconnect 30002

cat: /etc/bandit_pass/bandit24: Permission denied
Read: I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secr
ERROR: This doesn't match the current password!
```

## List the processes
```
ps -aef

UID        PID  PPID  C STIME TTY          TIME CMD
bandit20  5285  5284  0 13:33 pts/22   00:00:00 -bash
bandit20  5714  5711  0 13:34 pts/33   00:00:00 -bash
bandit20  5743     1  0 13:34 ?        00:00:00 SCREEN
bandit20  5744  5743  0 13:34 pts/45   00:00:00 /bin/bash
bandit20 13230 13224  0 13:42 pts/61   00:00:00 -bash
bandit20 20893  5743  0 14:01 pts/60   00:00:00 /bin/bash
bandit20 20944 20893  0 14:01 pts/60   00:00:00 nc -l
bandit20 21300  5743  0 14:02 pts/6    00:00:00 /bin/bash
bandit20 21506  5743  0 14:02 pts/62   00:00:00 /bin/bash
bandit20 24813  5714  0 14:09 pts/33   00:00:00 screen -r 5743
bandit20 25768 21506  0 14:11 pts/62   00:00:00 nano netcatScript
bandit20 27157 30247  0 14:14 pts/47   00:00:00 nc -l localhost 66000
bandit20 27229 13230  0 14:14 pts/61   00:00:00 ps -aef
bandit20 30247 30246  0 13:22 pts/47   00:00:00 -bash
```

There's a `SCREEN` process that I do not know what it does.
 - It's just another terminal multiplexer similar to `tmux`.

I do not know what to do, or how  to achieve the statement from the Level Goal:
*"...It then reads a line of text..."*

Learn more about `netcat`, see *Resources* section

I have learned that you can use `nc` to listen to messsages and I think that's what `suconnect` does.

## Terminal 1: Initiate a network listener
```
nc -lp 1337
```

## Terminal 2: Open another terminal, and connect to the listener
```
./suconnect 1337
```

## Terminal 1: Send password message to `suconnect`
```
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
```

## Terminal 2: Output once the message is received
```
Read: GbKksEFF4yrVs6il55v6gwY5aVje5f0j
Password matches, sending next password
```

## Terminal 1: Message received from `suconnect`
```
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr
```

It seems that we can actually do this with one terminal.
```
cat /etc/bandit_pass/bandit20 | nohup nc -l localhost -p 1337 &> /dev/null &
./suconnect 1337

Read: GbKksEFF4yrVs6il55v6gwY5aVje5f0j
Password matches, sending next password
[1]+  Done                    cat /etc/bandit_pass/bandit20 | nohup nc -l
/etc/bandit_pass/bandit20 | nohup nc -l localhost -p 1337 &> /dev/null
```

# Flag
```
gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr
```

# Resources
  - [LCL 24 - netcat tutorial - Linux Command Line tutorial for forensics](https://youtu.be/cq9RHDL2yMM)
  - [Netcat Tutorial - The Swiss Army Knife Of Networking - Reverse Shell](https://youtu.be/KlzSBk7VMss)

# Retospective

## What went well?
* Managed to learn a bit about netcat.

## What could have gone better?
* If I haven't tried/think too much on the port `30002` that I found, and based from the error message that it is for a different level. I thought that it was a bug that shows a different level number instead of the level 20.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
* Improve knowledge in netcat and networking.

## How other people solved this?

### [OverTheWire: Bandit Level 20](https://medium.com/secttp/overthewire-bandit-level-20-a1af9a042c56) by S.P.

Their solution is:
```
echo "GbKksEFF4yrVs6il55v6gwY5aVje5f0j" | nc -l localhost -p 61337 &
./suconnect 61337
```
