# dumb #

_dumb_ is a simple tool for emulating a [dumb terminal](http://en.wikipedia.org/wiki/Computer_terminal#Dumb_terminal) in [Linux](http://en.wikipedia.org/wiki/Linux) by stripping out valid [control sequences](http://www.xfree86.org/current/ctlseqs.html).

**What is a dumb terminal?**

A smart terminal is a [command-line interface](http://en.wikipedia.org/wiki/Commandline) that supports rich features such as formatting, color text, and cursor repositioning. All modern command-lines use [terminal emulators](http://en.wikipedia.org/wiki/Terminal_emulator) which are smart. By contrast, a dumb terminal is only able to print simple [ASCII characters](http://en.wikipedia.org/wiki/Ascii), nothing else. Smart terminals work by adding non-printable [control characters](http://en.wikipedia.org/wiki/Control_character) and [escape sequences](http://en.wikipedia.org/wiki/Escape_sequence) which are [embedded within the output](http://en.wikipedia.org/wiki/In-band_signaling) to control those extra features.

_dumb_ strips off all of the valid control characters and escape sequences it finds, producing simple output fit for a dumb terminal.

**Wait a minute, can't I just use a quick (perl|python|sed) one-liner to do this?**

Probably, but I've never seen anyone get it right. When considering a [regex](http://en.wikipedia.org/wiki/Regular_expression) one-liner for this particular task, keep in mind:

* It's probably more complex than most people will want to remember.
* It probably won't match everything.
* It probably will match some stuff that it shouldn't.
* It will be slower than this tool when handling large inputs.

**Holy hell, why did you write this in Lex?!**

It seemed like it would be fun. Also it's faster, and Lex lends itself to this sort of problem quite well.

**Ok, but why did you need to write this at all?**

I needed a forensic tool that would strip off known valid control sequences, but leave behind non-valid binary garbage for further analysis. I didn't find any tools that could do that, so I wrote this one.

(Secretly, I'm hoping to turn my nickname of "that _dumb_ Linux guy" into something positive.)

## Usage ##

_dumb_ reads input on stdin and prints the stripped output to stdout. It has no switches and takes no arguments.

## Examples ##

Here is a simple example:

(Sorry, but I've been unable to convince Github's flavor of Markdown to properly display color text.)

<pre><code>empty@monkey:/usr/games$ ls -l --color
total 24
-rwxr-xr-x 1 root root 22240 Sep 30  2009 <span style="color:#00ff00">fortune</span>
lrwxrwxrwx 1 root root    25 Mar  6 17:36 <span style="color:#00ffff">nethack</span> -> <span style="color:#00ff00">/etc/alternatives/nethack</span>
lrwxrwxrwx 1 root root    39 Mar  6 17:36 <span style="color:#00ffff">nethack-console</span> -> <span style="color:#00ff00">../lib/games/nethack/nethack-console.sh</span>

empty@monkey:/usr/games$ ls -l --color | dumb 
total 24
-rwxr-xr-x 1 root root 22240 Sep 30  2009 fortune
lrwxrwxrwx 1 root root    25 Mar  6 17:36 nethack -> /etc/alternatives/nethack
lrwxrwxrwx 1 root root    39 Mar  6 17:36 nethack-console -> ../lib/games/nethack/nethack-console.sh</code></pre>


Here, we demonstrate the character stripping by piping the output through xxd:

	empty@monkey:/usr/games$ ls -l --color | xxd
	0000000: 746f 7461 6c20 3234 0a2d 7277 7872 2d78  total 24.-rwxr-x
	0000010: 722d 7820 3120 726f 6f74 2072 6f6f 7420  r-x 1 root root 
	0000020: 3232 3234 3020 5365 7020 3330 2020 3230  22240 Sep 30  20
	0000030: 3039 201b 5b30 6d1b 5b30 313b 3332 6d66  09 .[0m.[01;32mf
	0000040: 6f72 7475 6e65 1b5b 306d 0a6c 7277 7872  ortune.[0m.lrwxr
	0000050: 7778 7277 7820 3120 726f 6f74 2072 6f6f  wxrwx 1 root roo
	0000060: 7420 2020 2032 3520 4d61 7220 2036 2031  t    25 Mar  6 1
	0000070: 373a 3336 201b 5b30 313b 3336 6d6e 6574  7:36 .[01;36mnet
	0000080: 6861 636b 1b5b 306d 202d 3e20 1b5b 3031  hack.[0m -> .[01
	0000090: 3b33 326d 2f65 7463 2f61 6c74 6572 6e61  ;32m/etc/alterna
	00000a0: 7469 7665 732f 6e65 7468 6163 6b1b 5b30  tives/nethack.[0
	00000b0: 6d0a 6c72 7778 7277 7872 7778 2031 2072  m.lrwxrwxrwx 1 r
	00000c0: 6f6f 7420 726f 6f74 2020 2020 3339 204d  oot root    39 M
	00000d0: 6172 2020 3620 3137 3a33 3620 1b5b 3031  ar  6 17:36 .[01
	00000e0: 3b33 366d 6e65 7468 6163 6b2d 636f 6e73  ;36mnethack-cons
	00000f0: 6f6c 651b 5b30 6d20 2d3e 201b 5b30 313b  ole.[0m -> .[01;
	0000100: 3332 6d2e 2e2f 6c69 622f 6761 6d65 732f  32m../lib/games/
	0000110: 6e65 7468 6163 6b2f 6e65 7468 6163 6b2d  nethack/nethack-
	0000120: 636f 6e73 6f6c 652e 7368 1b5b 306d 0a    console.sh.[0m.
	
	empty@monkey:/usr/games$ ls -l --color | dumb | xxd
	0000000: 746f 7461 6c20 3234 0a2d 7277 7872 2d78  total 24.-rwxr-x
	0000010: 722d 7820 3120 726f 6f74 2072 6f6f 7420  r-x 1 root root 
	0000020: 3232 3234 3020 5365 7020 3330 2020 3230  22240 Sep 30  20
	0000030: 3039 2066 6f72 7475 6e65 0a6c 7277 7872  09 fortune.lrwxr
	0000040: 7778 7277 7820 3120 726f 6f74 2072 6f6f  wxrwx 1 root roo
	0000050: 7420 2020 2032 3520 4d61 7220 2036 2031  t    25 Mar  6 1
	0000060: 373a 3336 206e 6574 6861 636b 202d 3e20  7:36 nethack -> 
	0000070: 2f65 7463 2f61 6c74 6572 6e61 7469 7665  /etc/alternative
	0000080: 732f 6e65 7468 6163 6b0a 6c72 7778 7277  s/nethack.lrwxrw
	0000090: 7872 7778 2031 2072 6f6f 7420 726f 6f74  xrwx 1 root root
	00000a0: 2020 2020 3339 204d 6172 2020 3620 3137      39 Mar  6 17
	00000b0: 3a33 3620 6e65 7468 6163 6b2d 636f 6e73  :36 nethack-cons
	00000c0: 6f6c 6520 2d3e 202e 2e2f 6c69 622f 6761  ole -> ../lib/ga
	00000d0: 6d65 732f 6e65 7468 6163 6b2f 6e65 7468  mes/nethack/neth
	00000e0: 6163 6b2d 636f 6e73 6f6c 652e 7368 0a    ack-console.sh.
	
## Installation ##

	git clone https://github.com/emptymonkey/dumb.git
	cd dumb
	make

