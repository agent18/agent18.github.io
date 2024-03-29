---
layout: post
comments: true
title:  "Python and Emacs setup"
date:    13-06-2020
categories: notes
permalink: /:title.html
---


## Summary:

**Terminal**

`which python` to know where it is pointing to in terminal

`base` is the environment  which means it has a particular python and
a particular set of libraries.

`conda activate base`

**Emacs**

environment `base` given in init file with:   

	(setq python-shell-interpreter "/home/eghx/anaconda3/bin/ipython")

`M-x run-python` seems to open an ipython console which works


`sys.version` and `sys.prefix` in python to check which "environment"
is installed.


While installing python libraries such as `learntools`, as long as we
install (`conda install scipy`, look below on how to install non-conda
libraries) it in the `base` environment in the terminal (`source
anaconda3/bin/activate` or `conda activate base`), then it seems to be
**available in EMACS too**. :)

## Installing pythiath

Rumor has it that anaconda is the shiz and the "best" way to work with
python. I am comfortable with it

## Installing Anaconda

> Anaconda® is a **package manager**, an environment manager, a Python/R
> data science distribution, and a collection of over 7,500+
> open-source packages. Anaconda is free and easy to install, and it
> offers free community support.

- Check which python is used, [if Anaconda is installed](https://docs.anaconda.com/anaconda/user-guide/tasks/integration/python-path/)

		which python

- [installing anacoda](https://docs.anaconda.com/anaconda/install/linux/) as per the website

	Don't know what this is but did it anyway. ["Verification of
    install file"](https://askubuntu.com/questions/1189769/sha256sum-path-filename-no-such-file-or-directory)
	
		sha256sum ~/Downloads/Anaconda3-xxxx.xx-Linux-x86_64.sh

	Download anaconda x86 and python 3.5 linux xxxx.xx. ~~I added
    [sudo](https://askubuntu.com/a/887558/443958).~~ But I suspect maybe that was causing some
    issues. Website doesn't say sudo. Non sudo version seems to have
    `conda update conda` working while I am still in the base.
	
		sudo bash ~/Downloads/Anaconda3-xxxx.xx-Linux-x86_64.sh		
		
		bash ~/Downloads/Anaconda3-xxxx.xx-Linux-x86_64.sh		
		
	Say yes to all.

	`(base) $eghx@eghxnitro` start appearing as opposed to the regular
    thing on the terminal. 
	
		conda config --set auto_activate_base False
		
	close and open terminal and the `(base)` is gone.
	
	
	Verify your install using:
	
		conda list #Lists all packages in the current ENV
		
	Select env `base`
	
		source anaconda3/bin/activate 
		
	Type `python` and see with `sys.prefix` where this python leads to.
		
	
## What is `(base)` (MORE INFO)
 
It points to the python environment "selected"(`which python`) i.e.,
Anacondas's, explicitly in the terminal. Use the following to see
which python is alive (e.g., anaconda or default installation etc.)

> Switching from the (base) to the deactivated (base) implies
> switching from one python interpreter to another one - that may be
> checked using which.---[stack](https://stackoverflow.com/a/55134732/5986651)



`(base)` is a python environment currently pointing to the anaconda
installation.

- de-activating the `base` env

		conda deactivate

- Activating the `base` env

		source anaconda3/bin/activate 
		
- Currently the above is activated by default thanks to the following
  lines in you `.bashrc`


**Verdict**

It's ugly to have it in the terminal. Then,
- deactivate and risk the chance of using another python by mistake when working
- & have to activate every single time.

If you don't want to activate it every single time and permanently
modify where `which python` points to? Then you can do it by changing
the `PATH` variable as shown [in this stack answer](https://stackoverflow.com/a/55134899/5986651). But this is
[*Discouraged*](https://stackoverflow.com/a/55134899/5986651) as per "conda release notes".
	
This [video](https://www.youtube.com/watch?v=nnhjvHYRsmM) was the most useful. Other links from
[stack1](https://stackoverflow.com/questions/55134440/in-conda-what-is-the-differece-between-base-environment-and-no-environment-at). Other links from [stack 2](https://stackoverflow.com/questions/55133808/with-conda-anaconda-should-i-work-in-base-all-the-time).

I DON'T use pythiath on the terminal. So I will *deactivate it PERMANENTLY*. I use
it in EMACS and when that happens I will `setq`. (Look at the
caution. I think we are gonna have some problems).

	conda config --set auto_activate_base false

**Caution:**

Changing where the default python is looking at in say EMACS might
have other consequences.

> It may not see packages that you have installed in the base
> environment, but it sees libraries that you installed with
> anaconda. Different environments serve to isolate dependencies
> installed.---[stack comment](https://stackoverflow.com/a/55134732/5986651)

Figure out with time...

## Python to Ipython  on terminal and Emacs

> IPython is basically the "recommended" Python shell, which provides
> extra features. There is no language called IPython.---[stack](https://stackoverflow.com/a/41971819/5986651)

- how to make it work with emacs

- there seem to be some variables which have access to it.
	
`conda list` already shows `ipython` package already installed.

So in the normal terminal when the `base` env is not turned on, then
you don't get the `python` you want. Needless to say even `ipython`
doesn't work there. But once you toin on `base` using `source
 anaconda3/bin/activate` then 'alles sier goed'.
 
 If situation forces you to action, do the following, but it didn't
 work for me as per [ipython's site](https://ipython.org/install.html).
 
	conda update conda
	conda update ipython	
	
or as per another [stack comment](https://stackoverflow.com/questions/29341708/anaconda-ipython-not-running)	
	
	conda update conda
	conda update ipython ipython-notebook ipython-qtconsole
	
	
Ipython help is give [here](https://ipython.readthedocs.io/en/stable/interactive/tutorial.html). There are magic functions, tab
completion things and some shortcut commands that could be used here.

**IPython in emacs has many features that don't work** 

Had some issues such as the console behaving wierd! with
many letters shown inplace of one.

Finally was able to solve it after many many hours of relentless
debugging and emacs stack had the answer anyways. :)

**Error** I got was similar garbled (wierd) text when I opened IPYTHON
with `C-c C-p` on my simple python file `print("hello World")`.

    ppppprrrrriiiiinnnnnttttt((((("""""HHHHHeeeeellllllllllooooo     
    WWWWWooooorrrrrlllllddddd""""")))))))))))))))
    Hello World

**Solution** verbatim as per [@ricardoLima's answer][1] didn't work
for me. I had to re-write it as follows.

    (setq python-shell-interpreter "/path/to/bin/ipython")
    (setq python-shell-interpreter-args "--simple-prompt -i")

**TIP:**

Just use `emacs -q` in the terminal to open a no-init emacs and run
these commands with `M-:`. `M-x run-python` and you are good to go.

**P.S.**  
Emacs: "This is GNU Emacs 25.3.2 (x86_64-pc-linux-gnu, GTK+ Version 3.18.9)
 of 2019-12-24"  
Ubuntu: 16.04  
python and Ipython from Anaconda  
Python: 3.7.6  
IPython:  7.12.0  


  [1]: https://emacs.stackexchange.com/a/24572/17941

## Checking setup with EMACS

Ask emacs to look at the right python, [use code](https://stackoverflow.com/a/49807116/5986651) and add to emacs
init file:

	(setq python-shell-interpreter "/path/to/python")

Ask emacs to run a python shell, [use code](https://stackoverflow.com/a/50242869/5986651):

	M-x run-python

interpreter ipython python shell python interpreter???


what is interpreter

	sys.version

To see which python your interpreter is using, [use code](https://stackoverflow.com/a/53952253/5986651): 

	sys.prefix
	
## conda not working (uninstall and re-install is the only way!)

Error on `conda update conda`

``` bash
Collecting package metadata (current_repodata.json): failed

NotWritableError: The current user does not have write permissions to a required path.
  path: /home/eghx/.conda/pkgs/urls.txt
  uid: 1000
  gid: 1000

If you feel that permissions on this path are set incorrectly, you can manually
change them by executing

  $ sudo chown 1000:1000 /home/eghx/.conda/pkgs/urls.txt

In general, it's not advisable to use 'sudo conda'.

```

https://github.com/conda/conda/issues/9004#issuecomment-517955252

	conda config --set allow_conda_downgrades true
	conda install conda=4.6.14

Not working same error

**JUST UNINTSALL AND FOLLOW INSTALLION PROCEDURE AGAIN**


## Uninstalling/re-installing anaconda

https://docs.anaconda.com/anaconda/install/uninstall/

The following didn't work

	conda install anaconda-clean 

So I ended up following the stack answer from 2016 about removal of
all folders and the contents in the `.bashrc`
file. https://stackoverflow.com/a/40159908/5986651


	sudo rm -rf ~/anaconda3
	sudo rm -rf ~/.condarc ~/.conda ~/.continuum

*I think I needed to use SUDO because I used it in the
installation*. I am going to test it and not use any fucking
sudo. Let's see.


## Installing packages with Conda

https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-pkgs.html#searching-for-packages

Check if package exists,

	conda list
	
	conda list numpy

To check if package exists,

	conda search scipy curl
	
Install package from search using `conda install ...`

Packages are available with `conda search` are from `conda`. Packages
are also available at `anaconda.org`. If packages (such as `learntool`
for Kaggle) are not available in both `conda` or `anaconda.org`, then
they are `non-conda` packages.
### Installing packages with conda install

[Fastai man page](https://github.com/fastai/fastai):

	conda install -c fastai -c pytorch -c anaconda fastai 

Can also be done (it appears) with the github link and then `environment.yml`: 

	git clone https://github.com/fastai/fastai2
	cd fastai2
	conda env create -f environment.yml
	source activate fastai2

With[ pip](https://forums.fast.ai/t/platform-local-server-ubuntu/65851/22?u=thetj09):

	git clone https://github.com/fastai/fastai2
	cd fastai2
	pip install -e ".[dev]"
	
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

### Installing non-conda packages

Packages are also available at `anaconda.org`. If packages (such as
`learntool` for Kaggle) are not available in both `conda` or
`anaconda.org`, then they are `non-conda` packages.

If not available in all of the above, `conda/pip install
link-to-tar.gz` (in the base or respective environment) is still an
option.

In the case of `learntools` none of that works. So downloaded the repo
to pkgs. `cd` into the downloaded unzipped folder. `activate` the base and then,

	python setup.py install

[Source](https://stackoverflow.com/questions/36164986/how-to-install-package-in-anaconda).

And now it is available to emacs. It appears that the packages are
tied to the `python` selected. That seems good. :) Pandian le

### Installing packages with Anaconda

https://stackoverflow.com/questions/28741563/pytesseract-no-such-file-or-directory-error/49762616#49762616



### Installing dependencies so that opencv works without the following error

>error: /io/opencv/modules/highgui/src/window.cpp:583: error: (-2) The
>function is not implemented. Rebuild the library with Windows, GTK+
>2.x or Carbon support. If you are on Ubuntu or Debian, install
>libgtk2.0-dev and pkg-config, then re-run cmake or configure script
>in function cvShowImage

https://www.pyimagesearch.com/2015/06/22/install-opencv-3-0-and-python-2-7-on-ubuntu/


### Working with emacs

https://stackoverflow.com/q/49805906/5986651

## Understanding environments

Every environment seems to have it's own python and packages.

[Conda help on environments](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)

**Create** environment: `conda create -n myenv python=3.6`

**Clone** environment: `conda create --name fastai --clone base`

**add packages** to environment: `conda install -n myenv scipy` (or go to
environment and just `conda install ipthon` for example)

**activate conda env**: `conda activate myenv`  (you will see a `(myenv)`
in front in the terminal)

**List packages** in environment: Go to environment and then `conda list`

**How to work on a particular environment in Emacs?**

0. Create environment  myenv

1. install necessary packages

2. Modify init file or `M-:` with right link to python or shell
   interpreter obtainable from `which python` e.g., `(setq python-shell-interpreter
   "/home/eghx/anaconda3/bin/ipython")`

3. Test

Really simple.

Delete environment: `conda env remove --name myenv` or `conda remove
--name myenv --all`

Check if deleted: `conda info --envs`



Great so far so good.

### conda install with environment.yml

	conda env create -f environment.yml
	conda activate EnvironmentName


	conda env update -f environment.yml
	conda activate EnvironmentName


Source:
https://stackoverflow.com/questions/40616381/can-i-add-a-channel-to-a-specific-conda-environment



## future things

- show commands for example **`np.` should show available commands**
- commands jump from one to the console and back

auto complete variables and commands

help for commands

ipython magic

specify environment etc... next...

syntax checking

More to dos here.
https://www.seas.upenn.edu/~chaoliu/2017/09/01/python-programming-in-emacs/

https://gist.github.com/widdowquinn/987164746810f4e8b88402628b387d39

https://steelkiwi.com/blog/emacs-configuration-working-python/

https://www.emacswiki.org/emacs/PythonProgrammingInEmacs


	
## Jupyter notebook it is

**epistemic status:** I think jupyter was installed with the base already?
but I checked right? As spyder is already.

Some discussion on Jupyterlab vs Jupyter on [stack](https://stackoverflow.com/questions/50982686/what-is-the-difference-between-jupyter-notebook-and-jupyterlab). Jupyterlab has
it's own editor with "emacs keybindings". But I am using jupyter
notebook and the support for keybindings is shit. Atleast someone
switched back to Jupyter notebook and people advising beginners to go
to Jupyter notebook.

**Conda installation**

	conda install -c conda-forge notebook

This directly installs jupiter in the `base` env as that is the one
that is active.

**Start Jupyter**

	conda activate base
	
	jupyter notebook
	
## EIN

https://www.youtube.com/watch?v=OB9vFu9Za8w

Legend John miller is managing the EIN package (Emacs IPython
Notebook)

There is auto completion done with `Jedi` package by looking in kernel
and jedi.

There is `auto-complete` and `company`, but what he shows here really
works with `auto-complete`

- poca altrair vega wont work as they us javascript

### EIN docs

https://github.com/millejoh/emacs-ipython-notebook

### EIN setup

Changed variable value in init file and restarted emacs

	(ein:jupyter-default-server-command "/home/pandian/miniconda3/bin/jupyter")

`ein:run` starts the notebook.

Set the following up (present in the [readme](https://github.com/millejoh/emacs-ipython-notebook)) otherwise **inline** images don't work:

> Ein Output Area Inlined Images: Toggle  on (non-nil)
>     State : SAVED and set.
>    Turn on to insert images into buffer.  Default spawns external viewer.

**auto-complete**

Added jedi to list of packages. And the following:

``` lisp
;; jedi mode connecting with ein
(setq ein:completion-backend 'ein:use-ac-jedi-backend)

;; http://tkf.github.io/emacs-jedi/latest/
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional
```

**JEDI setup**

http://tkf.github.io/emacs-jedi/latest/#quick-start

Shows steps to do. This also requires the path to `virtualenv`. First
install:
	
	conda install virtualenv

so add to init file `custom-set-variables`

	'(jedi:environment-virtualenv '("~/miniconda3/bin/virtualenv"))

When I tested on a new system it works on py files but not in the
ipynb file. So not sure how to go about it. For now I will stop here.

**code folding**

As done here is done through ob-ein it looks like. I am not sure. I
have mailed the author for a response.

https://github.com/millejoh/emacs-ipython-notebook/issues/585

https://emacs.stackexchange.com/questions/40489/collapse-input-cell-in-ein

### Setting keybindings for ein

https://github.com/millejoh/emacs-ipython-notebook/issues/174#issuecomment-927278781

https://github.com/millejoh/emacs-ipython-notebook/issues/174#issuecomment-927326233

``` lisp
(use-package ein-notebook
  :bind (:map ein:notebook-mode-map
	      ("C-c C-d" . ein:worksheet-delete-cell)
	      ("C-c C-x C-a" . ein:worksheet-execute-all-cells-above)
	      ("C-c C-x C-b" . ein:worksheet-execute-all-cells-below)
	      ))
```
		  
### Jedi help

I think it is clear that `virtualenv` is missing. So you need to do
just two things. With this way don't bother with PATH variable and all
that. 

1. install `virtualenv` (I use `conda` package manager for everything
   python related) in your terminal perhaps

		conda activate yourenv
	
		conda install virtualenv
		
		conda list virtualenv #check if virtualenv is actually installed
	
2. and then show `jedi` where `virtualenv` is

`C-h v jedi:environment-virtualenv "~/path-to-conda-env/bin/virtualenv")`

For more help look in the [documentation](http://tkf.github.io/emacs-jedi/latest/#configuration) in `Configuration` or
comment below.

3. `M-x jedi:install-server`
   
4. Test on a `.py` file.

### Configure external image viewer

Look [here](https://github.com/millejoh/emacs-ipython-notebook#faq). Why I have to look in the FAQ? It is what it is.

There is an example, that if you read multiple times, you will know
how to make the puzzle.

[mailcap](https://www.gnu.org/software/emacs/manual/html_node/emacs-mime/mailcap.html) is a file parsed, which has some settings for how the
image, sound, word anything, should be processed, which viewer it
should open etc.

e.g., 

``` lisp
image/*; gimp -8 %s
audio/wav; wavplayer %s
application/msword; catdoc %s ; copiousoutput ; nametemplate=%s.doc
```

This says that all image files should be displayed with gimp, that
WAVE audio files should be played by wavplayer, and that MS-WORD files
should be inlined by catdoc.


**coming to the acutal configurations**

According to https://github.com/millejoh/emacs-ipython-notebook#faq,
we need to do the following.

`M-x customize-group RET mailcap
Mailcap User Mime Data`

Once inside, 

Change `Choice` to `Shell Command`. Type there: `convert %s
-background white -alpha remove -alpha off - | display
-immutable`. Last part is to change: `Mime type:` to `image/png`.

this will produce images in white background instead of the checkerboard
pattern. :) 

or add this to the customize able variable: ` '(mailcap-user-mime-data
'(("convert %s -background white -alpha remove -alpha off - | display
-immutable" "image/png" nil)))`

### shorten pandas output


### Ein keybindings

Docs:
http://millejoh.github.io/emacs-ipython-notebook/#running-a-jupyter-notebook-server-from-emacs

**Execute Restart**  
C-c C-c ein:**worksheet-execute-cell**  
M-RET ein:worksheet-execute-cell-and-goto-next  
M-S-return ein:worksheet-execute-cell-and-insert-below  

C-c C-/ ein:notebook-scratchsheet-open  
C-c ! ein:worksheet-rename-sheet  

C-c C-x C-r ein:notebook-restart-session-command  
C-c C-r ein:notebook-reconnect-session-command  
C-c C-z ein:notebook-kernel-interrupt-command  

function (ein:worksheet-execute-all-cell ws)  
Execute all cells in the current worksheet buffer.  


**Executing above below and delete**

``` lisp
;; http://millejoh.github.io/emacs-ipython-notebook/#commands-keybinds
(define-key ein:notebook-mode-map "\C-c\C-d"
  'ein:worksheet-delete-cell)

(define-key ein:notebook-mode-map "\C-c\C-x\C-a"
  'ein:worksheet-execute-all-cells-above)

(define-key ein:notebook-mode-map "\C-c\C-x\C-b"
  'ein:worksheet-execute-all-cells-below)
```

**Output manipulation**  
C-c C-e ein:**worksheet-toggle-output**  
C-c C-l ein:worksheet-clear-output  
C-c C-S-l ein:worksheet-clear-all-output  

C-c C-; ein:shared-output-show-code-cell-at-point (to be done in
output, and it will go to the code cell in another buffer)  

C-c C-$ ein:tb-show (**traceback** in another buffer)  

**Basic movement**  

C-c C-n ein:worksheet-**goto-next**-input  
C-c C-p ein:worksheet-**goto-prev**-input  
\<C-up\> ein:worksheet-goto-prev-input  
<C-down\> ein:worksheet-goto-next-input  

C-c <up> ein:worksheet-**move-cell-up**  
C-c <down> ein:worksheet-move-cell-down  
\<M-up> ein:worksheet-move-cell-up  
\<M-down> ein:worksheet-move-cell-down  

**Cell manipulation**  
C-c C-k ein:worksheet-**kill**-cell  
C-c M-w ein:worksheet-copy-cell  
C-c C-w ein:worksheet-**copy**-cell  
C-c C-y ein:worksheet-**yank**-cell  

C-c C-a ein:worksheet-insert-cell-above  
C-c C-b ein:worksheet-insert-cell-below  

C-c C-t ein:worksheet-**toggle**-cell-type  
C-c C-u ein:worksheet-change-cell-type   

C-c C-s ein:worksheet-**split**-cell-at-point  
C-c C-m ein:worksheet-**merge**-cell  

C-c C-h ein:pytools-request-tooltip-or-**help** buffer with
keybindings  

~~C-c C-i ein:completer-complete~~
~~C-c C-x C-l ein:notebook-toggle-latex-fragment~~

**Notebook restart quit open**  

C-c C-x C-r ein:notebook-restart-session-command  
C-c C-r ein:notebook-reconnect-session-command  
C-c C-z ein:notebook-kernel-interrupt-command  
C-c C-q ein:notebook-kill-kernel-then-close-command  
C-c C-# ein:notebook-close  
C-c C-f ein:file-open  
C-c C-o ein:notebook-open  
 
C-x C-w ein:notebook-rename-command  

**Not working**  

C-c C-. ein:pytools-jump-to-source-command  
Jump to the source code of the object at point. When the prefix
argument ‘‘C-u‘‘ is given, open the source code in the other
window. You can explicitly specify the object by selecting it.  

C-c C-, ein:pytools-jump-back-command  
Go back to the point where
‘ein:pytools-jump-to-source-command’ is executed last time. When the
prefix argument ‘‘C-u‘‘ is given, open the last point in the other
window.  

M-. ein:pytools-jump-to-source-command  
Jump to the source code of the
object at point. When the prefix argument ‘‘C-u‘‘ is given, open the
source code in the other window. You can explicitly specify the object
by selecting it.  

M-, ein:pytools-jump-back-command  
Go back to the point where ‘ein:pytools-jump-to-source-command’ is
executed last time. When the prefix argument ‘‘C-u‘‘ is given, open
the last point in the other window.  

**Other**  

function (ein:notebook-create-checkpoint notebook)  
Create checkpoint for current notebook based on most recent save.  

function (ein:notebook-restore-to-checkpoint notebook checkpoint)  
Restore notebook to previous checkpoint saved on the Jupyter  
server. Note that if there are multiple checkpoints the user will be
prompted on which one to use.  

function (ein:notebook-enable-autosaves notebook)  
Enable automatic, periodic saving for notebook.  

function (ein:notebook-disable-autosaves notebook)  
Disable automatic, periodic saving for current notebook.  

### todo

  * [ ] Test organization integration
  * [x] EIN docs? how to?  
  * [ ] connected buffer keybindings  
  * [ ] advanced buffer keybindings  
  * [x] install ein,  
  * [x] run the command to open jupyter  
  * [ ] color is all black white?  
  * [x] configure the paths needed to jupyter etc  
  * [x] check plot commands  
  * [ ] check how to get jedi autocompletion to work?  
  * [ ] how to go to docs? popus 32:00  
  * [ ] go into traceback  
  * [x] folding?  
  * [x] and jump to file  
  * [ ] using magic commands such as %load  
  * [ ] buffer and notebook share kernel  
  * [ ] buffer also has auto completion and all that shabang  
  * [ ] Why is elpy not instatlling? ?? follow this tutorial  
  https://www.youtube.com/watch?v=mflvdXKyA_g  
  * [ ] line scrolling behaving like fucking excel  
  https://www.reddit.com/r/emacs/comments/8sw3r0/finally_scrolling_over_large_images_with_pixel/
  https://emacs.stackexchange.com/questions/10354/smooth-mouse-scroll-for-inline-images  
  * [ ] Save images directly (mentioned here:  
        http://millejoh.github.io/emacs-ipython-notebook/#org-mode-integration-ob-ein)  

Doesn't look like folding is possible unless I use it in organization  
:( https://github.com/millejoh/emacs-ipython-notebook/issues/585  

or consider looking at   
