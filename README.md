# pronounce.sh
Plays/downloads the Wiktionary pronounciation of a word.  
*Usage:* "**pronounce.sh WORD [-po filename]**"  

If you use the "**-p**" option, then isntead of saving the pronounciation, it will be played.  

If you use the "**-o**" option, then it will be saved to the specified filename.  

If you use both ("-po"), then it'll do both.

Oh, and the options *must* come after the word.

There's a bloody eel in my hovercraft, dammit! How do I say hovercraft? 

```$ pronounce.sh hovercraft -p```

Only tested on OpenBSD's ksh, but it should work on bash and other modern shells.
