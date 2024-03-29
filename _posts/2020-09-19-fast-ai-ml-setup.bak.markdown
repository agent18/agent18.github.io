---
layout: post
comments: true
title:  "Learning ML"
date: 19-09-2020
categories: notes
tags: ml, dl
permalink: /:title.html
published: false
---

## fastai alternatives

https://www.fast.ai/2017/04/06/alternatives/

## Resources

2018 Lesson 1 wiki: https://forums.fast.ai/t/wiki-thread-lesson-1/6825

course 2018: https://course18.fast.ai/lessonsml1/lesson1.html

2020 setup help: https://forums.fast.ai/t/setup-help/65529

Ubuntu setup help used:

- https://forums.fast.ai/t/pytorch-installation-in-conda-environment-failing/6703/19
 
- https://forums.fast.ai/t/platform-local-server-ubuntu/65851

updates 2020:
https://forums.fast.ai/t/official-part-1-2020-updates-and-resources-thread/63376
  
> ^^ Has all the code pictures and text

2020 book:https://github.com/fastai/fastbook/blob/master/01_intro.ipynb

2020 software fastai repo: https://github.com/fastai/fastai

> ^^ this is fastai v2 written from scratch

2020 course nbs: https://github.com/fastai/fastbook/tree/master/clean

2020 readme page fastai: https://course.fast.ai/#How-do-I-get-started?

2020 lesson 1 wiki: https://forums.fast.ai/t/lesson-1-official-topic/65626

forums: https://forums.fast.ai/ 

Lesson 1 wiki: https://forums.fast.ai/t/lesson-1-official-topic/65626

Help with setup: https://forums.fast.ai/t/setup-help/65529


**Old**

fastiai2 - https://github.com/fastai/fastai2 
coursev4 - https://github.com/fastai/course-v4 
fastbook - https://github.com/fastai/fastbook 

## Prepping ubuntu

	sudo apt-get update
	sudo apt-get upgrade
	
Software and updates also does the above. But you see errors with
[ppa](https://itsfoss.com/ppa-guide/) with `sudo apt-get update` [it seems](https://askubuntu.com/questions/362872/is-using-software-updater-the-same-thing-as-running-apt-get-update-and-apt-get-u).

If PPA seems not necessary anymore: Fixing errors with `sudo apt-get
update` --> fixed with `#` in the `ppa` directory (source: [here](https://itsfoss.com/ppa-guide/)).

Had errors in ppa from opencpu, seems to be used for R but I don't
know if there is even a point in maintaining the ppa. For later. For
now `#`.


## changing ubuntu desktop

All the info you need about environments is [here](https://askubuntu.com/questions/65083/what-kinds-of-desktop-environments-and-shells-are-available). There is unity,
there is gnome there is kde...

Unity is default till 16.

Info about [systemctl-suspend and pm-suspend](https://unix.stackexchange.com/a/485056/267853)

## Installing fastai

**Resources**

How to install nvidia drivers is [here](https://www.cyberciti.biz/faq/ubuntu-linux-install-nvidia-driver-latest-proprietary-driver/) and [here](https://askubuntu.com/a/851144/443958) and [here](https://askubuntu.com/questions/61396/how-do-i-install-the-nvidia-drivers).


### question (no answer on stack) (archive)

[Stack link](https://askubuntu.com/questions/1276660/identify-and-install-the-latest-nvidia-driver-for-ubuntu-16)

**Goal**

I somehow installed the driver 3 years back and want to check if I
have the latest ones and if they are upgraded.

**Status**

`Additional drivers` in `Software & Updates` shows a bunch of
NVIDIA graphics drivers. And currently `390` has been installed and I
see it working with the processes using the GPU, with:
	
	nvidia-smi

I dont think I have added repos ever, (like [this][1]):

    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt update 

I know this because I don't see the `graphics-drivers` PPA's in 

    grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/*


**Question**

0. When I look in Nvidia website there is a higher proprietary version
[450](https://www.nvidia.com/Download/driverResults.aspx/163238/en-us), based on the official [Nvidia driver finder](https://www.nvidia.com/Download/index.aspx?lang=en-us). When I look in launchpad it says [`430`][2] is the current supported version, but`450`
is not shown in `additional drivers`. Why? What am I missing?

1. I want to go to the latest driver available. Is `390` the latest
   stable release for Ubuntu 16.04? How do I figure this out?
  
2. There are many ways to install `450` (I am afraid of conflicts or my
   system breaking). Which should I prefer now that I have `390` via
   `additional drivers`? 

	- download from [Nvidia site](https://www.nvidia.com/Download/driverResults.aspx/135161/en-us) and install
	- apt-get has it's own install `sudo apt-get nvidia-\*\*450\*\*`,
      once I have the `graphics-drivers` PPA's.
	- add PPAs and install from `additional drivers`

3. Should I uninstall `390` so I can install `450` and if so how? (there is no option in
   `additional drivers` to unselect all options). Is the following ok?
   
		$ sudo apt purge nvidia-390 -y
		$ sudo apt autoremove -y
		$ sudo apt autoclean

4. Should I [disable][3] `secure boot` before installing and enable it afterwards?

**Current Config**

- Ubuntu 16.04 LTS & Windows 10 dual boot
- 8 gb ram
- Nvidia GeForce GTX 1050/PCIe/SSE2


  [1]: https://askubuntu.com/a/851144/443958
  [2]: https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa
  [3]: https://askubuntu.com/a/937898/443958
  
## Installing fastai with dependencies

**Packages to be installed** can be found in the [`environment.yml`](https://github.com/fastai/fastai/blob/master/environment.yml)

**What seems to work (period)**:

	conda create --name fastaiclean 

	conda install -c fastai -c pytorch -c anaconda fastai 
	
	conda install -c fastai -c pytorch -c anaconda gh
	
	conda install -c conda-forge notebook
	
Yes to all the disclaimers such as additional packages to be installed.
	
	
Based on [this stack answer](https://stackoverflow.com/a/64056681/5986651): We don't need to install anaconda
package as the miniconda install doesn't seem to require it.
	
	
**What doens't work**

	`conda create --name fastai --clone base`

[Man page](https://docs.fast.ai/#Installing) instructions and directly into existing anaconda setup
leads to conflicts (not sure how to solve):

	conda install -c fastai -c pytorch -c anaconda fastai gh anaconda


**Error** seems to be some [HTTPS error with Pytorch](https://forums.fast.ai/t/pytorch-installation-in-conda-environment-failing/6703). 


**What else seems to work (but didn't try)** 

**Source:** [forums of fastai](https://forums.fast.ai/t/platform-local-server-ubuntu/65851/22)

	git clone https://github.com/fastai/fastai2
	cd fastai2
	conda env create -f environment.yml
	conda activate fastai2

    +other things based on errors you get

**Another source**: [Forums of fast ai](https://forums.fast.ai/t/platform-local-server-ubuntu/65851)

**Note about Pip**

> Just in case you haven’t found that one. They can coexist, but maybe
> not in a way you’d expect. Pip can easily be run inside conda. You
> can use conda to manage python versions, install some libraries and
> then use pip for the rest. That will totally work. What will not
> work are packages you installed before installing conda, but that’s
> because the python you run after that (installed by conda) does not
> have the same site-packages directory in sys.path. Ofc, you can
> install them again after installing conda, but they will be
> downloaded, unpacked, and possibly compiled (in case they do not
> have wheels) again. ---[fastaiforum](https://forums.fast.ai/t/installing-fastai-on-ubuntu-using-pip-and-virtualenv/38356/3?u=thetj09)

### GPU not working (running intro.pynb)

``` python
ImportError: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html
```

Fix from this [link](https://ipywidgets.readthedocs.io/en/stable/user_install.html), 

	conda install -c conda-forge ipywidgets

**FASTAI works.** Somehow the GPU was not used, and what took 1 min
for the lecturer in lesson 1 took me 15 mins (atleast that's what it
said).

### Fixing slow computer

- Swap occupied and reverting back from swap

Based on this [stack answer](https://askubuntu.com/a/756409/443958)

	sudo swapoff -a
	sudo swapon -a

## Fixing GPU not working

### Installing the right drivers

**Basically**: `Additional drivers` tab in `Softwares & Updates` does it for you.

Check which drivers are installed?

- `dpkg --get-selections | grep nvidia`

- Go to `Additional drivers` and see what is selected

**Identify the latest stable driver** for Ubuntu 16 and GTX 10 series
GeForce 1050 by:

- Highest in `Additional drivers`

- Launchpad (graphics drivers ppa basically)

- [**launchpad**](https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa) says `430` (430.40)

	- Also the version names contained in the table below show 16.04
      for `430`.

**Uninstall and Re-install**

Add PPA.

	sudo add-apt-repository ppa:graphics-drivers/ppa

**Don't uninstall**! Just change on `additional drivers` and
rebooted and see that `nvidia-smi` shows `430`. 

**Note**: `dpkg --get-selections | grep nvidia` now shows `nvidia-390
deinstall` and `nvidia-430 install`. This doesn't matter.

**Note**: It also says it is **open source** in my `addtional driver`
tab. This looks like a [bug](https://askubuntu.com/questions/1185924/nvidia-vs-nouveau-drivers). It is **proprietary** as fuck.

**Resources on Nvidia graphics card**

- [Stack detailed resource](https://askubuntu.com/a/61433/443958)

These are some ofthe links I looked into:

  [1] --> https://askubuntu.com/a/851144/443958  
  [2] --> https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa  
  [3] --> https://askubuntu.com/a/937898/443958  
  [4] --> https://askubuntu.com/questions/1045241/ubuntu-18-04-how-do-i-install-drivers-for-my-nvidia-geforce-gtx-1050  
[5] --> https://askubuntu.com/questions/61396/how-do-i-install-the-nvidia-drivers?noredirect=1&lq=1  


### What Nvidia driver should I install for Ubuntu 16.04

My question on [AskUbuntu](https://askubuntu.com/questions/1277947/what-are-the-latest-stable-proprietary-drivers-for-ubuntu-16-04-and-nvidia-gefor):

Which is the **LATEST STABLE proprietary drivers** for UBUNTU **16.04** and NVIDIA
Geforce **GTX 1050** (4gb)? There are simply too many answers which I have compiled below:

1. **Nvidia site** says [450](https://www.nvidia.com/Download/driverResults.aspx/163238/en-us)(450.66) is the latest for GTX 1050 (not
   ubuntu version specific)

	- download from [Nvidia site](https://www.nvidia.com/Download/driverResults.aspx/135161/en-us) and install
	- apt-get has it's own install `sudo apt-get nvidia-\*\*450\*\*`,
	
2. **Additional drivers** tab in `Software and Updates` only shows version
   `390`
   
   - **Note:** `graphics-drivers` PPA's have not been added yet.
   
3. [**launchpad**](https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa) says `430` (430.40)
   
    > Current long-lived branch release: `nvidia-430` (430.40) Dropped
	> support for Fermi series
	> (https://nvidia.custhelp.com/app/answers/detail/a_id/4656)
	
4. [**Launchpad**](https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa) also says old branch for GeForce 10 series (1050) is
   390.129
   
   > Old long-lived branch release: `nvidia-390` (390.129)
   > For GF1xx GPUs use `nvidia-390` (390.129)

5. [Launchpad here](https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa) shows overview of packages (scroll down).

	Here the version names contain 16.04 for `430`.
	
6. [Ubuntu recommended drivers](https://help.ubuntu.com/community/BinaryDriverHowto/Nvidia#NVIDIA_drivers_provided_by_the_Ubuntu_repositories) shows different version for
   ubuntu. If I go by this then only `384` has supported versions for
   16.04 (Xenial Xerus)

These are some ofthe links I looked into:

  [1] --> https://askubuntu.com/a/851144/443958  
  [2] --> https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa  
  [3] --> https://askubuntu.com/a/937898/443958  
  [4] --> https://askubuntu.com/questions/1045241/ubuntu-18-04-how-do-i-install-drivers-for-my-nvidia-geforce-gtx-1050  
[5] --> https://askubuntu.com/questions/61396/how-do-i-install-the-nvidia-drivers?noredirect=1&lq=1  


### Answer to NVIDIA driver to be used

**Plan**

> The key to success is simply to go with the Additional Drivers tab
> recommendations. The Ubuntu Developers worked really hard to make
> that tab trustworthy and reliable. It only shows options that are
> compatible with your hardware from sources that you already
> subscribe to. After you add the PPA, then go with the Additional
> Drivers tab (#2 / 430). If you encounter problems, downgrade to 410
> or 390. ---[my post on stack](https://askubuntu.com/q/1277947/443958)

## Fixing issues with Cuda

`pytorch` needs to be compiled with the right cuda. If you look on
`pytorch`'s website it is always installed with torchvision and cuda
version.

CUDA version needs to be matched by the nvidia drivers as per [table 1](https://docs.nvidia.com/deploy/cuda-compatibility/index.HTML).

[pytorch](https://pytorch.org/get-started/previous-versions/) will use it's own cuda (looks like). External CUDA driver from
NVIDIA website not required.

### Multiple versions of cuda in the system

[Stack question by me](https://stackoverflow.com/questions/64089854/pytorch-detection-of-cuda).

I have Nvidia driver `430` on Ubuntu 16.04 with Geforce 1050. It comes
with `libcuda1-430` when I installed the driver from `additional
drivers` tab in ubuntu (`Software and Updates`). I installed `pytorch`
with `conda` which also installed the `cudatoolkit`. 

1. `nvidia-smi` says I have cuda version `10.1`

2. `conda list` tells me cudatoolkit version is `10.2.89` 

3. `print(torch.cuda.current_device())`, I get `10.0.10`? (it
   looks like):
   
    > AssertionError: The NVIDIA driver on your system is too old
		(found version 10010)

4. `print(torch._C._cuda_getCompiledVersion(), 'cuda compiled
   version')` tells me my version is `10.0.20`? 
   
   > 10020 cuda compiled version
   
What am I missing? What version of CUDA is my torch actually looking
at? Why are there so many different versions?

<!-- Based on [Nvidias site](https://docs.nvidia.com/deploy/cuda-compatibility/index.html) I know I need to have <=`CUDA 10.1 -->
<!-- (10.1.105)`. -->

### what is your version of cuda

1. `nvidia-smi` is just showing version it can handle according to
   [Berriel from stack](https://stackoverflow.com/q/64089854/5986651)
   
2. Using `torch.version.cuda` we can find out which version pytorch
   was built with. this was found to be 10.2 (as was `cudatoolkit
   version`)
   
3. & 4. forget it.

Suggestion was to remove pytorch torchvision and cudatoolkit

	conda remove pytorch torchvision cudatoolkit

### Does your cuda work?

[Source 1](https://chrisalbon.com/deep_learning/pytorch/basics/check_if_pytorch_is_using_gpu/), [Stack](https://stackoverflow.com/questions/48152674/how-to-check-if-pytorch-is-using-the-gpu) 

**If testing goes well**

``` python
In [1]: import torch

In [2]: torch.cuda.current_device()
Out[2]: 0

In [3]: torch.cuda.device(0)
Out[3]: <torch.cuda.device at 0x7efce0b03be0>

In [4]: torch.cuda.device_count()
Out[4]: 1

In [5]: torch.cuda.get_device_name(0)
Out[5]: 'GeForce GTX 950M'

In [6]: torch.cuda.is_available()
Out[6]: True
```
**If wrong version of cuda**


	print(torch.cuda.device_count())
	0
	print(torch.cuda.current_device())
	
	AssertionError: 
	The NVIDIA driver on your system is too old (found version 10010).
	
Looking the assertion error on google points to [github pytorch
issues](https://github.com/pytorch/pytorch/issues/4546) where they talk about versions not matching of the driver
and the CUDA version. Digging a bit deeper you see the NVIDIA website
regarding cuda and driver version numbers [Table 1: Nvidia site](https://docs.nvidia.com/deploy/cuda-compatibility/index.html).

### Downgrading cudatoolkit without conflicts

Current version of cuda:

	torch.version.cuda
	
	10.2

Version corresponding to NVIDIA driver (in this case 430)

- nvidia-smi says 10.1
- [Table 1: Nvidia site](https://docs.nvidia.com/deploy/cuda-compatibility/index.html) also says 10.1 and below (roughly).

**What doesn't work?**

In the current conda installing with `cudatoolkit` `pytorch` and
`torchvision` gives tons of [errors](https://pastebin.com/WPJRDwBw).

``` terminal
conda install pytorch==1.6.0 torchvision==0.7.0 cudatoolkit=10.1.168
-c pytorch
```

**What works**

Pytorch installation seems to be paired with pytorch torchvision and
cudatoolkit according to [official website](https://pytorch.org/get-started/previous-versions/).

Remove pytorch torchvision cudatoolkit:

	conda remove pytorch torchvision cudatoolkit

	conda install pytorch==1.6.0 torchvision==0.7.0 cudatoolkit=10.1.168 -c pytorch


Again it asks for several things I say yes blindly but 	seemingly **NO
CONFLICTS**

check what torch.version.cuda is: `10.1`. GREAT we have successfully downgraded.

**Checking seems successful** based on [SO answer](https://stackoverflow.com/a/48152675/5986651)

``` python
In [1]: import torch

In [2]: torch.cuda.current_device()
Out[2]: 0

In [3]: torch.cuda.device(0) ## previously this gave "old driver error"
Out[3]: <torch.cuda.device at 0x7efce0b03be0>

In [4]: torch.cuda.device_count()
Out[4]: 1

In [5]: torch.cuda.get_device_name(0)
Out[5]: 'GeForce GTX 950M'

In [6]: torch.cuda.is_available()
Out[6]: True
```
`torch.cuda.device(0)` previously gave the assertion error that Nvidia
driver was too old. Now I have the value as 0 which seems to be
expected as per: [SO answer](https://stackoverflow.com/a/48152675/5986651). 

**Fresh error:** Now fastai is missing probably got removed when I
removed pytorch or re-installed pytorch.

    conda install -c pytorch -c fastai fastai
	
So far so good. Testing again:

``` terminal
eghx@eghx-nitro:~$ conda activate fastaiclean
(fastaiclean) eghx@eghx-nitro:~$ python
Python 3.8.5 (default, Sep  4 2020, 07:30:14) 
[GCC 7.3.0] :: Anaconda, Inc. on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> torch.cuda.current_device()
0
>>> torch.cuda.device(0)
<torch.cuda.device object at 0x7f14de991d30>
>>> torch.cuda.device_count()
1
>>> torch.cuda.get_device_name()
'GeForce GTX 1050'
>>> torch.cuda.is_available()
True
>>> print(torch.rand(2,3).cuda())
+tensor([[0.2424, 0.8397, 0.6206],
        [0.0982, 0.4568, 0.3958]], device='cuda:0')
>>> print(torch.rand(2,3).cuda())
tensor([[0.8775, 0.8157, 0.1333],
        [0.6189, 0.9641, 0.5741]], device='cuda:0')
>>> 

```

For the first time I saw another process on nvidia-smi


+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory   |
| GPU       PID   Type   Process name                             Usage         |
| ============================================================================= |
| 0      1164      G   /usr/lib/xorg/Xorg                           293MiB      |
| 0      2252      G   compiz                                       114MiB      |
| 0     22866      C   python                                       431MiB      |
+-----------------------------------------------------------------------------+

**Other tools**

		conda search -c pytorch cudatoolkit ## searching for available version
		
		conda list pytorch ## current version installed




## Making GPU work faster

So 2 things I can do. Install libraries that do faster work and then
remove all other processes on the gpu except cuda.

**Resources**

[fastaiforum](https://forums.fast.ai/t/successful-ubuntu-18-04-with-igpu-for-xserver-and-nvidia-gpu-for-cuda-work-setup/20128/2)

[Isolate integrated intel (igpu) from Nvidia (gpu)](https://askubuntu.com/questions/980875/isolate-integrated-intel-igpu-from-nvidia-gpu)

[How to configure iGPU for xserver and nvidia GPU for CUDA work](https://askubuntu.com/questions/1061551/how-to-configure-igpu-for-xserver-and-nvidia-gpu-for-cuda-work) BY
FASTI STASON

[How to configure igpu for xserver and nvidia gpu for cuda?](https://askubuntu.com/a/995125/443958) by
simple solution guy


**Removing xorg processes**

1. change intel graphics card on `nvidia settings`

	or `prime-select intel`

2. added the 

		export LD_LIBRARY_PATH=/usr/lib/nvidia-430:$LD_LIBRARY_PATH
		
and then restarted....

- Put command in '2' in .bashrc to work with every terminal
open... `LD_Library_path` loses its value after terminal session


**Result**

- visibly no difference in speed
- you only save 11% of the gpu. 
- second screen doesn't work
- need to spend even more and more time to fix it.


|                                 | time1 | time2 |
|---------------------------------|-------|-------|
| xorg running on Nvidia          | 1:56  | 1.19  |
| no processes and missing screen | 2.03  | 1.15  |
| Reverting back                  | 2.10  | 1.18  |
| adding the lib stuff            | 1.11  | 1.19  |
| second time                     | 0.58  |1.17  |

We can pursue this later if required.

**Going back to xorg and all the same way**

[Nvidia forums](https://forums.developer.nvidia.com/t/nvidia-settings-error-unable-to-load-info-from-any-available-system/60804/5): `prime-select nvidia`

works.

**Next: So** let's add the xconf file back and see what it does. or
modify it ..

If this allows monitor to work, we keep it otherwise we go back with
`prime-select nvidia`

I want to check out the xconf solution without even modifying any
xconf process.

[components of a GUI](https://en.wikipedia.org/wiki/Display_server)

It's too complicated to get other screen to work and get cuda to
run.. Especially for the complete lack of progress I got. so screw
that.

`sudo prime-select nvidia`

**Making GPU work faster with libraries**

Don't know what this does. Blindly followed it

	conda uninstall --force jpeg libtiff -y	
	conda install -c conda-forge libjpeg-turbo 

	CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd


- step 3 in the [link](https://forums.fast.ai/t/platform-local-server-ubuntu/65851?u=thetj09 )

- [medium post](https://medium.com/@JamesDietle/install-fast-ai-with-ubuntu-18-04-d92c0bc460bd#id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjNmZhNmY1OTUwYTdjZTQ2NWZjZjI0N2FhMGIwOTQ4MjhhYzk1MmMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJuYmYiOjE2MDEwMDI0MjEsImF1ZCI6IjIxNjI5NjAzNTgzNC1rMWs2cWUwNjBzMnRwMmEyamFtNGxqZGNtczAwc3R0Zy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjExMDA3ODMxNzc3MzIxMDQ5MzYyNyIsImVtYWlsIjoidGhldGowOUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXpwIjoiMjE2Mjk2MDM1ODM0LWsxazZxZTA2MHMydHAyYTJqYW00bGpkY21zMDBzdHRnLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwibmFtZSI6IlRoZWogS2lyYW4iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FPaDE0R2dzVWZyNFFLSk44WEx3ZnEwUXhPOHFRdFhZWlZYRUgwbjBEX0xjMGc9czk2LWMiLCJnaXZlbl9uYW1lIjoiVGhlaiIsImZhbWlseV9uYW1lIjoiS2lyYW4iLCJpYXQiOjE2MDEwMDI3MjEsImV4cCI6MTYwMTAwNjMyMSwianRpIjoiNTUzNTA4YzBjMGU3MWY3M2I1MjJiYjY1ZWRmYTE0MmJlYmU1ZmRiMCJ9.hkA7m2I80iCb5PRQJYxaRfAZ5IjeRgbICbAMHN237J_aVwm4C_mBXfSkp6tFpgqp4JqOMCI_FetqEmlXlimKDvoH1Hfd5hpJ2wmqcs9E1FsLYqQ5nv7ff4RdAHcViJQtSS4ikhTEXNn-s4JkPDNP7FZ70_30Do3A0XOJNAxqUvG-xX2xvgJ56xPAK0sN8FPY6wbhM_y0spvE9r8SDtIsodx3NClzJ9asNjFQqnsjOQjIv3C-46qzSgZQpXIn5mQZSSAzfQYsZOJHQQfQ7ECWjKSZxycCegLlF_cy4L5OtEYYC4aSyrJpmNDh0ylbPtSCaUPq9ELXY81Vc4lcxabxdg) also has the same thing.


### Unable to reproduce the "faster libraries" in another env

Unable to reproduce this in other python environment for
some reason. Don't know why...

Based on [stack](conda list -n python3 --export > python3-packages.txt
conda list -n pytorch_p36 --export > pytorch_p36-packages.txt
diff python3-packages.txt pytorch_p36-packages.txt)
	
	conda activate fastaicleantest
	conda list --json --export > agent18/DS-2020/fastaicleantest.json
	conda deactivate
	
	conda actiavte fasaiclean
	conda list --json --export > agen18/DS-2020/fasaiclean.json
	
	cd agent18/DS-2020/
	
	diff fastaicleantest.json fastaiclean.jsonw 

0 differences found, even with manual conda list. don't know where I
screwed up the installation... or what to do to rectify it.

### PIL error

``` python
ImportError: The _imaging extension was built for another version of Pillow or PIL:
Core version: 7.0.0.post3
Pillow version: 7.2.0
```
	
	conda list pil

Apparently, "This is only an installation issue."---[stack](https://stackoverflow.com/a/27804221/5986651).

**Uninstalling pillow and pillow-simd**

	conda uninstall pillow

Said yes to everything

	conda uninstall pillow-simd

Doesn't work. It says no:

``` terminal
(fastaiclean) eghx@eghx-nitro:~/agent18/DS-2020$ conda uninstall pillow pillow-smd
Collecting package metadata (repodata.json): done
Solving environment: failed

PackagesNotFoundError: The following packages are missing from the target environment:
  - pillow-smd
```

Open jupyter notebook and do the [following](https://stackoverflow.com/a/60492355/5986651):

	!pip uninstall -y pillow-simd
	
check with 

	conda list pil
	
now reinstall it...

	CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd

Was I supposed to install pillow first?

now somehow fastai is missing. :(

	conda install -c pytorch -c fastai fastai
	
yes to all

OK that nonsense works. 

**BTW pillow is currently not installed...**

Checked timings with the standard file and all seems well. 

### Other sources regarding installation

- [medium post](https://medium.com/@JamesDietle/install-fast-ai-with-ubuntu-18-04-d92c0bc460bd#id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjNmZhNmY1OTUwYTdjZTQ2NWZjZjI0N2FhMGIwOTQ4MjhhYzk1MmMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJuYmYiOjE2MDEwMDI0MjEsImF1ZCI6IjIxNjI5NjAzNTgzNC1rMWs2cWUwNjBzMnRwMmEyamFtNGxqZGNtczAwc3R0Zy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjExMDA3ODMxNzc3MzIxMDQ5MzYyNyIsImVtYWlsIjoidGhldGowOUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXpwIjoiMjE2Mjk2MDM1ODM0LWsxazZxZTA2MHMydHAyYTJqYW00bGpkY21zMDBzdHRnLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwibmFtZSI6IlRoZWogS2lyYW4iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FPaDE0R2dzVWZyNFFLSk44WEx3ZnEwUXhPOHFRdFhZWlZYRUgwbjBEX0xjMGc9czk2LWMiLCJnaXZlbl9uYW1lIjoiVGhlaiIsImZhbWlseV9uYW1lIjoiS2lyYW4iLCJpYXQiOjE2MDEwMDI3MjEsImV4cCI6MTYwMTAwNjMyMSwianRpIjoiNTUzNTA4YzBjMGU3MWY3M2I1MjJiYjY1ZWRmYTE0MmJlYmU1ZmRiMCJ9.hkA7m2I80iCb5PRQJYxaRfAZ5IjeRgbICbAMHN237J_aVwm4C_mBXfSkp6tFpgqp4JqOMCI_FetqEmlXlimKDvoH1Hfd5hpJ2wmqcs9E1FsLYqQ5nv7ff4RdAHcViJQtSS4ikhTEXNn-s4JkPDNP7FZ70_30Do3A0XOJNAxqUvG-xX2xvgJ56xPAK0sN8FPY6wbhM_y0spvE9r8SDtIsodx3NClzJ9asNjFQqnsjOQjIv3C-46qzSgZQpXIn5mQZSSAzfQYsZOJHQQfQ7ECWjKSZxycCegLlF_cy4L5OtEYYC4aSyrJpmNDh0ylbPtSCaUPq9ELXY81Vc4lcxabxdg) by some pisth 

- [Stack](https://askubuntu.com/q/1077061/443958): How do I install NVIDIA and CUDA drivers into Ubuntu?


### power off scenario

Ok so it appears that I get a black screen after using nvidia drivers
and sleeping the system. System doesn't sleep in the first place, only
after using Nvidia graphics card fully. shutting down works. Clearing
the gpu and then sleeping works.


I am tempted to try the following:

1. [18.04 Screen remains blank after wake up from suspend](https://askubuntu.com/questions/1032633/18-04-screen-remains-blank-after-wake-up-from-suspend)

	- look into kernels (last resort)
	- remove gdm and go to lightdm? (see what is the differnce beween
      the two)
	- hybrid settings in bios
	- install unity-ubuntu-desktop
	- ~~nouveau.modeset=0 (but i am not even using nouveau)~~

2. [System freeze after suspend](https://askubuntu.com/questions/882843/system-freeze-after-suspend)

	- switch to lightdm
	- do I have hybrid graphics?
	
3. [suspend, hibernate issues issues with nvidia](https://forums.developer.nvidia.com/t/solved-suspend-resuming-and-wakeup-with-nvidia370-28/45282/10)

	- 5 steps to do. Maybe try this as it is from nvidia. Doens't work
      for 18 but might work for 16 I guess.
	  
  

3. 

	- remove quiet splash to see [where the error is](https://ubuntuforums.org/showthread.php?t=2329042)
	
3. other blind guesses

	- [reinstall the driver](https://askubuntu.com/q/970880/443958) (Not sure but it is in comments)
		- downgrade perhaps (really not sure if this is the direction)
		- suggestion of using 390 and 16 seems to work for [this
          guy](https://forums.developer.nvidia.com/t/problem-with-resume-from-suspend-ubuntu-16-04-gt-940mx/51410/69) (with instructions)
	- no modeset in grub screen?
	- changing kernel?
	- resetting[ monitors before sleeping](https://askubuntu.com/a/804831/443958)? `xrandr -s 0`


This is ubuntu 16 pertinent.


5. [Almost same issue](https://stackoverflow.com/questions/54393074/black-screen-after-waking-from-suspend-ubuntu-budgie-18-10)

	- change powermizer to adaptive is one solution (change it back later)
	- other unaccepted solution of the same question in [ask
      ubuntu](https://askubuntu.com/a/1114748/443958) is to change grub to something else...
	  
			GRUB_CMDLINE_LINUX_DEFAULT="quiet acpi_rev_override=1 acpi_osi=Linux scsi_mod.use_blk_mq=1 nouveau.modeset=0 nouveau.runpm=0 mem_sleep_default=deep"


6. [Updating kernel](https://forums.developer.nvidia.com/t/problem-with-resume-from-suspend-ubuntu-16-04-gt-940mx/51410/61) to 4.17?

	- update kernel to next version?
	- kernel apparently didn't do it all for [this guy](https://forums.developer.nvidia.com/t/problem-with-resume-from-suspend-ubuntu-16-04-gt-940mx/51410/69) with ubuntu
      16 and 4.15 kernel
	-[ Another user](https://forums.developer.nvidia.com/t/problem-with-resume-from-suspend-ubuntu-16-04-gt-940mx/51410/77) reporting this is not working for them :(
      kernel 4.17
	

But some one on ubuntu 16 tried updating to [4.17 but it didn't work](https://forums.developer.nvidia.com/t/problem-with-resume-from-suspend-ubuntu-16-04-gt-940mx/51410/63)

1.  considering downgrading and checking if it works with say 390?
  because another guy claims it works for him. tried 4
  
2. try lightdm? I already have lightdm. what to do?

		cat /etc/X11/default-display-manager

3. check hybrid graphics?

4. make a post


first am gonna check out lightdm vs gdm and then what is the best way
to do it.


**What I am actually doing log**


added line in grub

	GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1
	vga=0 rdblacklist=nouveau nouveau.modeset=0 "

then

	sudo update-grub

**R**: It didn't sleep even after leaving it over night.

checked if the jupyter being on is the issue. But it is not. it's
really about nvidia not sleeping when it is it is full.

Unable to turn on hibernation as that file doesn't exist.

---

Removed quite splash to see where the error is... it seems like there
is some Nvidia modeset error.

*Not sure how to proceed with it*

---

	sudo gedit /etc/initramfs-tools/modules

	nvidia
	nvidia_modeset
	nvidia_uvm
	nvidia_drm

*Getting error*:

``` Terminal
update-initramfs: Generating /boot/initrd.img-4.15.0-118-generic
W: Possible missing firmware /lib/firmware/i915/kbl_guc_ver9_14.bin for module i915
W: Possible missing firmware /lib/firmware/i915/bxt_guc_ver8_7.bin for module i915
update-initramfs: Generating /boot/initrd.img-4.15.0-117-generic
W: Possible missing firmware /lib/firmware/i915/kbl_guc_ver9_14.bin for module i915
W: Possible missing firmware /lib/firmware/i915/bxt_guc_ver8_7.bin for module i915
update-initramfs: Generating /boot/initrd.img-4.4.0-190-generic
```

> To answer your question you don't need to update drivers for a
> processor you aren't running but it is nice to see the warnings
> disappear when you do. --- [Stack](https://askubuntu.com/a/832528/443958)


--- 

**output of /var/log/kern.log**

``` log
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.6372] manager: sleep requested (sleeping: no  enabled: yes)
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.6372] manager: sleeping...
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.6374] manager: NetworkManager state is now ASLEEP
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.6377] device (wlp2s0): state change: activated -> deactivating (reason 'sleeping') [100 110 37]
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.6931] device (wlp2s0): state change: deactivating -> disconnected (reason 'sleeping') [110 30 37]
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.7269] dhcp4 (wlp2s0): canceled DHCP transaction, DHCP client pid 3957
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.7269] dhcp4 (wlp2s0): state changed bound -> done
Oct  3 02:15:36 eghx-nitro kernel: [ 1026.492808] wlp2s0: deauthenticating from e8:cc:18:41:3c:15 by local choice (Reason: 3=DEAUTH_LEAVING)
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.9415] dns-mgr: Writing DNS information to /sbin/resolvconf
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <warn>  [1601684136.9715] sup-iface[0x1f42ef0,wlp2s0]: connection disconnected (reason -3)
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.9727] device (wlp2s0): supplicant interface state: completed -> disconnected
Oct  3 02:15:36 eghx-nitro NetworkManager[3742]: <info>  [1601684136.9733] device (wlp2s0): state change: disconnected -> unmanaged (reason 'sleeping') [30 10 37]
Oct  3 02:15:37 eghx-nitro kernel: [ 1027.114951] PM: suspend entry (deep)
```

Nothing here. No error etc...


---

[Sleep](https://askubuntu.com/a/1795/443958): 

use

	systemctl suspend

also possible to use

	pm-suspend 
	
and gui options are there. Is there any difference here?

---

so the nvidia thing doesn't work.

It looks like the suspend happens but upon wake up I have a cursor on
top `ctrl-alt-f1` goes to the tty1 screen but  I can't login. It gets
stuck there. This time I uses `systemctl suspend`. `ctrl-alt-f7` to
come back to gui... but doesn't work. **It seems to get stuck at login
screen** only when nvidia is full.

---

changed powermizer settings running the program and then sleeping to
see if it works.

didn't work. :( Maybe I had to reboot? Am positive that wouldn't have
made a difference.

---

Changed to 384, now restart, and then change pytorch and all to
compatible version. 

Next look at that link and try again with complete purge.

``` Terminal
eghx@eghx-nitro:~$ dpkg --get-selections | grep nvidia
nvidia-384					install
nvidia-390					deinstall
nvidia-430					deinstall
nvidia-opencl-icd-384				install
nvidia-opencl-icd-390				deinstall
nvidia-opencl-icd-430				deinstall
nvidia-prime					install
nvidia-settings					install
```
rebooted

created new env, removed  an attempt with the old env and changing cudatoolkit

	conda create --name fastaiclean384


	conda install -c fastai -c pytorch fastai cudatoolkit=9.0 
	
	
cuda is 9.0 but pytorch	is 1.1, fastai wants 1.6.0
	
removed the ting

	conda create again
	
	conda instal with the right versions
	
doens't work results in conflicts with pytorch so moving on.

redoing it

did all the installation steps including pil stuff.

now testing

can't get fastai 2 to install I think it has to do with all the
fucking dependencies. this really sucks. 


Let's go back to **reinstalling nvidia graphics drivers of 430** and then
go one step lower and that is it.

- going to remove reinstall and configure xserver-xorg

- and then purge and reinstall the nvidia graphic card and test. 

- probably my laatste try.

- and maybe try considering a smaller version of nvidia 410 or something?
 
- and ~~maybe kernel~~ resetting monitors beofre sleeping 

- check grub once again and what commands it should have?

- should I remove the grub stuff and initramfs-tools stuff I added?

0 and maybe 
Remove existing xorg using the following command

sudo apt-get remove --purge xserver-xorg

sudo apt-get install xserver-xorg


sudo dpkg-reconfigure xserver-xorg

can't find any of this ...


	sudo apt-get purge nvidia*  

can't access the additional drivers tab

	sudo apt remove nvidia-*  
	sudo apt autoremove  

ubuntu-drivers devices

rebooting all additional drivers greyed out

R: second screen doesn't work.

	sudo ubuntu-drivers autoinstall
	
rebooting...


computer went into non bootable mode

	added nomodeset
	
went into boot login loop

	checked permissions of Xauthority file
	
	checked permission of tmp file
	
	removed the old grub stuff that I added from nvidia site
	
	same thing with infirams or something
	
	updated them
	
	purged and reinstalled lightdm too
	
but to no avail.
	
The one that worked was to:

	prime select intel
	
fucking hell.	currently I have 430 installed and additional dirvers
seems to be working.

GPU NOT BEING USED

test if gpu is even working? before changing stuff in xorg.conf and
going back to nvidia
	
suspicion xorg.conf is fucking things up... there was no xorg.conf
file first. Considering copying the same file from earlier today into
the system and replacing current xorg.conf.

computer seems extremely slow on intel g card....

	adding export to ld path also not doing working the gpu.

Start here... change to nvidia and change the xorg settings and then start?

https://askubuntu.com/questions/217758/how-to-make-an-xorg-conf-file

start here. I don't know man...


slept the computer and then blank screen


what solved it ?

	noveau.modeset=0
	
Plan to use this link go to tty... reinstall everything including
drivers, xorg, etc...

before that need to know if I can even install xserver


**What is x-server? X11 Xclient**

https://medium.com/mindorks/x-server-client-what-the-hell-305bd0dc857f

https://askubuntu.com/a/264411/443958

Graphical interface/ Display manager:  Unity, Gnome

Protocol between GI and DS: X11, wayland etc...

Display Server: Xorg | window manager: Compiz (resize or postion
window, close minimize etc...)


xorg packages :
https://packages.ubuntu.com/search?keywords=xserver-xorg

why are there so many... Is it safe to purge 215 people have upvoted
this thing... Let's try.

1. purge nvidia 

2. reinstall nvidia

**Should we use purge or remove --purge or remove**

https://askubuntu.com/a/231565/443958




### deprecated?

**Option 1? (this is for 18.04 though)**

**S:** My situation is different though

[18.04 Screen remains blank after wake up from suspend](https://askubuntu.com/q/1032633/443958)

> i updated the kernal to v4.17 and it solve this issue.

check stable kernel and see if you can use it?

There are a bunch of solutions to try here. Maybe that is the way to
go. They are not too intrusive like too many steps or
something... Simple reinstalls I don't mind doing. Hopefully that
doens't screw up the system.

**Option 1.1?**

Something to do with noveau driver apparently. But I thought I wasn't
even using it!

**Option 2? No real source**

I am thinking maybe the nvidia prime select change fucked it up so
maybe reinstall nvidia drivers? purge and come back?

reinstallin might involve grub screen blacking out and then resulting
in `nomodeset` which I might need to add.

**Option 3**

## Lesson 1


1. [x] Let's setup a gpu online first: https://course.fast.ai/start_gradient

2. [ ] Look for GPU usage on PC: https://forums.fast.ai/t/wiki-thread-lesson-1/6825

### Resources

- [Lesson wiki](https://forums.fast.ai/t/wiki-thread-lesson-1/6825)

- [course notes](https://medium.com/@hiromi_suenaga/machine-learning-1-lesson-1-84a1dc2b5236) by someone on medium

### Jupiter

- Jupiter with crestle 
- aws or PC
- paperspace (have )

### Jupyter in emacs

https://tkf.github.io/emacs-ipython-notebook/

### todo

setup jupyter on emacs and browser to see how different it is....

- clone fast ai [repo](https://github.com/fastai/fastai), instructions on website... 

finish this course lecture 1 atleast. seeing it

- followed by assignmets

- **figure out how to use fast ai (pc or aws or whatever) with
  jupyter**

## Other useful links

[Managing your data science project environments with Conda](https://towardsdatascience.com/managing-project-specific-environments-with-conda-406365a539ab)

## Question

**Ubuntu 16 does not sleep/wakeup after GPU is used**

On normal occasions when xorg and compiz is running in my gpu, I can
sleep and no issues. However if I run some training in deeplearning
(fastai, pytorch stuff), and subsequently suspend, it refuses to
sleep/wakeup.

It sort-of sleeps but I still hear some sound from the laptop. But
when I hit a key it sounds as if it is booting up. 

It shows a cursor on the left top which goes into tty screen upon
ctrl-alt-F1 but I can't type anything there.

**What I did?**


1. 
