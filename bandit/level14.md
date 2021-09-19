# Level 14

## Level Goal
The password for the next level can be retrieved by submitting the password of the current level to port `30000` on `localhost`.

## View the Password
```
less /etc/bandit_pass/bandit14

4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e
```
How can I *submit* this password to port `30000`?

## Scan for available ports using `nmap` - FAIL
```
nmap -sS localhost

You requested a scan type which requires root privileges.
QUITTING!
```
## Scan for available ports using `netcat`
```
nc -v -w 2 -z localhost 30000

localhost [127.0.0.1] 30000 (?) open
```
It's **open**

## Send some HTTP request
```
telnet localhost 30000

Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e
Correct!
BfMYroe26WYalil77FoDi9qh59eK5xNr
```
Turns out that I just need to paste the password. Was planning to send
```
GET / HTTP/1.0
Host: localhost
```
Is this the *submit*?


# Resources
* [How the Internet Works in 5 Minutes](https://youtu.be/7_LPdttKXPc)

# Retospective

## What went well?
* I'm aware that netcat can be used for port scanning, but dunno how to do it by heart. I'm able to scan and see if the port is open, for verification purposes.
* Tried to send an HTTP request using `telnet`, surprisingly retrieved the password for next level.

## What could have gone better?
If I understand properly what *submit* is, at first I thought it was for sending a `POST` and identify the resource path for it.

## What might I need to learn for better mastery, or what strategies might I use the next time to get better results?
Improve knowledge in `netcat` and `nmap`.

## How other people solved this?
### Using `netcat`
Input password
```
nc localhost 30000
# input password
```

Pipe
```
echo "4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e" | nc localhost 30000
# OR
cat /etc/bandit_pass/bandit14 | nc localhost 30000
```
