# Credits
Note this document may spoil some surprises in the game so I would recommend waiting to read it until after you've finished playing.

## Developers

Design, Writing, Programming - Eliot Lash
Level Design, Extra Scripting - Patrick Pacheco

## Special Thanks
David Newel - Level Explorations, Playtesting
Elena Ferrari - Beta Reading, Playtesting
Kevin Feng (ReimJ) - Playtesting

[The Mutant Ages](https://soundcloud.com/themutantages) hosts and community for being awesome and inspiring me to make this in the first place.

The [GZDoom](https://zdoom.org/index), [SLADE](https://slade.mancubus.net/index.php?page=about), and [Ultimate Doom Builder](http://doombuilder.com) teams for making amazing tools for creativity.

The GZDoom and [Dragonfly’s Doomworks](https://www.dfdoom.com) communities for helping when I got stuck and maintaining helpful documentation.

And last but not least, my partner for supporting me in this long and very silly endeavor.

## Assets Used
I do not own most of the assets for this game. Some but not all of them are available under copyleft licenses.

### Music

### Sounds

Sounds from [Freesound.org](https://freesound.org) used under Creative Commons licenses:
 * Nom_C_06.wav by PaulMorek -- https://freesound.org/s/172135/
 * Nom_C_01.wav by PaulMorek -- https://freesound.org/s/172137/
 * party horn 3/3 harsh by vewiu -- https://freesound.org/s/379615/
 * Noise_Rising_Low_Pass.wav by ofuscapreto -- https://freesound.org/s/237497/
 * 05800 space jet flyby.wav by Robinhood76 -- https://freesound.org/s/274820/
 * whooshes high 4.wav by Eliot Lash -- https://freesound.org/s/121739/

### Art
Some graphic edits Patrick and I made ourselves based on graphics from `DOOM2.WAD` or images found online.

The following public domain assets were used:
 * Pink cake by Gabrielle Nowicki https://openclipart.org/detail/23966/pink-cake
 * Cake 17 by Firkin https://openclipart.org/detail/301718/cake-17

This game uses sprites sourced from Dcat, jin315, AFruitaday!, Cabanaman, Cyrus Annihilator, and ScrollBoss in what I'm hoping qualifies as fair use as this is a work of parody.

# Music

The following music was used without explicit permission but I'm hoping the creators won't mind:

 * "The Mutant Ages Comic Book (Theme)", "The Mutant Ages (Theme) (Instrumental)", "The X-Men Are a Metaphor", "[Petty](https://maddymyers.bandcamp.com/track/petty)", and "Wolverine's On A Date (With You)" by MIDI Myers (via [bandcamp.com](https://maddymyers.bandcamp.com))
 * Happy Birthday MIDI from https://freemidi.org/download2-11624-happy-birthday-birthday
 * X-Men TAS Theme Song MIDI by Unknown Artist

# Tools
Eevee's [Doom Text Generator](https://c.eev.ee/doom-text-generator) for creating text for graphics using Doom fonts. Her [tutorials on Doom modding](https://eev.ee/blog/2015/12/19/you-should-make-a-doom-level-part-1/) were also part of what got me into making Doom mods in the first place!

In addition to the Doom editing tools mentioned above, I developed the following tools during the course of making this game to help make things more efficient:

[SpriteSlicer](https://github.com/fadookie/SpriteSlicer) is a tool for Unity to assist in automatic slicing/exporting of spritesheets.

I also wound up making several attempts at tooling to make the process of writing [USDF](https://zdoom.org/wiki/Universal_Strife_Dialog_Format)/[ZSDF](https://zdoom.org/wiki/ZDoom_Strife_Dialog_Format) dialogue trees less painful.

[usdftool](./udsftool) which is a [codemod](https://pypi.org/project/codemod/) tool for automatically updating USDF page index numbers.

[doom-dialogue-template-tool](https://github.com/fadookie/doom-dialogue-template-tool) is a tool for parsing and merging dialogue templates.

I made these both prior to my discovery of named labels in ZSDF which works better.

[StrifeSpinner](https://github.com/fadookie/StrifeSpinner) is the most ambitious of my dialogue tools which is a transpiler for a subset of the [Yarn Spinner](https://www.yarnspinner.dev) 2 dialogue format which transpiles to ZSDF. A lot of the dialogue in the final sequence of the game was written in Yarn and transpiled to ZSDF.