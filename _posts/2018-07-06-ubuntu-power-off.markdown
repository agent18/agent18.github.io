---
layout: post
comments: true
title:  "Acer Nitro 5 with Ubuntu random shutdown "
date:    06-07-2018 19:39
categories: notes
permalink: /:title.html
published: True
---

# Hypothesis

  * [x] suspend not suspending after lid close
  
  Laptop seems to sleep well (>24 hrs) sometimes and not some other
  times. The timing of failure-to-sleep is random.
  
  * [ ] Error in syslog is the reason (fault of Ubuntu)?

  Laptop randomly shuts down while sleeping. This doesn't happen on
  every sleep. The sleep log looks similar for the above cases as far
  as the syslog is available in case the laptop shutsdown randomly.

  No traceable evidence that something like this happens due to Ubuntu
  on Google.
  
  * [ ] The graphic card is the problem
  
  The error in syslog also appeared in another system of mine same
  installation. The syslog looks quite similar in different laptops,
  although there are errors. In any case I can toggle the graphic card
  off and see if it helps.
  

  * [x] Tried setting up hibernating instead that doesn't work
  
  
  [Link](https://askubuntu.com/questions/768136/how-can-i-hibernate-on-ubuntu-16-04)! Getting hibernation to work is not trivial.
  
  * [x] Maybe battery is loose?
	
  The [acer nitro 5](https://community.acer.com/en/discussion/536218/acer-nitro-5-turning-off-randomly-while-not-charging?breakffcache=a4779) forum suggests that the screws at the bottom of the
  laptop need to be tightened a bit more (around hand tight).
  
  * [x] Upgrade to latest kernel

  And check this page ([more suggestions](https://askubuntu.com/questions/765747/upgraded-ubuntu-16-04-sometimes-fails-to-sleep/817667#817667)) for more
    solution. Upgraded system using,
	
		$ sudo apt-get upgrade 
  
  Some days its lasts the whole day. Somedays it just freaking switches
off. 

## Trying to check if the syslog errors are the problem

[Same error ](https://askubuntu.com/a/817667/443958) nothing wrong with this though. This link
provides other places to search for.

[Similar error message but doesn't
seem to work](https://askubuntu.com/questions/972433/not-able-to-suspend-because-of-failed-to-connect-to-non-global-ctrl-ifname-nil)  
  
I tried:

	sudo /sbin/wpa_cli suspend
	
and it says ok! So not meant for me I guess.
  
Searches of the following gives no useful results.

	/lib/systemd/system-sleep/wpasupplicant failed with error code
	255.
	
	or
	
	Failed to connect to non-global ctrl_ifname: (nil)  error: No such
	file or directory

**Nothing useful here**

## Solution

I tightened all the screws (on aug 17) to slightly greater than hand
tight. On Aug 21 before I went on my trip to bangalore (Test trip). I
did a similar trip on Aug 8th (control trip). On Aug 21st my PC has
survived all the way till 1.5 days later when I picked it up to write
some thing. On Aug 8th my PC didn't survive even 4 hrs.

For now I assume this to confirm that my laptop is alright. I will put
the laptop to more rigorous tests these coming days by taking it on my
journey back to netherlands on sleep. The laptop can easily sleep for
more than 48 hrs at full battery.



## Appendix DATA

Logging data to see differences between different days when the sleep
if OK and NOK. Also logging changes I make to the system to see if it
works properly.

### July 6 attempted repairing, but mainly ended up updating and upgrading
### July 7 10 hrs sleep + 45 mins youtube **OK**
july 7 00:17:20 eghx-nitro systemd[1]: Starting Network Manager Script
Dispatcher Service...  Jul 7 00:17:20 eghx-nitro wpa_supplicant[1034]:
nl80211: deinit ifname=p2p-dev-wlp2s0 disabled_11b_rates=0 Jul 7
00:17:20 eghx-nitro dbus[811]: [system] Successfully activated service
'org.freedesktop.nm_dispatcher' Jul 7 00:17:20 eghx-nitro systemd[1]:
Started Network Manager Script Dispatcher Service.  Jul 7 00:17:21
eghx-nitro nm-dispatcher: req:1 'down' [wlp2s0]: new request (1
scripts) Jul 7 00:17:21 eghx-nitro nm-dispatcher: req:1
'down' [wlp2s0]: start running ordered scripts...  Jul 7 00:17:21
eghx-nitro wpa_supplicant[1034]: nl80211: deinit ifname=wlp2s0
disabled_11b_rates=0 Jul 7 00:17:21 eghx-nitro systemd[1]: Reached
target Sleep.  Jul 7 00:17:21 eghx-nitro systemd[1]: **Starting
Suspend...  Jul 7 00:17:21 eghx-nitro systemd-sleep[5043]: Failed to
connect to non-global ctrl_ifname: (nil) error: No such file or
directory Jul 7 00:17:21 eghx-nitro systemd-sleep[5044]:
/lib/systemd/system-sleep/wpasupplicant failed with error code 255.**
Jul 7 00:17:21 eghx-nitro systemd-sleep[5043]: Suspending system...
Jul 7 00:17:21 eghx-nitro kernel: [ 6731.112276] PM: Syncing
filesystems ... done.  Jul 7 **00:17:2**1 eghx-nitro kernel: [
6731.335963] PM: Preparing system for sleep (mem) Jul 7 **09:33:2**2
eghx-nitro kernel: [ 6733.695280] Freezing user space processes
... (elapsed 0.001 seconds) done.  Jul 7 09:33:22 eghx-nitro kernel: [
6733.696894] OOM killer disabled.  Jul 7 09:33:22 eghx-nitro kernel: [
6733.696894] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.  Jul 7 09:33:22 eghx-nitro kernel: [ 6733.698057] PM:
Suspending system (mem) Jul 7 09:33:22 eghx-nitro kernel: [
6733.698092] Suspending console(s) (use no_console_suspend to debug)
Jul 7 09:33:22 eghx-nitro kernel: [ 6733.912241] sd 2:0:0:0: [sdb]
Synchronizing SCSI cache Jul 7 09:33:22 eghx-nitro kernel: [
6733.912449] sd 0:0:0:0: [sda] Synchronizing SCSI cache Jul 7 09:33:22
eghx-nitro kernel: [ 6733.912841] sd 2:0:0:0: [sdb] Stopping disk Jul
7 09:33:22 eghx-nitro kernel: [ 6733.913854] sd 0:0:0:0: [sda]
Stopping disk Jul 7 09:33:22 eghx-nitro kernel: [ 6735.216916] PM:
suspend of devices complete after 1305.567 msecs Jul 7 09:33:22
eghx-nitro kernel: [ 6735.238693] PM: late suspend of devices complete
after 21.774 msecs Jul 7 09:33:22 eghx-nitro kernel: [ 6735.342693]
PM: noirq suspend of devices complete after 103.995 msecs Jul 7
09:33:22 eghx-nitro kernel: [ 6735.343300] ACPI: Preparing to enter
system sleep state S3 Jul 7 09:33:22 eghx-nitro kernel: [ 6735.344004]
ACPI: EC: event blocked Jul 7 09:33:22 eghx-nitro kernel: [
6735.344005] ACPI: EC: EC stopped Jul 7 09:33:22 eghx-nitro kernel: [
6735.344006] PM: Saving platform NVS memory Jul 7 09:33:22 eghx-nitro
kernel: [ 6735.344093] Disabling non-boot CPUs ...  Jul 7 09:33:22
eghx-nitro kernel: [ 6735.359145] IRQ 316: no longer affine to CPU1
Jul 7 09:33:22 eghx-nitro kernel: [ 6735.359150] IRQ 317: no longer
affine to CPU1 Jul 7 09:33:22 eghx-nitro kernel: [ 6735.360175]
smpboot: CPU 1 is now offline Jul 7 09:33:22 eghx-nitro kernel: [
6735.375113] IRQ 122: no longer affine to CPU2 Jul 7 09:33:22
eghx-nitro kernel: [ 6735.375152] IRQ 318: no longer affine to CPU2
Jul 7 09:33:22 eghx-nitro kernel: [ 6735.375157] IRQ 321: no longer
affine to CPU2 Jul 7 09:33:22 eghx-nitro kernel: [ 6735.376171]
smpboot: CPU 2 is now offline Jul 7 09:33:22 eghx-nitro kernel: [
6735.399046] IRQ 1: no longer affine to CPU3 Jul 7 09:33:22 eghx-nitro
kernel: [ 6735.399052] IRQ 8: no longer affine to CPU3 Jul 7 09:33:22
eghx-nitro kernel: [ 6735.399056] IRQ 9: no longer affine to CPU3 Jul
7 09:33:22 eghx-nitro kernel: [ 6735.399061] IRQ 14: no longer affine
to CPU3 Jul 7 09:33:22 eghx-nitro kernel: [ 6735.399066] IRQ 16: no
longer affine to CPU3 Jul 7 09:33:22 eghx-nitro kernel: [ 6735.400134]
smpboot: CPU 3 is now offline Jul 7 09:33:22 eghx-nitro kernel: [
6735.403157] ACPI: Low-level resume complete Jul 7 09:33:22 eghx-nitro
kernel: [ 6735.403290] ACPI: EC: EC started Jul 7 09:33:22 eghx-nitro
kernel: [ 6735.403290] PM: Restoring platform NVS memory Jul 7
09:33:22 eghx-nitro kernel: [ 6735.404063] **Suspended for 33356.167
seconds**

### July 8 16:30 hrs sleep + X hrs of work **OK**
Jul  7 18:01:20 eghx-nitro systemd[1]: Starting Suspend...
Jul  7 18:01:20 eghx-nitro systemd-sleep[32140]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul  7 18:01:20 eghx-nitro systemd-sleep[32141]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul  7 18:01:20 eghx-nitro systemd-sleep[32140]: Suspending system...
Jul  7 18:01:20 eghx-nitro kernel: [32410.952622] PM: Syncing filesystems ... done.
Jul  7 18:01:20 eghx-nitro kernel: [32411.159151] PM: Preparing system for sleep (mem)
Jul  8 10:44:08 eghx-nitro kernel: [32412.815776] Freezing user space processes ... (elapsed 0.002 seconds) done.
Jul  8 10:44:08 eghx-nitro kernel: [32412.817955] OOM killer disabled.
Jul  8 10:44:08 eghx-nitro kernel: [32412.817956] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul  8 10:44:08 eghx-nitro kernel: [32412.819386] PM: Suspending system (mem)
Jul  8 10:44:08 eghx-nitro kernel: [32412.819422] Suspending console(s) (use no_console_suspend to debug)
Jul  8 10:44:08 eghx-nitro kernel: [32413.036096] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul  8 10:44:08 eghx-nitro kernel: [32413.036378] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul  8 10:44:08 eghx-nitro kernel: [32413.036694] sd 2:0:0:0: [sdb] Stopping disk
Jul  8 10:44:08 eghx-nitro kernel: [32413.037704] sd 0:0:0:0: [sda] Stopping disk
Jul  8 10:44:08 eghx-nitro kernel: [32414.320696] PM: suspend of devices complete after 1285.555 msecs
Jul  8 10:44:08 eghx-nitro kernel: [32414.342519] PM: late suspend of devices complete after 21.818 msecs
Jul  8 10:44:08 eghx-nitro kernel: [32414.474509] PM: noirq suspend of devices complete after 131.985 msecs
Jul  8 10:44:08 eghx-nitro kernel: [32414.475117] ACPI: Preparing to enter system sleep state S3
Jul  8 10:44:08 eghx-nitro kernel: [32414.475830] ACPI: EC: event blocked
Jul  8 10:44:08 eghx-nitro kernel: [32414.475831] ACPI: EC: EC stopped
Jul  8 10:44:08 eghx-nitro kernel: [32414.475832] PM: Saving platform NVS memory
Jul  8 10:44:08 eghx-nitro kernel: [32414.475919] Disabling non-boot CPUs ...
Jul  8 10:44:08 eghx-nitro kernel: [32414.490983] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul  8 10:44:08 eghx-nitro kernel: [32414.490985] IRQ 317: no longer affine to CPU1
Jul  8 10:44:08 eghx-nitro kernel: [32414.490991] IRQ 322: no longer affine to CPU1
Jul  8 10:44:08 eghx-nitro kernel: [32414.492012] smpboot: CPU 1 is now offline
Jul  8 10:44:08 eghx-nitro kernel: [32414.510933] IRQ 122: no longer affine to CPU2
Jul  8 10:44:08 eghx-nitro kernel: [32414.510962] IRQ 316: no longer affine to CPU2
Jul  8 10:44:08 eghx-nitro kernel: [32414.511983] smpboot: CPU 2 is now offline
Jul  8 10:44:08 eghx-nitro kernel: [32414.534863] IRQ 1: no longer affine to CPU3
Jul  8 10:44:08 eghx-nitro kernel: [32414.534870] IRQ 8: no longer affine to CPU3
Jul  8 10:44:08 eghx-nitro kernel: [32414.534874] IRQ 9: no longer affine to CPU3
Jul  8 10:44:08 eghx-nitro kernel: [32414.534879] IRQ 14: no longer affine to CPU3
Jul  8 10:44:08 eghx-nitro kernel: [32414.534884] IRQ 16: no longer affine to CPU3
Jul  8 10:44:08 eghx-nitro kernel: [32414.534890] IRQ 17: no longer affine to CPU3
Jul  8 10:44:08 eghx-nitro kernel: [32414.535951] smpboot: CPU 3 is now offline
Jul  8 10:44:08 eghx-nitro kernel: [32414.538975] ACPI: Low-level resume complete
Jul  8 10:44:08 eghx-nitro kernel: [32414.539107] ACPI: EC: EC started
Jul  8 10:44:08 eghx-nitro kernel: [32414.539107] PM: Restoring platform NVS memory
Jul  8 10:44:08 eghx-nitro kernel: [32414.539880] Suspended for 60163.852 seconds

### July 9 20 hrs of sleep + 45 mins of video **OK**

Jul  8 21:55:09 eghx-nitro systemd[1]: Starting Suspend...
Jul  8 21:55:09 eghx-nitro systemd[1]: Starting Network Manager Script Dispatcher Service...
Jul  8 21:55:09 eghx-nitro dbus[811]: [system] Successfully activated service 'org.freedesktop.nm_dispatcher'
Jul  8 21:55:09 eghx-nitro systemd[1]: Started Network Manager Script Dispatcher Service.
Jul  8 21:55:09 eghx-nitro nm-dispatcher: req:1 'down' [wlp2s0]: new request (1 scripts)
Jul  8 21:55:09 eghx-nitro nm-dispatcher: req:1 'down' [wlp2s0]: start running ordered scripts...
Jul  8 21:55:10 eghx-nitro wpa_supplicant[1034]: nl80211: deinit ifname=p2p-dev-wlp2s0 disabled_11b_rates=0
Jul  8 21:55:10 eghx-nitro wpa_supplicant[1034]: nl80211: deinit ifname=wlp2s0 disabled_11b_rates=0
Jul  8 21:55:20 eghx-nitro systemd-sleep[29762]: Selected interface 'p2p-dev-wlp2s0'
Jul  8 21:55:20 eghx-nitro systemd-sleep[29762]: 'SUSPEND' command timed out.
Jul  8 21:55:20 eghx-nitro systemd-sleep[29764]: /lib/systemd/system-sleep/wpasupplicant failed with error code 254.
Jul  8 21:55:20 eghx-nitro systemd-sleep[29762]: Suspending system...
Jul  8 21:55:20 eghx-nitro kernel: [56795.935252] PM: Syncing filesystems ... done.
Jul  8 21:55:20 eghx-nitro kernel: [56796.345072] PM: Preparing system for sleep (mem)
Jul  9 18:29:18 eghx-nitro kernel: [56798.942445] Freezing user space processes ... (elapsed 0.136 seconds) done.
Jul  9 18:29:18 eghx-nitro kernel: [56799.079000] OOM killer disabled.
Jul  9 18:29:18 eghx-nitro kernel: [56799.079001] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul  9 18:29:18 eghx-nitro kernel: [56799.080892] PM: Suspending system (mem)
Jul  9 18:29:18 eghx-nitro kernel: [56799.080956] Suspending console(s) (use no_console_suspend to debug)
Jul  9 18:29:18 eghx-nitro kernel: [56799.298364] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul  9 18:29:18 eghx-nitro kernel: [56799.298531] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul  9 18:29:18 eghx-nitro kernel: [56799.298947] sd 2:0:0:0: [sdb] Stopping disk
Jul  9 18:29:18 eghx-nitro kernel: [56799.299910] sd 0:0:0:0: [sda] Stopping disk
Jul  9 18:29:18 eghx-nitro kernel: [56800.583039] PM: suspend of devices complete after 1285.552 msecs
Jul  9 18:29:18 eghx-nitro kernel: [56800.604862] PM: late suspend of devices complete after 21.817 msecs
Jul  9 18:29:18 eghx-nitro kernel: [56800.736846] PM: noirq suspend of devices complete after 131.978 msecs
Jul  9 18:29:18 eghx-nitro kernel: [56800.737456] ACPI: Preparing to enter system sleep state S3
Jul  9 18:29:18 eghx-nitro kernel: [56800.738159] ACPI: EC: event blocked
Jul  9 18:29:18 eghx-nitro kernel: [56800.738160] ACPI: EC: EC stopped
Jul  9 18:29:18 eghx-nitro kernel: [56800.738161] PM: Saving platform NVS memory
Jul  9 18:29:18 eghx-nitro kernel: [56800.738247] Disabling non-boot CPUs ...
Jul  9 18:29:18 eghx-nitro kernel: [56800.753320] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul  9 18:29:18 eghx-nitro kernel: [56800.753322] IRQ 316: no longer affine to CPU1
Jul  9 18:29:18 eghx-nitro kernel: [56800.753328] IRQ 317: no longer affine to CPU1
Jul  9 18:29:18 eghx-nitro kernel: [56800.754346] smpboot: CPU 1 is now offline
Jul  9 18:29:18 eghx-nitro kernel: [56800.777274] IRQ 122: no longer affine to CPU2
Jul  9 18:29:18 eghx-nitro kernel: [56800.777311] IRQ 322: no longer affine to CPU2
Jul  9 18:29:18 eghx-nitro kernel: [56800.778331] smpboot: CPU 2 is now offline
Jul  9 18:29:18 eghx-nitro kernel: [56800.801212] IRQ 1: no longer affine to CPU3
Jul  9 18:29:18 eghx-nitro kernel: [56800.801219] IRQ 8: no longer affine to CPU3
Jul  9 18:29:18 eghx-nitro kernel: [56800.801223] IRQ 9: no longer affine to CPU3
Jul  9 18:29:18 eghx-nitro kernel: [56800.801228] IRQ 14: no longer affine to CPU3
Jul  9 18:29:18 eghx-nitro kernel: [56800.801233] IRQ 16: no longer affine to CPU3
Jul  9 18:29:18 eghx-nitro kernel: [56800.801239] IRQ 17: no longer affine to CPU3
Jul  9 18:29:18 eghx-nitro kernel: [56800.802301] smpboot: CPU 3 is now offline
Jul  9 18:29:18 eghx-nitro kernel: [56800.805333] ACPI: Low-level resume complete
Jul  9 18:29:18 eghx-nitro kernel: [56800.805466] ACPI: EC: EC started
Jul  9 18:29:18 eghx-nitro kernel: [56800.805466] PM: Restoring platform NVS memory
Jul  9 18:29:18 eghx-nitro kernel: [56800.806238] Suspended for 74032.927 seconds
### July 10 20 hrs of sleep 76%-->61%ish + 30 mins video **OK**
Jul  9 22:54:17 eghx-nitro systemd[1]: Starting Suspend...
Jul  9 22:54:17 eghx-nitro systemd-sleep[14012]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul  9 22:54:17 eghx-nitro systemd-sleep[14013]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul  9 22:54:17 eghx-nitro systemd-sleep[14012]: Suspending system...
Jul  9 22:54:18 eghx-nitro kernel: [69616.265110] PM: Syncing filesystems ... done.
Jul  9 22:54:18 eghx-nitro kernel: [69616.493001] PM: Preparing system for sleep (mem)
Jul 10 18:13:02 eghx-nitro kernel: [69618.800187] Freezing user space processes ... (elapsed 0.002 seconds) done.
Jul 10 18:13:02 eghx-nitro kernel: [69618.803130] OOM killer disabled.
Jul 10 18:13:02 eghx-nitro kernel: [69618.803131] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 10 18:13:02 eghx-nitro kernel: [69618.804693] PM: Suspending system (mem)
Jul 10 18:13:02 eghx-nitro kernel: [69618.804754] Suspending console(s) (use no_console_suspend to debug)
Jul 10 18:13:02 eghx-nitro kernel: [69619.022002] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 10 18:13:02 eghx-nitro kernel: [69619.022352] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 10 18:13:02 eghx-nitro kernel: [69619.022555] sd 2:0:0:0: [sdb] Stopping disk
Jul 10 18:13:02 eghx-nitro kernel: [69619.023735] sd 0:0:0:0: [sda] Stopping disk
Jul 10 18:13:02 eghx-nitro kernel: [69620.318564] PM: suspend of devices complete after 1297.530 msecs
Jul 10 18:13:02 eghx-nitro kernel: [69620.340391] PM: late suspend of devices complete after 21.822 msecs
Jul 10 18:13:02 eghx-nitro kernel: [69620.472377] PM: noirq suspend of devices complete after 131.981 msecs
Jul 10 18:13:02 eghx-nitro kernel: [69620.472984] ACPI: Preparing to enter system sleep state S3
Jul 10 18:13:02 eghx-nitro kernel: [69620.473691] ACPI: EC: event blocked
Jul 10 18:13:02 eghx-nitro kernel: [69620.473692] ACPI: EC: EC stopped
Jul 10 18:13:02 eghx-nitro kernel: [69620.473693] PM: Saving platform NVS memory
Jul 10 18:13:02 eghx-nitro kernel: [69620.473783] Disabling non-boot CPUs ...
Jul 10 18:13:02 eghx-nitro kernel: [69620.488854] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 10 18:13:02 eghx-nitro kernel: [69620.488856] IRQ 316: no longer affine to CPU1
Jul 10 18:13:02 eghx-nitro kernel: [69620.488862] IRQ 317: no longer affine to CPU1
Jul 10 18:13:02 eghx-nitro kernel: [69620.489878] smpboot: CPU 1 is now offline
Jul 10 18:13:02 eghx-nitro kernel: [69620.512795] IRQ 122: no longer affine to CPU2
Jul 10 18:13:02 eghx-nitro kernel: [69620.512832] IRQ 318: no longer affine to CPU2
Jul 10 18:13:02 eghx-nitro kernel: [69620.512837] IRQ 321: no longer affine to CPU2
Jul 10 18:13:02 eghx-nitro kernel: [69620.513851] smpboot: CPU 2 is now offline
Jul 10 18:13:02 eghx-nitro kernel: [69620.528738] IRQ 1: no longer affine to CPU3
Jul 10 18:13:02 eghx-nitro kernel: [69620.528744] IRQ 8: no longer affine to CPU3
Jul 10 18:13:02 eghx-nitro kernel: [69620.528749] IRQ 9: no longer affine to CPU3
Jul 10 18:13:02 eghx-nitro kernel: [69620.528754] IRQ 14: no longer affine to CPU3
Jul 10 18:13:02 eghx-nitro kernel: [69620.528759] IRQ 16: no longer affine to CPU3
Jul 10 18:13:02 eghx-nitro kernel: [69620.529823] smpboot: CPU 3 is now offline
Jul 10 18:13:02 eghx-nitro kernel: [69620.532847] ACPI: Low-level resume complete
Jul 10 18:13:02 eghx-nitro kernel: [69620.532980] ACPI: EC: EC started
Jul 10 18:13:02 eghx-nitro kernel: [69620.532981] PM: Restoring platform NVS memory
Jul 10 18:13:02 eghx-nitro kernel: [69620.533753] Suspended for
69519.764 seconds
### July 11 20 hrs of sleep 100%-->91%ish + 30 mins video **OK**

Jul 10 22:00:46 eghx-nitro systemd[1]: Starting Suspend...
Jul 10 22:00:46 eghx-nitro systemd-sleep[30298]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul 10 22:00:46 eghx-nitro systemd-sleep[30300]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul 10 22:00:46 eghx-nitro systemd-sleep[30298]: Suspending system...
Jul 10 22:00:47 eghx-nitro kernel: [81524.775250] PM: Syncing filesystems ... done.
Jul 10 22:00:47 eghx-nitro kernel: [81525.175224] PM: Preparing system for sleep (mem)
Jul 11 18:23:17 eghx-nitro kernel: [81527.388796] Freezing user space processes ... (elapsed 0.002 seconds) done.
Jul 11 18:23:17 eghx-nitro kernel: [81527.390959] OOM killer disabled.
Jul 11 18:23:17 eghx-nitro kernel: [81527.390959] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 11 18:23:17 eghx-nitro kernel: [81527.392407] PM: Suspending system (mem)
Jul 11 18:23:17 eghx-nitro kernel: [81527.392441] Suspending console(s) (use no_console_suspend to debug)
Jul 11 18:23:17 eghx-nitro kernel: [81527.501946] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 11 18:23:17 eghx-nitro kernel: [81527.502107] sd 2:0:0:0: [sdb] Stopping disk
Jul 11 18:23:17 eghx-nitro kernel: [81527.504448] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 11 18:23:17 eghx-nitro kernel: [81527.505799] sd 0:0:0:0: [sda] Stopping disk
Jul 11 18:23:17 eghx-nitro kernel: [81528.810558] PM: suspend of devices complete after 1309.557 msecs
Jul 11 18:23:17 eghx-nitro kernel: [81528.832371] PM: late suspend of devices complete after 21.807 msecs
Jul 11 18:23:17 eghx-nitro kernel: [81528.964368] PM: noirq suspend of devices complete after 131.992 msecs
Jul 11 18:23:17 eghx-nitro kernel: [81528.964977] ACPI: Preparing to enter system sleep state S3
Jul 11 18:23:17 eghx-nitro kernel: [81528.965683] ACPI: EC: event blocked
Jul 11 18:23:17 eghx-nitro kernel: [81528.965684] ACPI: EC: EC stopped
Jul 11 18:23:17 eghx-nitro kernel: [81528.965685] PM: Saving platform NVS memory
Jul 11 18:23:17 eghx-nitro kernel: [81528.965774] Disabling non-boot CPUs ...
Jul 11 18:23:17 eghx-nitro kernel: [81528.980833] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 11 18:23:17 eghx-nitro kernel: [81528.980834] IRQ 316: no longer affine to CPU1
Jul 11 18:23:17 eghx-nitro kernel: [81528.980841] IRQ 317: no longer affine to CPU1
Jul 11 18:23:17 eghx-nitro kernel: [81528.981857] smpboot: CPU 1 is now offline
Jul 11 18:23:17 eghx-nitro kernel: [81529.000791] IRQ 122: no longer affine to CPU2
Jul 11 18:23:17 eghx-nitro kernel: [81529.000828] IRQ 318: no longer affine to CPU2
Jul 11 18:23:17 eghx-nitro kernel: [81529.000834] IRQ 321: no longer affine to CPU2
Jul 11 18:23:17 eghx-nitro kernel: [81529.001848] smpboot: CPU 2 is now offline
Jul 11 18:23:17 eghx-nitro kernel: [81529.024728] IRQ 1: no longer affine to CPU3
Jul 11 18:23:17 eghx-nitro kernel: [81529.024735] IRQ 8: no longer affine to CPU3
Jul 11 18:23:17 eghx-nitro kernel: [81529.024739] IRQ 9: no longer affine to CPU3
Jul 11 18:23:17 eghx-nitro kernel: [81529.024744] IRQ 14: no longer affine to CPU3
Jul 11 18:23:17 eghx-nitro kernel: [81529.024749] IRQ 16: no longer affine to CPU3
Jul 11 18:23:17 eghx-nitro kernel: [81529.025814] smpboot: CPU 3 is now offline
Jul 11 18:23:17 eghx-nitro kernel: [81529.028853] ACPI: Low-level resume complete
Jul 11 18:23:17 eghx-nitro kernel: [81529.028986] ACPI: EC: EC started
Jul 11 18:23:17 eghx-nitro kernel: [81529.028986] PM: Restoring platform NVS memory
Jul 11 18:23:17 eghx-nitro kernel: [81529.029759] Suspended for
73345.870 seconds

### July 12 20 hrs of sleep 70% --> 50% + 30 mins video **OK**
Jul 11 21:58:12 eghx-nitro systemd-sleep[13678]: Suspending system...
Jul 11 21:58:12 eghx-nitro kernel: [93215.850080] PM: Syncing filesystems ... done.
Jul 11 21:58:12 eghx-nitro kernel: [93216.098446] PM: Preparing system for sleep (mem)
Jul 12 18:20:26 eghx-nitro kernel: [93218.326276] Freezing user space processes ... (elapsed 0.002 seconds) done.
Jul 12 18:20:26 eghx-nitro kernel: [93218.328628] OOM killer disabled.
Jul 12 18:20:26 eghx-nitro kernel: [93218.328629] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 12 18:20:26 eghx-nitro kernel: [93218.330344] PM: Suspending system (mem)
Jul 12 18:20:26 eghx-nitro kernel: [93218.330402] Suspending console(s) (use no_console_suspend to debug)
Jul 12 18:20:26 eghx-nitro kernel: [93218.440220] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 12 18:20:26 eghx-nitro kernel: [93218.440346] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 12 18:20:26 eghx-nitro kernel: [93218.441728] sd 0:0:0:0: [sda] Stopping disk
Jul 12 18:20:26 eghx-nitro kernel: [93218.458485] sd 2:0:0:0: [sdb] Stopping disk
Jul 12 18:20:26 eghx-nitro kernel: [93219.720892] PM: suspend of devices complete after 1281.549 msecs
Jul 12 18:20:26 eghx-nitro kernel: [93219.742717] PM: late suspend of devices complete after 21.820 msecs
Jul 12 18:20:26 eghx-nitro kernel: [93219.874700] PM: noirq suspend of devices complete after 131.975 msecs
Jul 12 18:20:26 eghx-nitro kernel: [93219.875308] ACPI: Preparing to enter system sleep state S3
Jul 12 18:20:26 eghx-nitro kernel: [93219.876020] ACPI: EC: event blocked
Jul 12 18:20:26 eghx-nitro kernel: [93219.876020] ACPI: EC: EC stopped
Jul 12 18:20:26 eghx-nitro kernel: [93219.876021] PM: Saving platform NVS memory
Jul 12 18:20:26 eghx-nitro kernel: [93219.876111] Disabling non-boot CPUs ...
Jul 12 18:20:26 eghx-nitro kernel: [93219.891162] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 12 18:20:26 eghx-nitro kernel: [93219.891164] IRQ 316: no longer affine to CPU1
Jul 12 18:20:26 eghx-nitro kernel: [93219.891169] IRQ 317: no longer affine to CPU1
Jul 12 18:20:26 eghx-nitro kernel: [93219.892190] smpboot: CPU 1 is now offline
Jul 12 18:20:26 eghx-nitro kernel: [93219.911138] IRQ 122: no longer affine to CPU2
Jul 12 18:20:26 eghx-nitro kernel: [93219.911175] IRQ 322: no longer affine to CPU2
Jul 12 18:20:26 eghx-nitro kernel: [93219.912189] smpboot: CPU 2 is now offline
Jul 12 18:20:26 eghx-nitro kernel: [93219.935067] IRQ 1: no longer affine to CPU3
Jul 12 18:20:26 eghx-nitro kernel: [93219.935074] IRQ 8: no longer affine to CPU3
Jul 12 18:20:26 eghx-nitro kernel: [93219.935078] IRQ 9: no longer affine to CPU3
Jul 12 18:20:26 eghx-nitro kernel: [93219.935083] IRQ 14: no longer affine to CPU3
Jul 12 18:20:26 eghx-nitro kernel: [93219.935088] IRQ 16: no longer affine to CPU3
Jul 12 18:20:26 eghx-nitro kernel: [93219.935094] IRQ 17: no longer affine to CPU3
Jul 12 18:20:26 eghx-nitro kernel: [93219.936155] smpboot: CPU 3 is now offline
Jul 12 18:20:26 eghx-nitro kernel: [93219.939184] ACPI: Low-level resume complete
Jul 12 18:20:26 eghx-nitro kernel: [93219.939317] ACPI: EC: EC started
Jul 12 18:20:26 eghx-nitro kernel: [93219.939317] PM: Restoring platform NVS memory
Jul 12 18:20:26 eghx-nitro kernel: [93219.940090] Suspended for
73329.209 seconds

### July 13 computer continues to sleep
### July 14 42 hrs of sleep ~90% --> 50% + 10 mins of work **OK**
Jul 12 22:03:04 eghx-nitro systemd[1]: Starting Suspend...
Jul 12 22:03:04 eghx-nitro systemd-sleep[30051]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul 12 22:03:04 eghx-nitro systemd-sleep[30052]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul 12 22:03:04 eghx-nitro systemd-sleep[30051]: Suspending system...
Jul 12 22:03:04 eghx-nitro kernel: [105632.977934] PM: Syncing filesystems ... done.
Jul 12 22:03:04 eghx-nitro kernel: [105633.147275] PM: Preparing system for sleep (mem)
Jul 14 16:53:08 eghx-nitro kernel: [105635.504742] Freezing user space processes ... (elapsed 0.001 seconds) done.
Jul 14 16:53:08 eghx-nitro kernel: [105635.506504] OOM killer disabled.
Jul 14 16:53:08 eghx-nitro kernel: [105635.506505] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 14 16:53:08 eghx-nitro kernel: [105635.507885] PM: Suspending system (mem)
Jul 14 16:53:08 eghx-nitro kernel: [105635.507946] Suspending console(s) (use no_console_suspend to debug)
Jul 14 16:53:08 eghx-nitro kernel: [105635.724020] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 14 16:53:08 eghx-nitro kernel: [105635.724395] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 14 16:53:08 eghx-nitro kernel: [105635.724618] sd 2:0:0:0: [sdb] Stopping disk
Jul 14 16:53:08 eghx-nitro kernel: [105635.725823] sd 0:0:0:0: [sda] Stopping disk
Jul 14 16:53:08 eghx-nitro kernel: [105637.040479] PM: suspend of devices complete after 1317.536 msecs
Jul 14 16:53:08 eghx-nitro kernel: [105637.062292] PM: late suspend of devices complete after 21.808 msecs
Jul 14 16:53:08 eghx-nitro kernel: [105637.194285] PM: noirq suspend of devices complete after 131.988 msecs
Jul 14 16:53:08 eghx-nitro kernel: [105637.194894] ACPI: Preparing to enter system sleep state S3
Jul 14 16:53:08 eghx-nitro kernel: [105637.195602] ACPI: EC: event blocked
Jul 14 16:53:08 eghx-nitro kernel: [105637.195602] ACPI: EC: EC stopped
Jul 14 16:53:08 eghx-nitro kernel: [105637.195603] PM: Saving platform NVS memory
Jul 14 16:53:08 eghx-nitro kernel: [105637.195692] Disabling non-boot CPUs ...
Jul 14 16:53:08 eghx-nitro kernel: [105637.210770] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 14 16:53:08 eghx-nitro kernel: [105637.210772] IRQ 316: no longer affine to CPU1
Jul 14 16:53:08 eghx-nitro kernel: [105637.210777] IRQ 317: no longer affine to CPU1
Jul 14 16:53:08 eghx-nitro kernel: [105637.211795] smpboot: CPU 1 is now offline
Jul 14 16:53:08 eghx-nitro kernel: [105637.230721] IRQ 122: no longer affine to CPU2
Jul 14 16:53:08 eghx-nitro kernel: [105637.230759] IRQ 318: no longer affine to CPU2
Jul 14 16:53:08 eghx-nitro kernel: [105637.230764] IRQ 321: no longer affine to CPU2
Jul 14 16:53:08 eghx-nitro kernel: [105637.231778] smpboot: CPU 2 is now offline
Jul 14 16:53:08 eghx-nitro kernel: [105637.254651] IRQ 1: no longer affine to CPU3
Jul 14 16:53:08 eghx-nitro kernel: [105637.254657] IRQ 8: no longer affine to CPU3
Jul 14 16:53:08 eghx-nitro kernel: [105637.254662] IRQ 9: no longer affine to CPU3
Jul 14 16:53:08 eghx-nitro kernel: [105637.254667] IRQ 14: no longer affine to CPU3
Jul 14 16:53:08 eghx-nitro kernel: [105637.254672] IRQ 16: no longer affine to CPU3
Jul 14 16:53:08 eghx-nitro kernel: [105637.255738] smpboot: CPU 3 is now offline
Jul 14 16:53:08 eghx-nitro kernel: [105637.258794] ACPI: Low-level resume complete
Jul 14 16:53:08 eghx-nitro kernel: [105637.258926] ACPI: EC: EC started
Jul 14 16:53:08 eghx-nitro kernel: [105637.258927] PM: Restoring platform NVS memory
Jul 14 16:53:08 eghx-nitro kernel: [105637.259699] Suspended for 154199.483 seconds
### No more logging required

Logging is not necessary anymore. No signs of failing PC for one week
now after upgrade and stuff! We will start logging again if it happens
again!

Computer not shutdown since july 6 atleast. Works very much fine.

### July 15 <4 hrs of sleep ~100% --> switch off ; available: 99% **NOK**
It still  continued to work without swtiching off until 50% (after
that I didn't try)
Jul 14 19:50:24 eghx-nitro systemd[1]: Starting Suspend...
Jul 14 19:50:24 eghx-nitro systemd-sleep[24117]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul 14 19:50:24 eghx-nitro systemd-sleep[24118]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul 14 19:50:24 eghx-nitro systemd-sleep[24117]: Suspending system...
Jul 15 09:36:18 eghx-nitro rsyslogd: [origin software="rsyslogd" swVersion="8.16.0" x-pid="827" x-info="http://www.rsyslog.com"] start
Jul 15 09:36:18 eghx-nitro rsyslogd-2222: command 'KLogPermitNonKernelFacility' is currently not permitted - did you already set it via a RainerScript command (v6+ config)? [v8.16.0 try http://www.rsyslog.com/e/2222 ]
Jul 15 09:36:18 eghx-nitro rsyslogd: rsyslogd's groupid changed to 108
Jul 15 09:36:18 eghx-nitro rsyslogd: rsyslogd's userid changed to 104
Jul 15 09:36:18 eghx-nitro systemd-modules-load[246]: Inserted module 'lp'
Jul 15 09:36:18 eghx-nitro systemd-modules-load[246]: Inserted module 'ppdev'
Jul 15 09:36:18 eghx-nitro systemd-modules-load[246]: Inserted module 'parport_pc'
Jul 15 09:36:18 eghx-nitro loadkeys[250]: Loading /etc/console-setup/cached.kmap.gz
Jul 15 09:36:18 eghx-nitro systemd[1]: Started Load Kernel Modules.
Jul 15 09:36:18 eghx-nitro systemd[1]: Mounting Configuration File System...
Jul 15 09:36:18 eghx-nitro systemd[1]: Starting Apply Kernel Variables...
Jul 15 09:36:18 eghx-nitro systemd[1]: Mounting FUSE Control File System...
Jul 15 09:36:18 eghx-nitro systemd[1]: Mounted Configuration File System.
Jul 15 09:36:18 eghx-nitro systemd[1]: Mounted FUSE Control File System.
Jul 15 09:36:18 eghx-nitro systemd[1]: Started Apply Kernel Variables.
Jul 15 09:36:18 eghx-nitro rsyslogd-2039: Could not open output pipe '/dev/xconsole':: No such file or directory [v8.16.0 try http://www.rsyslog.com/e/2039 ]
Jul 15 09:36:18 eghx-nitro systemd[1]: Started Create Static Device Nodes in /dev.
Jul 15 09:36:18 eghx-nitro systemd[1]: Starting udev Kernel Device Manager...
Jul 15 09:36:18 eghx-nitro systemd[1]: Started udev Kernel Device Manager.
Jul 15 09:36:18 eghx-nitro systemd[1]: Starting Remount Root and Kernel File Systems...
Jul 15 09:36:18 eghx-nitro rsyslogd-2007: action 'action 10' suspended, next retry is Sun Jul 15 09:36:48 2018 [v8.16.0 try http://www.rsyslog.com/e/2007 ]

### I was wrong
  * [ ] I suspect it could be something like loose battery? 
  * [ ] or somthing like maybe I should not leave it at 100% charge?
  

as the amount of battery seems to be according really high not worthy
of a turn off!

I am testing now how long my laptop works with "98%" battery

It atleast stayed until 49% after that I put it on charge
### July 16 24 hrs of sleep 51%-->50% + 30 mins video **OK**


Jul 15 22:58:39 eghx-nitro systemd[1]: Starting Suspend...
Jul 15 22:58:39 eghx-nitro wpa_supplicant[1047]: nl80211: deinit ifname=wlp2s0 disabled_11b_rates=0
Jul 15 22:58:44 eghx-nitro whoopsie[984]: [22:58:44] Cannot reach: https://daisy.ubuntu.com
Jul 15 22:58:44 eghx-nitro whoopsie[984]: [22:58:44] Cannot reach: https://daisy.ubuntu.com
Jul 15 22:58:49 eghx-nitro systemd-sleep[32389]: Selected interface 'p2p-dev-wlp2s0'
Jul 15 22:58:49 eghx-nitro systemd-sleep[32389]: 'SUSPEND' command timed out.
Jul 15 22:58:49 eghx-nitro systemd-sleep[32391]: /lib/systemd/system-sleep/wpasupplicant failed with error code 254.
Jul 15 22:58:49 eghx-nitro systemd-sleep[32389]: Suspending system...
Jul 15 22:58:49 eghx-nitro kernel: [26582.116582] PM: Syncing filesystems ... done.
Jul 15 22:58:49 eghx-nitro kernel: [26582.384698] PM: Preparing system for sleep (mem)
Jul 16 18:59:23 eghx-nitro kernel: [26584.402776] Freezing user space processes ... (elapsed 0.002 seconds) done.
Jul 16 18:59:23 eghx-nitro kernel: [26584.404781] OOM killer disabled.
Jul 16 18:59:23 eghx-nitro kernel: [26584.404781] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 16 18:59:23 eghx-nitro kernel: [26584.406183] PM: Suspending system (mem)
Jul 16 18:59:23 eghx-nitro kernel: [26584.406217] Suspending console(s) (use no_console_suspend to debug)
Jul 16 18:59:23 eghx-nitro kernel: [26584.514876] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 16 18:59:23 eghx-nitro kernel: [26584.515213] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 16 18:59:23 eghx-nitro kernel: [26584.515526] sd 2:0:0:0: [sdb] Stopping disk
Jul 16 18:59:23 eghx-nitro kernel: [26584.516634] sd 0:0:0:0: [sda] Stopping disk
Jul 16 18:59:23 eghx-nitro kernel: [26585.795563] PM: suspend of devices complete after 1281.545 msecs
Jul 16 18:59:23 eghx-nitro kernel: [26585.817384] PM: late suspend of devices complete after 21.814 msecs
Jul 16 18:59:23 eghx-nitro kernel: [26585.949380] PM: noirq suspend of devices complete after 131.982 msecs
Jul 16 18:59:23 eghx-nitro kernel: [26585.949988] ACPI: Preparing to enter system sleep state S3
Jul 16 18:59:23 eghx-nitro kernel: [26585.950692] ACPI: EC: event blocked
Jul 16 18:59:23 eghx-nitro kernel: [26585.950693] ACPI: EC: EC stopped
Jul 16 18:59:23 eghx-nitro kernel: [26585.950693] PM: Saving platform NVS memory
Jul 16 18:59:23 eghx-nitro kernel: [26585.950789] Disabling non-boot CPUs ...
Jul 16 18:59:23 eghx-nitro kernel: [26585.965859] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 16 18:59:23 eghx-nitro kernel: [26585.965861] IRQ 317: no longer affine to CPU1
Jul 16 18:59:23 eghx-nitro kernel: [26585.965868] IRQ 322: no longer affine to CPU1
Jul 16 18:59:23 eghx-nitro kernel: [26585.966886] smpboot: CPU 1 is now offline
Jul 16 18:59:23 eghx-nitro kernel: [26585.989832] IRQ 122: no longer affine to CPU2
Jul 16 18:59:23 eghx-nitro kernel: [26585.989867] IRQ 320: no longer affine to CPU2
Jul 16 18:59:23 eghx-nitro kernel: [26585.990893] smpboot: CPU 2 is now offline
Jul 16 18:59:23 eghx-nitro kernel: [26586.013743] IRQ 1: no longer affine to CPU3
Jul 16 18:59:23 eghx-nitro kernel: [26586.013749] IRQ 8: no longer affine to CPU3
Jul 16 18:59:23 eghx-nitro kernel: [26586.013754] IRQ 9: no longer affine to CPU3
Jul 16 18:59:23 eghx-nitro kernel: [26586.013759] IRQ 14: no longer affine to CPU3
Jul 16 18:59:23 eghx-nitro kernel: [26586.013764] IRQ 16: no longer affine to CPU3
Jul 16 18:59:23 eghx-nitro kernel: [26586.013768] IRQ 17: no longer affine to CPU3
Jul 16 18:59:23 eghx-nitro kernel: [26586.014829] smpboot: CPU 3 is now offline
Jul 16 18:59:23 eghx-nitro kernel: [26586.017862] ACPI: Low-level resume complete
Jul 16 18:59:23 eghx-nitro kernel: [26586.017998] ACPI: EC: EC started
Jul 16 18:59:23 eghx-nitro kernel: [26586.017998] PM: Restoring platform NVS memory
Jul 16 18:59:23 eghx-nitro kernel: [26586.018775] Suspended for
72028.452 seconds

### July 17 20 hrs of sleep 100%-->90% +45 mins of video and work
**OK**
Jul 16 22:40:03 eghx-nitro systemd[1]: Starting Suspend...
Jul 16 22:40:03 eghx-nitro systemd-sleep[14434]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul 16 22:40:03 eghx-nitro systemd-sleep[14435]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul 16 22:40:03 eghx-nitro systemd-sleep[14434]: Suspending system...
Jul 16 22:40:04 eghx-nitro kernel: [37595.280414] PM: Syncing filesystems ... done.
Jul 16 22:40:04 eghx-nitro kernel: [37596.172622] PM: Preparing system for sleep (mem)
Jul 17 18:29:34 eghx-nitro kernel: [37598.331501] Freezing user space processes ... (elapsed 0.002 seconds) done.
Jul 17 18:29:34 eghx-nitro kernel: [37598.333569] OOM killer disabled.
Jul 17 18:29:34 eghx-nitro kernel: [37598.333569] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 17 18:29:34 eghx-nitro kernel: [37598.334588] PM: Suspending system (mem)
Jul 17 18:29:34 eghx-nitro kernel: [37598.334626] Suspending console(s) (use no_console_suspend to debug)
Jul 17 18:29:34 eghx-nitro kernel: [37598.443489] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 17 18:29:34 eghx-nitro kernel: [37598.443680] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 17 18:29:34 eghx-nitro kernel: [37598.444053] sd 2:0:0:0: [sdb] Stopping disk
Jul 17 18:29:34 eghx-nitro kernel: [37598.445063] sd 0:0:0:0: [sda] Stopping disk
Jul 17 18:29:34 eghx-nitro kernel: [37599.740603] PM: suspend of devices complete after 1297.941 msecs
Jul 17 18:29:34 eghx-nitro kernel: [37599.762456] PM: late suspend of devices complete after 21.847 msecs
Jul 17 18:29:34 eghx-nitro kernel: [37599.894419] PM: noirq suspend of devices complete after 131.958 msecs
Jul 17 18:29:34 eghx-nitro kernel: [37599.895026] ACPI: Preparing to enter system sleep state S3
Jul 17 18:29:34 eghx-nitro kernel: [37599.895736] ACPI: EC: event blocked
Jul 17 18:29:34 eghx-nitro kernel: [37599.895736] ACPI: EC: EC stopped
Jul 17 18:29:34 eghx-nitro kernel: [37599.895737] PM: Saving platform NVS memory
Jul 17 18:29:34 eghx-nitro kernel: [37599.895833] Disabling non-boot CPUs ...
Jul 17 18:29:34 eghx-nitro kernel: [37599.910893] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 17 18:29:34 eghx-nitro kernel: [37599.910894] IRQ 317: no longer affine to CPU1
Jul 17 18:29:34 eghx-nitro kernel: [37599.911918] smpboot: CPU 1 is now offline
Jul 17 18:29:34 eghx-nitro kernel: [37599.934858] IRQ 122: no longer affine to CPU2
Jul 17 18:29:34 eghx-nitro kernel: [37599.934887] IRQ 315: no longer affine to CPU2
Jul 17 18:29:34 eghx-nitro kernel: [37599.934896] IRQ 320: no longer affine to CPU2
Jul 17 18:29:34 eghx-nitro kernel: [37599.935913] smpboot: CPU 2 is now offline
Jul 17 18:29:34 eghx-nitro kernel: [37599.958781] IRQ 1: no longer affine to CPU3
Jul 17 18:29:34 eghx-nitro kernel: [37599.958787] IRQ 8: no longer affine to CPU3
Jul 17 18:29:34 eghx-nitro kernel: [37599.958791] IRQ 9: no longer affine to CPU3
Jul 17 18:29:34 eghx-nitro kernel: [37599.958796] IRQ 14: no longer affine to CPU3
Jul 17 18:29:34 eghx-nitro kernel: [37599.958802] IRQ 16: no longer affine to CPU3
Jul 17 18:29:34 eghx-nitro kernel: [37599.958806] IRQ 17: no longer affine to CPU3
Jul 17 18:29:34 eghx-nitro kernel: [37599.959867] smpboot: CPU 3 is now offline
Jul 17 18:29:34 eghx-nitro kernel: [37599.962860] ACPI: Low-level resume complete
Jul 17 18:29:34 eghx-nitro kernel: [37599.962994] ACPI: EC: EC started
Jul 17 18:29:34 eghx-nitro kernel: [37599.962995] PM: Restoring platform NVS memory
Jul 17 18:29:34 eghx-nitro kernel: [37599.963772] Suspended for
71365.836 seconds
### July 18, 19, 20 went ok! no issues 20-24 hrs sleep! No log
### July 21?
### July 28 locked PC and then closed screen resulting in restart**NOK**
No Idea what happened. only one hr of sleep and boom some it looked
like it had already restarted!

Jul 28 11:30:40 eghx-nitro wpa_supplicant[1008]: nl80211: deinit ifname=p2p-dev-wlp2s0 disabled_11b_rates=0
Jul 28 11:30:40 eghx-nitro systemd[1]: Reached target Sleep.
Jul 28 11:30:40 eghx-nitro systemd[1]: Starting Suspend...
Jul 28 11:30:41 eghx-nitro wpa_supplicant[1008]: nl80211: deinit ifname=wlp2s0 disabled_11b_rates=0
Jul 28 11:30:45 eghx-nitro whoopsie[938]: [11:30:45] Cannot reach: https://daisy.ubuntu.com
Jul 28 11:30:45 eghx-nitro whoopsie[938]: [11:30:45] Cannot reach: https://daisy.ubuntu.com
Jul 28 11:30:50 eghx-nitro systemd-sleep[30578]: Selected interface 'wlp2s0'
Jul 28 11:30:50 eghx-nitro systemd-sleep[30578]: 'SUSPEND' command timed out.
Jul 28 11:30:50 eghx-nitro systemd-sleep[30579]: /lib/systemd/system-sleep/wpasupplicant failed with error code 254.
Jul 28 11:30:50 eghx-nitro systemd-sleep[30578]: Suspending system...
Jul 28 11:30:50 eghx-nitro kernel: [50201.567281] PM: suspend entry (deep)
Jul 28 11:30:51 eghx-nitro kernel: [50201.567282] PM: Syncing filesystems ... done.
Jul 28 12:32:58 eghx-nitro kernel: [50203.860835] Freezing user space processes ... (elapsed 0.062 seconds) done.
Jul 28 12:32:58 eghx-nitro kernel: [50203.923160] OOM killer disabled.
Jul 28 12:32:58 eghx-nitro kernel: [50203.923162] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 28 12:32:58 eghx-nitro kernel: [50203.924953] Suspending console(s) (use no_console_suspend to debug)
Jul 28 12:32:58 eghx-nitro kernel: [50204.055025] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 28 12:32:58 eghx-nitro kernel: [50204.055130] sd 2:0:0:0: [sdb] Stopping disk
Jul 28 12:32:58 eghx-nitro kernel: [50204.062459] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 28 12:32:58 eghx-nitro kernel: [50204.063866] sd 0:0:0:0: [sda] Stopping disk
Jul 28 12:32:58 eghx-nitro kernel: [50205.331224] ACPI: EC: interrupt blocked
Jul 28 12:32:58 eghx-nitro kernel: [50205.487145] ACPI: Preparing to enter system sleep state S3
Jul 28 12:32:58 eghx-nitro kernel: [50205.488071] ACPI: EC: event blocked
Jul 28 12:32:58 eghx-nitro kernel: [50205.488072] ACPI: EC: EC stopped
Jul 28 12:32:58 eghx-nitro kernel: [50205.488073] PM: Saving platform NVS memory
Jul 28 12:32:58 eghx-nitro kernel: [50205.488167] Disabling non-boot CPUs ...
Jul 28 12:32:58 eghx-nitro kernel: [50205.502932] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 28 12:32:58 eghx-nitro kernel: [50205.502934] IRQ 124: no longer affine to CPU1
Jul 28 12:32:58 eghx-nitro kernel: [50205.502940] IRQ 129: no longer affine to CPU1
Jul 28 12:32:58 eghx-nitro kernel: [50205.503961] smpboot: CPU 1 is now offline
Jul 28 12:32:58 eghx-nitro kernel: [50205.526947] IRQ 122: no longer affine to CPU2
Jul 28 12:32:58 eghx-nitro kernel: [50205.526952] IRQ 123: no longer affine to CPU2
Jul 28 12:32:58 eghx-nitro kernel: [50205.527973] smpboot: CPU 2 is now offline
Jul 28 12:32:58 eghx-nitro kernel: [50205.550884] IRQ 1: no longer affine to CPU3
Jul 28 12:32:58 eghx-nitro kernel: [50205.550890] IRQ 8: no longer affine to CPU3
Jul 28 12:32:58 eghx-nitro kernel: [50205.550894] IRQ 9: no longer affine to CPU3
Jul 28 12:32:58 eghx-nitro kernel: [50205.550899] IRQ 14: no longer affine to CPU3
Jul 28 12:32:58 eghx-nitro kernel: [50205.550904] IRQ 16: no longer affine to CPU3
Jul 28 12:32:58 eghx-nitro kernel: [50205.550909] IRQ 17: no longer affine to CPU3
Jul 28 12:32:58 eghx-nitro kernel: [50205.551935] smpboot: CPU 3 is now offline
Jul 28 12:32:58 eghx-nitro kernel: [50205.554844] ACPI: Low-level resume complete
Jul 28 12:32:58 eghx-nitro kernel: [50205.554976] ACPI: EC: EC started
Jul 28 12:32:58 eghx-nitro kernel: [50205.554977] PM: Restoring platform NVS memory
Jul 28 12:32:58 eghx-nitro kernel: [50205.557028] Enabling non-boot CPUs ...
Jul 28 12:32:58 eghx-nitro kernel: [50205.557091] x86: Booting SMP configuration:
Jul 28 12:32:58 eghx-nitro kernel: [50205.557092] smpboot: Booting Node 0 Processor 1 APIC 0x2
Jul 28 12:32:58 eghx-nitro kernel: [50205.558638]  cache: parent cpu1 should not be sleeping
Jul 28 12:32:58 eghx-nitro kernel: [50205.558671] intel_pstate: Disabling energy efficiency optimization
Jul 28 12:32:58 eghx-nitro kernel: [50205.558770] CPU1 is up
Jul 28 12:32:58 eghx-nitro kernel: [50205.558804] smpboot: Booting Node 0 Processor 2 APIC 0x4
Jul 28 12:32:58 eghx-nitro kernel: [50205.560356]  cache: parent cpu2 should not be sleeping
Jul 28 12:32:58 eghx-nitro kernel: [50205.560498] CPU2 is up
Jul 28 12:32:58 eghx-nitro kernel: [50205.560517] smpboot: Booting Node 0 Processor 3 APIC 0x6
Jul 28 12:32:58 eghx-nitro kernel: [50205.562090]  cache: parent cpu3 should not be sleeping
Jul 28 12:32:58 eghx-nitro kernel: [50205.562239] CPU3 is up
Jul 28 12:32:58 eghx-nitro kernel: [50205.564812] ACPI: Waking up from system sleep state S3
Jul 28 12:32:58 eghx-nitro kernel: [50205.568621] ACPI: EC: interrupt unblocked
Jul 28 12:32:58 eghx-nitro kernel: [50205.815020] ACPI: EC: event unblocked
Jul 28 12:32:58 eghx-nitro kernel: [50205.827191] sd 0:0:0:0: [sda] Starting disk
Jul 28 12:32:58 eghx-nitro kernel: [50205.827194] sd 2:0:0:0: [sdb] Starting disk
Jul 28 12:32:58 eghx-nitro kernel: [50205.854725] r8169 0000:03:00.1 enp3s0f1: link down
Jul 28 12:32:58 eghx-nitro kernel: [50206.106115] usb 1-7: reset full-speed USB device number 2 using xhci_hcd
Jul 28 12:32:58 eghx-nitro kernel: [50206.148667] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Jul 28 12:32:58 eghx-nitro kernel: [50206.149470] ata1.00: configured for UDMA/133
Jul 28 12:32:58 eghx-nitro kernel: [50206.382732] usb 1-9: reset high-speed USB device number 3 using xhci_hcd
Jul 28 12:32:58 eghx-nitro kernel: [50206.578390] acpi LNXPOWER:01: Turning OFF
Jul 28 12:32:58 eghx-nitro kernel: [50206.578437] OOM killer enabled.
Jul 28 12:32:58 eghx-nitro kernel: [50206.578438] Restarting tasks ... 
Jul 28 12:32:58 eghx-nitro kernel: [50206.578564] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
Jul 28 12:32:58 eghx-nitro kernel: [50206.578565] Bluetooth: hci0: QCA: patch rome 0x302 build 0x138, firmware rome 0x302 build 0x111
Jul 28 12:32:58 eghx-nitro kernel: [50206.592834] done.
Jul 28 12:32:58 eghx-nitro kernel: [50206.610128] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
Jul 28 12:32:58 eghx-nitro kernel: [50206.654648] PM: suspend exit
Jul 28 12:32:58 eghx-nitro kernel: [50206.663920] Read-error on swap-device (8:16:1638994096)
Jul 28 12:32:58 eghx-nitro kernel: [50207.342647] [drm] RC6 on
Jul 28 12:32:59 eghx-nitro kernel: [50207.886402] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Jul 28 12:32:59 eghx-nitro kernel: [50207.933282] ata3.00: configured for UDMA/100
Jul 28 12:33:00 eghx-nitro systemd-sleep[30578]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul 28 12:33:00 eghx-nitro acpid: client 

### July 29 4 hr sleep and then opens with restarting
Is it possible that I pressed the power button by accident? or
squeezed the laptop so much?

Jul 29 15:47:07 eghx-nitro systemd[1]: Starting Suspend...
Jul 29 15:47:07 eghx-nitro wpa_supplicant[1008]: nl80211: deinit ifname=wlp2s0 disabled_11b_rates=0
Jul 29 15:47:17 eghx-nitro systemd-sleep[19913]: Selected interface 'p2p-dev-wlp2s0'
Jul 29 15:47:17 eghx-nitro systemd-sleep[19913]: 'SUSPEND' command timed out.
Jul 29 15:47:17 eghx-nitro systemd-sleep[19914]: /lib/systemd/system-sleep/wpasupplicant failed with error code 254.
Jul 29 15:47:17 eghx-nitro systemd-sleep[19913]: Suspending system...
Jul 29 15:47:17 eghx-nitro kernel: [72279.061259] PM: suspend entry (deep)
Jul 29 15:47:17 eghx-nitro kernel: [72279.061262] PM: Syncing filesystems ... done.
Jul 29 20:05:49 eghx-nitro kernel: [72281.864212] Freezing user space processes ... (elapsed 0.002 seconds) done.
Jul 29 20:05:49 eghx-nitro kernel: [72281.866236] OOM killer disabled.
Jul 29 20:05:49 eghx-nitro kernel: [72281.866237] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Jul 29 20:05:49 eghx-nitro kernel: [72281.867609] Suspending console(s) (use no_console_suspend to debug)
Jul 29 20:05:49 eghx-nitro kernel: [72282.104217] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul 29 20:05:49 eghx-nitro kernel: [72282.104330] sd 2:0:0:0: [sdb] Stopping disk
Jul 29 20:05:49 eghx-nitro kernel: [72282.104499] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul 29 20:05:49 eghx-nitro kernel: [72282.105856] sd 0:0:0:0: [sda] Stopping disk
Jul 29 20:05:49 eghx-nitro kernel: [72283.376848] ACPI: EC: interrupt blocked
Jul 29 20:05:49 eghx-nitro kernel: [72283.532811] ACPI: Preparing to enter system sleep state S3
Jul 29 20:05:49 eghx-nitro kernel: [72283.533741] ACPI: EC: event blocked
Jul 29 20:05:49 eghx-nitro kernel: [72283.533742] ACPI: EC: EC stopped
Jul 29 20:05:49 eghx-nitro kernel: [72283.533743] PM: Saving platform NVS memory
Jul 29 20:05:49 eghx-nitro kernel: [72283.533840] Disabling non-boot CPUs ...
Jul 29 20:05:49 eghx-nitro kernel: [72283.548602] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul 29 20:05:49 eghx-nitro kernel: [72283.548604] IRQ 123: no longer affine to CPU1
Jul 29 20:05:49 eghx-nitro kernel: [72283.548608] IRQ 124: no longer affine to CPU1
Jul 29 20:05:49 eghx-nitro kernel: [72283.549626] smpboot: CPU 1 is now offline
Jul 29 20:05:49 eghx-nitro kernel: [72283.568587] IRQ 122: no longer affine to CPU2
Jul 29 20:05:49 eghx-nitro kernel: [72283.568594] IRQ 129: no longer affine to CPU2
Jul 29 20:05:49 eghx-nitro kernel: [72283.569605] smpboot: CPU 2 is now offline
Jul 29 20:05:49 eghx-nitro kernel: [72283.592546] IRQ 1: no longer affine to CPU3
Jul 29 20:05:49 eghx-nitro kernel: [72283.592552] IRQ 8: no longer affine to CPU3
Jul 29 20:05:49 eghx-nitro kernel: [72283.592557] IRQ 9: no longer affine to CPU3
Jul 29 20:05:49 eghx-nitro kernel: [72283.592562] IRQ 14: no longer affine to CPU3
Jul 29 20:05:49 eghx-nitro kernel: [72283.592566] IRQ 16: no longer affine to CPU3
Jul 29 20:05:49 eghx-nitro kernel: [72283.592570] IRQ 17: no longer affine to CPU3
Jul 29 20:05:49 eghx-nitro kernel: [72283.593596] smpboot: CPU 3 is now offline
Jul 29 20:05:49 eghx-nitro kernel: [72283.596616] ACPI: Low-level resume complete
Jul 29 20:05:49 eghx-nitro kernel: [72283.596752] ACPI: EC: EC started
Jul 29 20:05:49 eghx-nitro kernel: [72283.596752] PM: Restoring platform NVS memory
Jul 29 20:05:49 eghx-nitro kernel: [72283.599107] Enabling non-boot CPUs ...
Jul 29 20:05:49 eghx-nitro kernel: [72283.599142] x86: Booting SMP configuration:
Jul 29 20:05:49 eghx-nitro kernel: [72283.599143] smpboot: Booting Node 0 Processor 1 APIC 0x2
Jul 29 20:05:49 eghx-nitro kernel: [72283.601047]  cache: parent cpu1 should not be sleeping
Jul 29 20:05:49 eghx-nitro kernel: [72283.601086] intel_pstate: Disabling energy efficiency optimization
Jul 29 20:05:49 eghx-nitro kernel: [72283.601202] CPU1 is up
Jul 29 20:05:49 eghx-nitro kernel: [72283.601238] smpboot: Booting Node 0 Processor 2 APIC 0x4
Jul 29 20:05:49 eghx-nitro kernel: [72283.603145]  cache: parent cpu2 should not be sleeping
Jul 29 20:05:49 eghx-nitro kernel: [72283.603312] CPU2 is up
Jul 29 20:05:49 eghx-nitro kernel: [72283.603335] smpboot: Booting Node 0 Processor 3 APIC 0x6
Jul 29 20:05:49 eghx-nitro kernel: [72283.605267]  cache: parent cpu3 should not be sleeping
Jul 29 20:05:49 eghx-nitro kernel: [72283.605441] CPU3 is up
Jul 29 20:05:49 eghx-nitro kernel: [72283.608597] ACPI: Waking up from system sleep state S3
Jul 29 20:05:49 eghx-nitro kernel: [72283.613081] ACPI: EC: interrupt unblocked
Jul 29 20:05:49 eghx-nitro kernel: [72283.864225] ACPI: EC: event unblocked
Jul 29 20:05:49 eghx-nitro kernel: [72283.876197] sd 0:0:0:0: [sda] Starting disk
Jul 29 20:05:49 eghx-nitro kernel: [72283.876231] sd 2:0:0:0: [sdb] Starting disk
Jul 29 20:05:49 eghx-nitro kernel: [72283.903457] r8169 0000:03:00.1 enp3s0f1: link down
Jul 29 20:05:49 eghx-nitro kernel: [72284.111873] usb 1-9: reset high-speed USB device number 3 using xhci_hcd
Jul 29 20:05:49 eghx-nitro kernel: [72284.198598] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Jul 29 20:05:49 eghx-nitro kernel: [72284.199483] ata1.00: configured for UDMA/133
Jul 29 20:05:49 eghx-nitro kernel: [72284.388111] usb 1-7: reset full-speed USB device number 2 using xhci_hcd
Jul 29 20:05:49 eghx-nitro kernel: [72284.539964] acpi LNXPOWER:01: Turning OFF
Jul 29 20:05:49 eghx-nitro kernel: [72284.540036] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
Jul 29 20:05:49 eghx-nitro kernel: [72284.540039] Bluetooth: hci0: QCA: patch rome 0x302 build 0x138, firmware rome 0x302 build 0x111
Jul 29 20:05:49 eghx-nitro kernel: [72284.540079] OOM killer enabled.
Jul 29 20:05:49 eghx-nitro kernel: [72284.540080] Restarting tasks ... done.
Jul 29 20:05:49 eghx-nitro systemd[1]: Time has been changed
Jul 29 20:05:49 eghx-nitro bluetoothd[819]: Endpoint unregistered: sender=:1.391 path=/MediaEndpoint/A2DPSource
Jul 29 20:05:49 eghx-nitro bluetoothd[819]: Endpoint unregistered: sender=:1.391 path=/MediaEndpoint/A2DPSink
Jul 29 20:05:49 eghx-nitro systemd[1]: Starting Load/Save RF Kill Switch Status...
Jul 29 20:05:49 eghx-nitro acpid: client 31033[0:0] has disconnected
Jul 29 20:05:49 eghx-nitro systemd[31398]: Time has been changed
Jul 29 20:05:49 eghx-nitro systemd[1]: bluetooth.target: Unit not needed anymore. Stopping.
Jul 29 20:05:49 eghx-nitro systemd[1]: Stopped target Bluetooth.
Jul 29 20:05:49 eghx-nitro kernel: [72284.567796] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
Jul 29 20:05:50 eghx-nitro systemd-sleep[19913]: System resumed.
Jul 29 20:05:50 eghx-nitro kernel: [72284.609763] PM: suspend exit
Jul 29 20:05:50 eghx-nitro systemd-sleep[19913]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul 29 20:05:50 eghx-nitro systemd-sleep[20023]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul 29 20:05:50 eghx-nitro systemd-sleep[19913]: /dev/sda:
Jul 29 20:05:50 eghx-nitro systemd-sleep[19913]:  setting Advanced
Power Management level to 0x80 (128)

### Solution discovery

Seems to be a problem with other Acer nitro 5's
Loose screw and non re-settable stuff!


Try to reproduce it by shaking or something.

It looks like it is not an ubunut problem. Not many have complained
about it as well.

### Aug 2 2 days of sleep not withstandable it seems **NOK**
### Aug 8 as soon as I took it to the station in my bag **NOK**
### Try solution soon
### Aug 12 Laptop sleeping for 52 hrs **OK** No movement
### Aug 17 tightend screws all screws
tightened all screws, lets see. Slightly more than hand tight I think,
till I slippedish!

Next try battery reset, remove battery and place again.

Test to be done tomorrow!

### Aug 21 tested tightening of screws OK

Seems to be working fine. despite taking it on train, closing it and
opening it multiple times.

### Aug 29 tested >2 day sleep with loss of 50% of battery
### Sep 4-5 tested, chennai to amsterdam (24 hrs)

Came back with 56% charge and no sleep. Also used to mildly charge my
phone and tablet!

### Test is thus complete!
### Sep 18 computer restarted upon opening :(  **NOK**

Fuck ACER!

## Appendix example
  
  
  
### Appendix 1: bad suspend
		
Jul  6 19:45:46 eghx-nitro systemd[1]: Reached target Sleep.
Jul  6 19:45:46 eghx-nitro systemd[1]: Starting Suspend...
Jul  6 19:45:46 eghx-nitro systemd-sleep[5248]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul  6 19:45:46 eghx-nitro systemd-sleep[5249]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul  6 19:45:46 eghx-nitro systemd-sleep[5248]: Suspending system...
Jul  6 19:45:46 eghx-nitro kernel: [ 3177.780922] PM: Syncing filesystems ... done.
**Jul  6 19:45:46 eghx-nitro kernel: [ 3177.906809] PM: Preparing system for sleep (mem)
Jul  6 19:45:55 eghx-nitro kernel: [ 3180.329233] Freezing user space processes ... (elapsed 0.001 seconds) done.**
Jul  6 19:45:55 eghx-nitro kernel: [ 3180.331008] OOM killer disabled.
Jul  6 19:45:55 eghx-nitro kernel: [ 3180.331009] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
**Jul  6 19:45:55 eghx-nitro kernel: [ 3180.332278] PM: Suspending system (mem)
**Jul  6 19:45:55 eghx-nitro kernel: [ 3180.332315] Suspending console(s) (use no_console_suspend to debug)
Jul  6 19:45:55 eghx-nitro kernel: [ 3180.439813] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul  6 19:45:55 eghx-nitro kernel: [ 3180.440273] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul  6 19:45:55 eghx-nitro kernel: [ 3180.440443] sd 2:0:0:0: [sdb] Stopping disk
Jul  6 19:45:55 eghx-nitro kernel: [ 3180.441668] sd 0:0:0:0: [sda] Stopping disk
Jul  6 19:45:55 eghx-nitro kernel: [ 3181.707995] PM: suspend of devices complete after 1269.517 msecs
Jul  6 19:45:55 eghx-nitro kernel: [ 3181.730293] PM: late suspend of devices complete after 22.299 msecs
Jul  6 19:45:55 eghx-nitro kernel: [ 3181.861780] PM: noirq suspend of devices complete after 131.510 msecs
Jul  6 19:45:55 eghx-nitro kernel: [ 3181.862388] ACPI: Preparing to enter system sleep state S3
Jul  6 19:45:55 eghx-nitro kernel: [ 3181.863108] ACPI: EC:
event blocked

		  
### Appendix 2: proper suspend
	
Jul  3 22:33:26 eghx-nitro systemd[1]: Starting Suspend...
Jul  3 22:33:26 eghx-nitro systemd-sleep[18625]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul  3 22:33:26 eghx-nitro systemd-sleep[18626]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul  3 22:33:26 eghx-nitro systemd-sleep[18625]: Suspending system...
Jul  3 22:33:26 eghx-nitro kernel: [16157.751100] PM: Syncing filesystems ... done.
Jul  3 22:33:26 eghx-nitro kernel: [16157.887926] PM: Preparing system for sleep (mem)
Jul  3 22:33:26 eghx-nitro kernel: [16158.189398] usb 1-6: USB disconnect, device number 4
**Jul  3 22:33:27 eghx-nitro acpid: client 980[0:0] has disconnected
Jul  4 18:39:21 eghx-nitro kernel: [16159.643370] Freezing user space processes ... (elapsed 0.002 seconds) done.**
Jul  4 18:39:21 eghx-nitro kernel: [16159.645466] OOM killer disabled.
Jul  4 18:39:21 eghx-nitro kernel: [16159.645466] Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
Jul  4 18:39:21 eghx-nitro kernel: [16159.648667] PM: Suspending system (mem)
Jul  4 18:39:21 eghx-nitro kernel: [16159.648688] Suspending console(s) (use no_console_suspend to debug)
Jul  4 18:39:21 eghx-nitro kernel: [16159.863657] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
Jul  4 18:39:21 eghx-nitro kernel: [16159.863807] sd 2:0:0:0: [sdb] Stopping disk
Jul  4 18:39:21 eghx-nitro kernel: [16159.864150] sd 0:0:0:0: [sda] Synchronizing SCSI cache
Jul  4 18:39:21 eghx-nitro kernel: [16159.865536] sd 0:0:0:0: [sda] Stopping disk
Jul  4 18:39:21 eghx-nitro kernel: [16161.144330] PM: suspend of devices complete after 1281.564 msecs
Jul  4 18:39:21 eghx-nitro kernel: [16161.166142] PM: late suspend of devices complete after 21.807 msecs
Jul  4 18:39:21 eghx-nitro kernel: [16161.298136] PM: noirq suspend of devices complete after 131.989 msecs
Jul  4 18:39:21 eghx-nitro kernel: [16161.298744] ACPI: Preparing to enter system sleep state S3
Jul  4 18:39:21 eghx-nitro kernel: [16161.299451] ACPI: EC: event blocked
Jul  4 18:39:21 eghx-nitro kernel: [16161.299452] ACPI: EC: EC stopped
Jul  4 18:39:21 eghx-nitro kernel: [16161.299452] PM: Saving platform NVS memory
Jul  4 18:39:21 eghx-nitro kernel: [16161.299545] Disabling non-boot CPUs ...
Jul  4 18:39:21 eghx-nitro kernel: [16161.314590] irq_migrate_all_off_this_cpu: 2 callbacks suppressed
Jul  4 18:39:21 eghx-nitro kernel: [16161.314592] IRQ 317: no longer affine to CPU1
Jul  4 18:39:21 eghx-nitro kernel: [16161.315611] smpboot: CPU 1 is now offline
Jul  4 18:39:21 eghx-nitro kernel: [16161.338557] IRQ 122: no longer affine to CPU2
Jul  4 18:39:21 eghx-nitro kernel: [16161.338591] IRQ 318: no longer affine to CPU2
Jul  4 18:39:21 eghx-nitro kernel: [16161.339606] smpboot: CPU 2 is now offline
Jul  4 18:39:21 eghx-nitro kernel: [16161.362504] IRQ 1: no longer affine to CPU3
Jul  4 18:39:21 eghx-nitro kernel: [16161.362509] IRQ 8: no longer affine to CPU3
Jul  4 18:39:21 eghx-nitro kernel: [16161.362513] IRQ 9: no longer affine to CPU3
Jul  4 18:39:21 eghx-nitro kernel: [16161.362519] IRQ 14: no longer affine to CPU3
Jul  4 18:39:21 eghx-nitro kernel: [16161.362524] IRQ 16: no longer affine to CPU3
Jul  4 18:39:21 eghx-nitro kernel: [16161.362529] IRQ 17: no longer affine to CPU3
Jul  4 18:39:21 eghx-nitro kernel: [16161.362562] IRQ 315: no longer affine to CPU3
Jul  4 18:39:21 eghx-nitro kernel: [16161.363601] smpboot: CPU 3 is now offline
Jul  4 18:39:21 eghx-nitro kernel: [16161.366697] ACPI: Low-level resume complete
Jul  4 18:39:21 eghx-nitro kernel: [16161.366830] ACPI: EC: EC started
Jul  4 18:39:21 eghx-nitro kernel: [16161.366830] PM: Restoring platform NVS memory
Jul  4 18:39:21 eghx-nitro kernel: [16161.367604] **Suspended for 72351.211**seconds


### Appendix 3 : a bad suspend

Jul  4 22:11:45 eghx-nitro systemd[1]: Starting Suspend...
Jul  4 22:11:45 eghx-nitro systemd-sleep[12786]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
Jul  4 22:11:45 eghx-nitro systemd-sleep[12787]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
Jul  4 22:11:45 eghx-nitro systemd-sleep[12786]: **Suspending system...**
Jul  5 **18:45:21** eghx-nitro rsyslogd: [origin software="rsyslogd" swVersion="8.16.0" x-pid="833" x-info="http://www.rsyslog.com"] start
Jul  5 18:45:21 eghx-nitro rsyslogd-2222: command 'KLogPermitNonKernelFacility' is currently not permitted - did you already set it via a RainerScript command (v6+ config)? [v8.16.0 try http://www.rsyslog.com/e/2222 ]
Jul  5 18:45:21 eghx-nitro rsyslogd: rsyslogd's groupid changed to 108
Jul  5 18:45:21 eghx-nitro rsyslogd: rsyslogd's userid changed to 104
