---
layout: post
comments: true
title:  "Fixing ubuntu"
date:    06-07-2018 19:39
categories: The Beginning
permalink: /:title.html
published: false
---

# Hypothesis

  * [x] suspend not suspending after lid close
  
  Looks like it does something
  
  Although I see the following:

	
        Jul  6 19:45:46 eghx-nitro systemd[1]: Reached target Sleep.
          Jul  6 19:45:46 eghx-nitro systemd[1]: Starting Suspend...
          Jul  6 19:45:46 eghx-nitro systemd-sleep[5248]: Failed to connect to non-global ctrl_ifname: (nil)  error: No such file or directory
			  Jul  6 19:45:46 eghx-nitro systemd-sleep[5249]: /lib/systemd/system-sleep/wpasupplicant failed with error code 255.
          Jul  6 19:45:46 eghx-nitro systemd-sleep[5248]: Suspending
		  system...
		  
  
  More in Appendix 1.
  
  
  * [ ] Check if it is your graphics card
  
  get toggler and see if that helps
  
  is your pc working now?
  
  But it also happened in another system of mine same installation.
  
    * [ ] Error in syslog is the reason?





  * [ ] Tried hibernating instead that doesn't work
  
  
  [link](https://askubuntu.com/questions/768136/how-can-i-hibernate-on-ubuntu-16-04). Hibernating has other problems.
  
    * [ ] Battery loose?
  
## Fixing links on askubuntu

[same error ](https://askubuntu.com/a/817667/443958) nothing wrong with this though. This link
provides other places to search for,

	Kernel change is the solution, but mine is quite older

	ps aux | grep su
	
Kernel up-to-date and much much older.
	
No error
  
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
	
## Main problem

  * [x] PM: Supending check
~~Don't know what `Pm:Suspending` is.~~

Appendix 2 shows a proper suspend or a successful one and it has the
`PM: Suspending system (mem)` in it.

  * [x]  Don't know if system is suspending at all. 
  
  I think it is as it is able to sleep for 16 hrs reliably  (after
  upgrade data on july 6)
  Before upgrade 24 hrs was not completely predictable.

## Todo:

Upgrade pc and make it up to date

  * [x] Upgrade to latest kernel

And check this page ([more suggestions](https://askubuntu.com/questions/765747/upgraded-ubuntu-16-04-sometimes-fails-to-sleep/817667#817667)) for more solution.

Upgraded system using 
	
		$ sudo apt-get upgrade 
  
  
Problem

Some days its lasts the whole day. Somedays it just freaking switches
off. 
  
with the same error. Example July 3 and july 4 was fine.  
  


## DATA
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

## Appendix 1
  
  
  
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
