# pronounce.sh
Plays/downloads the Wiktionary pronunciation of a word.  
*Usage:* "**pronounce.sh WORD [limit -po filename]**"  

If you use the limit option, then write a number-- then only that number of pronunciations (if available) will be played.

If you use the "**-p**" option, then instead of saving the pronunciation, it will be played.  

If you use the "**-o**" option, then it will be saved to the specified filename.  

If you use both ("-po"), then it'll do both.

Oh, and the options *must* come after the word.

There's a bloody eel in my hovercraft, dammit! How do I say hovercraft? 

```$ pronounce.sh hovercraft 1 -p```

Only tested on OpenBSD's ksh, but it should work on bash and other modern shells.
