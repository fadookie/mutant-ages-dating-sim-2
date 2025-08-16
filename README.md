# X-Men Dating Origins 2
This repository contains the source for a Doom mod I made. It's a queer X-Men dating simulator which is the sequel to [X-Men Dating Origins: Wolverine](https://www.eliotlash.com/works/mutant-ages-dating-sim). It's heavily inspired by the queer X-Men alternate universe/headcanons of [The Mutant Ages](https://soundcloud.com/themutantages) podcast.

**Content Warning**: This game contains crude language, adult humor, and LGBTQ+ content. There is no nudity or suggestive graphic content, however, it is not safe for work and is not intended for minors.

**This game is a work of parody** and is not associated with or endorsed by Marvel.  X-Men are copyrighted by Marvel.

# System Requirements
This is a mod for Doom 2 requiring a recent version of the [GZDoom engine](https://zdoom.org/downloads) and should be supported by any OS which GZDoom supports. I have been testing it with GZDoom 4.14.1, it should work on newer versions but is not guaranteed to work on older versions.

It's recommended to play this game using `DOOM2.WAD` as the base game (IWAD), which may be purchased from [various PC game stores](https://doom.bethesda.net/en-US/doom_doomii). However, `freedoom2.wad` [(Freedoom Phase 2)](https://freedoom.github.io/download.html) is a free alternative which may be used instead.

# Installation
For Windows you may use the standalone portable application which includes everything you need to run the game: GZDoom, `mutant-ages-dating-sim-2.pk3`, `freedoom2.wad`, and a pre-configured `gzdoom_portable.ini` file. If you own `DOOM2.WAD` you may also drop it into this folder and select it from the launch menu when starting GZDoom.

> **Note**: Do not put the standalone build in `Program Files` on Windows, this will cause the bundled config to be ignored. Put it somewhere in your home directory like the `Desktop`, etc.

## PK3 Mod (PWAD) Setup
If you are not on Windows or are comfortable running doom mods on your own, you may use the `pk3` by itself.

Install GZDoom and your selected Doom 2/Freedoom Phase 2 IWAD file. You may drop it in the folder next to the GZDoom executable or place it on your IWAD search path. Please see the [ZDoom Wiki article on installing and configuring GZDoom](https://zdoom.org/wiki/Installation_and_execution_of_ZDoom).

Download the `mutant-ages-dating-sim-2` pk3 file and copy the full path to it.

Launch GZDoom and drag the pk3 onto it or add the following launch argument:
`-file "/PATH/TO/mutant-ages-dating-sim-2.pk3"` (this should be the path you copied in the previous step.) If needed, select either `DOOM2.WAD` or `freedoom2.wad` from the IWAD selection menu.

If it worked you should see the splash screen for the mod instead of the default Doom 2 splash screen.

### PK3 Mod (PWAD) Game Configuration
If you are not using the Windows portable application I would strongly recommend taking some time to configure GZDoom before playing. To do so, click the mouse or hit the escape or enter key and select the options menu with the mouse or arrow keys. The following settings are recommended for the ideal play experience:

**Most importantly** be sure to go into `Customize Controls` -> `Action` menu and bind keys for `Jump` and `Crouch`. I use Space for jump and Control for crouch but it can be whatever you want, just be careful not to overwrite any other necessary keybinds for movement, `Use`, and shooting.

Please ensure that under `Sound Options` the sound, music, and master volume is loud enough for you to hear it.

Under `Display Options` set the `Texture Filter Mode` to `None`.

Under `Scaling Options` set `HUD preserves aspect ratio` to `Yes` if it's not set already.

Feel free to adjust any other settings to your liking, then hit escape and select "New Game" to begin playing.

Once in-game I recommend using the classic "doomguy" portrait status bar which can be selected by pressing the + and - keys.

# In-game Controls
The game uses standard GZDoom controls by default, WASD for movement and mouse look. Left mouse button is the default for fire and E for use/talk. And whatever keys you selected for Jump/Crouch, which in the standalone Windows build use Spacebar and Control by default, respectively. Tab toggles the automap.

Dialogue trees can be navigated by clicking or using arrow keys and enter to select dialogue options.

The game should prompt you with your currently assigned keybinds at points in which the controls may not be completely obvious.

GZDoom does not provide an auto-save mechanism so you may wish to take advantage of the quicksave key (default binding is F6) or save menu which can be accessed by hitting the escape key. Although the game is short enough it can be played in one sitting.

***

Please see the [credits file](./CREDITS.md) for information on people who helped make this game and a list of assets used.

That's about it, thanks for playing and I hope you enjoy!