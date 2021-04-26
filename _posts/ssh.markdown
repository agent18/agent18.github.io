## What is ssh

1. something that allows you to connect to other computers



## Generate ssh

Followed [this](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) guide. 

I created the keygen by: 

	ssh-keygen -t ed25519 -C "your_email@example.com"
	
It suggested default directories. I said ok ok ok.


I go this output:

```
eghx@eghx-nitro:~$ ssh-keygen -t ed25519 -C "thetj09@gmail.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/eghx/.ssh/id_ed25519): 
Created directory '/home/eghx/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/eghx/.ssh/id_ed25519.
Your public key has been saved in /home/eghx/.ssh/id_ed25519.pub.
The key fingerprint is:
SHA256:A5AihOn8ssN9JD9BFi6O3V4Z+MUy/EmAb4cT/+HtN+8 thetj09@gmail.com
The key's randomart image is:
+--[ED25519 256]--+
|oo  ...          |
|+ . .+ o         |
|o. .. * *        |
| o . = @ * .     |
|  = = o S + o    |
| o = + + + o .   |
|. + = o     .    |
| + . =       . o |
|  . . .       ..E|
+----[SHA256]-----+

```

A bit more info about connecting to the server (the VM instance) from
the client is learnt from [here](https://phoenixnap.com/kb/ssh-to-connect-to-remote-server-linux-or-windows).

	ssh your_username@host_ip_address
	
additionally I needed to do a mix of [this](https://unix.stackexchange.com/a/405152/267853) as well...

	ssh -i /path/to/private/key remoteuser@remotehost
	
	
so that became, 

	ssh -i /path/to/private/key host_ip_address
	
that was it. once you give your public key to datacrunch, this was enough

