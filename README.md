# dumb #
A simple tool for emulating a [dumb terminal](http://en.wikipedia.org/wiki/Computer_terminal#Dumb_terminal) in Linux by stripping any [control sequences](http://www.xfree86.org/current/ctlseqs.html) from the given output.

---

#### What? ####

A smart terminal is a [command-line interface](http://en.wikipedia.org/wiki/Commandline) that supports rich features such as formatting, color text, and cursor repositioning. All modern Linux command-lines use [terminal emulators](http://en.wikipedia.org/wiki/Terminal_emulator) which are smart. By contrast, a dumb terminal is only able print simple [ASCII characters](http://en.wikipedia.org/wiki/Ascii), nothing else. Smart terminals work by adding non-printable [control characters](http://en.wikipedia.org/wiki/Control_character) and [escape sequences](http://en.wikipedia.org/wiki/Escape_sequence) which are [embedded within the output](http://en.wikipedia.org/wiki/In-band_signaling) to control those extra features.

This tool strips off all of the valid control characters and escape sequences it finds, producing simple output fit for a dumb terminal.

#### Wait a minute, can't I just use a quick (perl|python|sed) one-liner to do this? ####
Probably, but I've never seen anyone get it right. When considering a [regex](http://en.wikipedia.org/wiki/Regular_expression) one-liner, keep in mind:

* It's probably more complex than most people will want to remember.
* It probably won't match everything.
* It probably will match some stuff that it shouldn't.
* It will be slower than this tool when handling large inputs.


#### Holy hell, why did you write this in Lex?! ####
It seemed like it would be fun. Also it's faster, and Lex lends itself to this sort of problem quite well.

#### Ok, but why did you write this at all? ####
I needed a tool for use in forensic analysis that would strip off known valid control sequences, but leave behind non-valid binary garbage for further analysis. I didn't find any tools that could do that, so I wrote this one.

Secretly, I'm hoping the tool becomes popular so that when people point at me and say "Hey, you're that dumb Linux guy!", I can smile and say "Yes! Yes I am!"

---
### Examples ###

    empty@monkey:~$ ls --color /usr/lib/games/nethack/ | xxd
    0000000: 1b5b 306d 1b5b 3031 3b33 326d 6467 6e5f  .[0m.[01;32mdgn_
    0000010: 636f 6d70 1b5b 306d 0a1b 5b30 313b 3332  comp.[0m..[01;32
    0000020: 6d64 6c62 1b5b 306d 0a68 680a 1b5b 3031  mdlb.[0m.hh..[01
    0000030: 3b33 326d 6c65 765f 636f 6d70 1b5b 306d  ;32mlev_comp.[0m
    0000040: 0a1b 5b30 313b 3336 6d6c 6963 656e 7365  ..[01;36mlicense
    0000050: 1b5b 306d 0a1b 5b33 303b 3433 6d6e 6574  .[0m..[30;43mnet
    0000060: 6861 636b 2d63 6f6e 736f 6c65 1b5b 306d  hack-console.[0m
    0000070: 0a1b 5b30 313b 3332 6d6e 6574 6861 636b  ..[01;32mnethack
    0000080: 2d63 6f6e 736f 6c65 2e73 681b 5b30 6d0a  -console.sh.[0m.
    0000090: 6e68 6461 740a 1b5b 3330 3b34 336d 7265  nhdat..[30;43mre
    00000a0: 636f 7665 721b 5b30 6d0a 1b5b 3031 3b33  cover.[0m..[01;3
    00000b0: 326d 7265 636f 7665 722d 6865 6c70 6572  2mrecover-helper
    00000c0: 1b5b 306d 0a                             .[0m.

    empty@monkey:~$ ls --color /usr/lib/games/nethack/ | dumb | xxd
    0000000: 6467 6e5f 636f 6d70 0a64 6c62 0a68 680a  dgn_comp.dlb.hh.
    0000010: 6c65 765f 636f 6d70 0a6c 6963 656e 7365  lev_comp.license
    0000020: 0a6e 6574 6861 636b 2d63 6f6e 736f 6c65  .nethack-console
    0000030: 0a6e 6574 6861 636b 2d63 6f6e 736f 6c65  .nethack-console
    0000040: 2e73 680a 6e68 6461 740a 7265 636f 7665  .sh.nhdat.recove
    0000050: 720a 7265 636f 7665 722d 6865 6c70 6572  r.recover-helper
    0000060: 0a                                       
    
