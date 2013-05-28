# dumb #
A useful tool that takes smart terminal output and makes it dumb.

### What? ###

A smart terminal is a command-line interface that supports fancy features like color syntax or cursor repositioning. All modern Linux command-line interfaces are smart. A dumb terminal just prints what was written. Nothing else.

### How? ###

Smart terminals work by adding non-printable characters and escape sequences that you never see (or if you do, it looks like garbage.) This dumb tool will take the smart output and strip off these control characters and escape sequences.

### Why? ###

Occasionally your tty driver gets confused, or you have to examine a large pcap file that contains a tty stream. If everything looks like garbage, then run it through dumb. You'll lose out on all of the sweet terminal sugar, but you probably don't need that anyway.

### Who? ###

Anyone who uses a command-line will probably want to use this dumb tool once in a blue moon. 

### Wait a minute, can't I just use some fancy perl one-liner to do this? ###

Probably, but I've never seen anyone get it right. Keep in mind that your perl one-liner:
* is probably more than most people want to remember.
* won't match everything.
* will match some stuff it shouldn't.
* will be slower than my dumb tool for large inputs.

---
#### Further Reading ####

Wikipedia:  
[Command-line Interfaces](http://en.wikipedia.org/wiki/Commandline Command-Line Interfaces)  
[Computer Terminal](http://en.wikipedia.org/wiki/Computer_terminal)  
[Escape Sequence](http://en.wikipedia.org/wiki/Escape_sequence)  
[Control Character](http://en.wikipedia.org/wiki/Control_character)  
[C0 and C1 Control Codes](http://en.wikipedia.org/wiki/C0_and_C1_control_codes)  

Xterm:  
[Xterm Control Sequences](http://www.xfree86.org/current/ctlseqs.html)
