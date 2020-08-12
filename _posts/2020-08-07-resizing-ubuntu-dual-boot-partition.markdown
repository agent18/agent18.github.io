---
layout: post
comments: true
title:  "Resizing partition ubuntu/windows 10 dual boot"
date: 07-08-2020
categories: notes
tags: gaming
permalink: /:title.html
published: true
---

## Steps

based on: [link 1](https://askubuntu.com/questions/871825/add-more-disk-space-for-linux-from-windows-in-a-dual-bootable-machine), [link 2](https://askubuntu.com/questions/727112/give-more-hard-disk-space-to-ubuntu?rq=1). link 2 has many links to solve
issues for you.

1. go to windows "Disk Management" and then look at the large
   partition that you wanna split and then unallocate it.
   
2. Make a live USB of Ubuntu so that you can manipulate Ubuntu. Follow
   [these instructions](https://ubuntu.com/tutorials/create-a-usb-stick-on-ubuntu#1-overview) word-for-word and that is good enough.

3. Make Back up in your original Ubuntu on your Google Drive. Just the
   important stuff
   
4. Restart! and Boot live USB stick using F12 for ACER. Sometimes this
   might not work, in which case you need to go to the system menu
   somehow (available in the grub boot menu) and change there in
   "Main" to enable "F12 boot".
   
5. F12

6. Open live USB and go to "Gparted".

7. Move as per requirements. Here is a [nice tutorial](https://www.howtogeek.com/114503/how-to-resize-your-ubuntu-partitions/) from
   "how-to-geek"
   
8. If unallocated part is not next to the part you want to expand,
   this then involves moving all the partitions so that the
   unallocated is next. This has the "Warning-danger" message even for
   "moving" a partition. Do AT YOUR OWN RISK.


## Caveats

- "Unallocated" needs to be close to the partition you are interested
  in. 
  
- Moving partitions is as "dangerous sounding" as re-sizing
  partitions. In my case I had to move partitions so that the
  unallocated space came in the end... But this is not worth the
  FAILURE if it does happen now... 
  
  I will cross the bridge when the time comes. I am confident about
  reinstalling. I mainly need emacs for now and everything related to
  that is on the cloud, like my blog and the init settings. So I
  should be gucci.
  
- 
