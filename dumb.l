%{	
/**********************************************************************
 *
 *	dumb : 2013-03-20	
 *
 *		emptymonkey's dumb tool.
 *		Take smart terminal output and make it dumb.
 *
 *
 *	Dumb output is acheived by removing all valid control characters
 *	and escape sequences. 
 *
 *
 *	Example usage:
 *
 *	empty@monkey:~$ ls
 *	dumb  dumb.l  dumb.o  Makefile  test_cases
 *	empty@monkey:~$ ls --color | xxd
 *	0000000: 1b5b 306d 1b5b 3031 3b33 326d 6475 6d62  .[0m.[01;32mdumb
 *	0000010: 1b5b 306d 0a64 756d 622e 6c0a 6475 6d62  .[0m.dumb.l.dumb
 *	0000020: 2e6f 0a4d 616b 6566 696c 650a 1b5b 3031  .o.Makefile..[01
 *	0000030: 3b33 346d 7465 7374 5f63 6173 6573 1b5b  ;34mtest_cases.[
 *	0000040: 306d 0a                                  0m.
 *	empty@monkey:~$ ls --color | dumb | xxd
 *	0000000: 6475 6d62 0a64 756d 622e 6c0a 6475 6d62  dumb.dumb.l.dumb
 *	0000010: 2e6f 0a4d 616b 6566 696c 650a 7465 7374  .o.Makefile.test
 *	0000020: 5f63 6173 6573 0a                        _cases.
 *	
 **********************************************************************/
 
#include <stdio.h>	
%}	
	
%option noyywrap
%option nounput
%option noinput

%option always-interactive

Ps	[0-9]*
Pm	{Ps}(\;{Ps})*
Pt	[\x20-\x7e]+
Pf	[\x08-\x0d]+ 

SS3	({ESC}O)|\x8F
DCS	({ESC}P)|\x90
CSI	({ESC}\[)|\x9B
ST	({ESC}\\)|\x9C
OSC	({ESC}\])|\x9D
PM	({ESC}\^)|\x9E
APC ({ESC}\_)|\x9F

ENQ	\x05
BEL \x07
BS	\x08
TAB	\x09
LF	\x0A
VT	\x0B
FF	\x0C
CR	\x0D
SO	\x0E
SI	\x0F
ESC	\x1B
SP	\x20


%%	

({CR}|{LF})|({CR}{LF})			{ printf("\n"); }
{BEL}|{BS}|{ENQ}|{FF}|{SO}|{TAB}|{VT}|{SI}	|

{ESC}{SP}F	|
{ESC}{SP}G	|
{ESC}{SP}L	|
{ESC}{SP}M	|
{ESC}{SP}N	|
{ESC}\#3	|
{ESC}\#4	|
{ESC}\#5	|
{ESC}\#6	|
{ESC}\#8	|
{ESC}\%\@	|
{ESC}\%G	|
{ESC}\([0AB4C5RQKYE6ZH7\=]	|
{ESC}\)[0AB4C5RQKYE6ZH7\=]	|
{ESC}\*[0AB4C5RQKYE6ZH7\=]	|
{ESC}\+[0AB4C5RQKYE6ZH7\=]	|
{ESC}\-[0AB4C5RQKYE6ZH7\=]	|
{ESC}\.[0AB4C5RQKYE6ZH7\=]	|
{ESC}\/[0AB4C5RQKYE6ZH7\=]	|
{ESC}6	|
{ESC}7	|
{ESC}8	|
{ESC}9	|
{ESC}\=	|
{ESC}\>	|
{ESC}F	|
{ESC}c	|
{ESC}l	|
{ESC}m	|
{ESC}n	|
{ESC}o	|
{ESC}\|	|
{ESC}\}	|
{ESC}\~	|
	
{APC}({Pf}|{Pt})+{ST}	|
	
{DCS}({Ps}\;{Ps})|{Pt}{ST}	|
{DCS}\$q{Pt}{ST}	|
{DCS}\+p{Pt}{ST}	|
{DCS}\+q{Pt}{ST}	|
	
{CSI}{Ps}\@	|
{CSI}{Ps}A	|
{CSI}{Ps}B	|
{CSI}{Ps}C	|
{CSI}{Ps}D	|
{CSI}{Ps}E	|
{CSI}{Ps}F	|
{CSI}{Ps}G	|
{CSI}{Ps}\;{Ps}H	|
{CSI}{Ps}I	|
{CSI}{Ps}J	|
{CSI}\?{Ps}J	|
{CSI}{Ps}K	|
{CSI}\?{Ps}K	|
{CSI}{Ps}L	|
{CSI}{Ps}M	|
{CSI}{Ps}P	|
{CSI}{Ps}S	|
{CSI}{Ps}T	|
{CSI}{Ps}(\;{Ps}){4}T	|
{CSI}\>{Ps}\;{Ps}T	|
{CSI}{Ps}X	|
{CSI}{Ps}Z	|
{CSI}{Pm}\`	|
{CSI}{Pm}a	|
{CSI}{Ps}b	|
{CSI}{Ps}c	|
{CSI}\>{Ps}c	|
{CSI}{Pm}d	|
{CSI}{Pm}e	|
{CSI}{Ps}\;{Ps}f	|
{CSI}{Ps}g	|
{CSI}{Pm}h	|
{CSI}\?{Pm}h	|
{CSI}{Pm}i	|
{CSI}\?{Pm}i	|
{CSI}{Pm}l	|
{CSI}\?{Pm}l	|
{CSI}{Pm}m	|
{CSI}\>{Ps}\;{Ps}m	|
{CSI}{Ps}n	|
{CSI}\>{Ps}n	|
{CSI}\?{Ps}n	|
{CSI}\>{Ps}p	|
{CSI}\!p	|
{CSI}{Ps}\$p	|
{CSI}\?{Ps}\$p	|
{CSI}{Ps}\;{Ps}\"p	|
{CSI}{Ps}q	|
{CSI}{Ps}{SP}q	|
{CSI}{Ps}\"q	|
{CSI}{Ps}\;{Ps}r	|
{CSI}\?{Pm}r	|
{CSI}{Ps}(\;{Ps}){4}\$r	|
{CSI}{Ps}\;{Ps}s	|
{CSI}s	|
{CSI}\?{Pm}s	|
{CSI}{Ps}(\;{Ps}){2}t	|
{CSI}{Ps}(\;{Ps}){4}\$t	|
{CSI}\>{Ps}\;{Ps}t	|
{CSI}{Ps}{SP}t	|
{CSI}u	|
{CSI}{Ps}{SP}u	|
{CSI}{Ps}(\;{Ps}){7}\$v	|
{CSI}{Ps}(\;{Ps}){3}\'w	|
{CSI}{Ps}x	|
{CSI}{Ps}\*x	|
{CSI}{Ps}(\;{Ps}){4}\$x	|
{CSI}{Ps}(\;{Ps}){5}\*y	|
{CSI}{Ps}\;{Ps}\'z	|
{CSI}{Ps}(\;{Ps}){3}\$z	|
{CSI}{Pm}\'\{	|
{CSI}{Ps}(\;{Ps}){3}\$\{	|
{CSI}{Ps}\'\|	|
{CSI}{Pm}{SP}\}	|
{CSI}{Pm}{SP}\~	|
	
{OSC}{Ps}\;{Pt}{ST}	|
{OSC}{Ps}\;{Pt}{BEL}	|
	
{PM}{Pt}{ST}	|
	
({CSI}|{SS3})A	|
({CSI}|{SS3})B	|
({CSI}|{SS3})C	|
({CSI}|{SS3})D	|
({CSI}|{SS3})H	|
({CSI}|{SS3})F	;
	
%%	
