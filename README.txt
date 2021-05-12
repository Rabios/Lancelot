==========================================================
LANCELOT - A GAME LAUNCHER WRITTEN IN RUBY
==========================================================

Hi Gamers! :)

Lancelot is a tiny and good free-of-charge Open-Source Game Launcher written in Ruby via DragonRuby GTK!

It's made for The Tool Jam and amazingly works for Desktops with Keyboard Input currently (No plan to support mobiles yet)

==========================================================
LANCELOT - FEATURES
==========================================================

1. Add/Delete and Launch games on your own!
2. 8 backgrounds to fullfill your pleasure, And you can also use your own ones! :)
3. Fast, Optimized, Powered by SDL2 via DragonRuby
4. Create/Delete groups to manage/sort your games and play from!
5. Ranking system to see what most games you play with most and total time(s) played

==========================================================
LANCELOT - UNIMPLEMENTED
==========================================================

Due to lack of time, Some features not available like:

1. Textbox movement of cursor with left/right
2. Mouse, Joystick/Gamepad input
3. Use E as edit key for info (If you have made mistake when creating game/list, You'll need to delete it and re-add it again so sorry...)

==========================================================
LANCELOT - ADDING A GAME
==========================================================

Example...

1. When they ask for game name, Input it
2. When they ask for genres, Input each one and add ", " Example: "Action, Shooter, Puzzle" (Without quotes)
3. Locate files and select it
4. Done!

==========================================================
LANCELOT - ADDING A LIST
==========================================================

When they ask for list name, Input it, Then add games to list and done!

==========================================================
LANCELOT - EDITING GAMES/LISTS
==========================================================

To edit list or game, You should delete it and re-add it (Don't worry deleting game doesn't mean that game and it's files will be removed from your disk)

==========================================================
LANCELOT - FAQ
==========================================================

Q: How many backgrounds this has?
A: 8, But you can choose your own ones.

Q: What are cachedir.cmd and imgcopy.cmd and why used by Windows version?
A: They are batch scripts written by me to do some stuff that it's not possible to embed and do inside Ruby, cachedir used to get content of directory and outputs it to file called dirlist.txt, imgcopy copies image correctly to data folder for usage.

Q: What is data folder?
A: This folder used by Lancelot to store save data if you are running Lancelot from source, And also it stores games images and backgrounds you use via copy.

Q: Why no Gamepad/Joystick and Mouse input support?
A: Due to lack of time, Plus the requirement of using the Keyboard (That means the other input devices would be useless if all Lancelot controls set to use it...)

Q: Would removing game from Lancelot deletes game by itself?
A: No, It just removes the info so don't worry.

Q: There is no save button?
A: Lancelot saves automatically.

Q: What Lancelot made with?
A: This game made with DragonRuby Game Toolkit in Ruby programming language, It's implemeneted on top of the fast and minimal Ruby implementation mruby, You can get it here: https://dragonruby.org

Q: Can i have source code?
A: Yes you can and it's licensed under MIT, See here: https://github.com/Rabios/lancelot

Q: What if i had bug in the game?
A: Easy, Go to https://github.com/Rabios/lancelot/issues and create new issue describing bug happen!

Q: What they mean by split in Game Genres?
A: This line below shows how to do it ->>>

Action, RPG, Puzzle

Q: There is something weird with file explorer, Files not shown?
A: Easy, Edit path to some dir and hit enter!

Putting this in textbox is enough, So we have 3 genres now!

==========================================================
LANCELOT - CONTROLS
==========================================================

Games:

1. Use enter to select/deselect
2. Use left/right to navigate around
3. Use delete key to remove games/lists
4. Use TAB to move to Lists menu

Lists:

1. Use enter to select/deselect
2. Use left/right to navigate around
3. Use delete key to remove games/lists
4. Use TAB to move to Stats menu

Stats:

1. Use left/right to see all stats
2. Use TAB to move to Options menu

Options:

1. Use enter to select/deselect
2. Use left/right to navigate around
3. Use up/down to manipulate value of some  options
4. Use TAB to move back to Games menu

File explorer:

1. Use enter key to select file or navigate into directory
2. Use up/down to navigate into directory's content
3. Use HOME key to edit current path and then press ENTER
4. Use backspace to move back to previous directory
5. Black-Highlighted file names are allowed files to choose

Textboxes:

1. Any key to type (Except backspace)
2. Backspace to clear

==========================================================
LANCELOT - SPECIAL THANKS
==========================================================

DRGTK Discord Server:

DaFoom             (@DaFoom)
Kevin Fischer      (@kfischer_okarin)
leviondiscord      (@leviondiscord)
magiondiscord      (@magiondiscord)
Amir Rajan         (@amirrajan)
Akzidenz-Grotesk   (@Akzidenz-Grotesk)
kota               (@kota)
kartheek           (@kartheek)

==========================================================
LANCELOT - THIRD PARTY
==========================================================
Images used:

1. Gradient backgrounds are from xmple.com

2. File icon by alecive on iconarchive.com site:
https://iconarchive.com/show/flatwoken-icons-by-alecive/Apps-File-Text-Plain-icon.html
(Licensed under CC BY-SA 4.0 License)

3. Folder icon by dtafalonso on iconarchive.com site:
https://iconarchive.com/show/yosemite-flat-icons-by-dtafalonso/Folder-icon.html
(Licensed under CC Attribution-No Derivative 4.0)

Sounds used from from freesound.org:

1. https://freesound.org/people/Sjonas88/sounds/538548
2. https://freesound.org/people/old_waveplay/sounds/399934
3. https://freesound.org/people/greenvwbeetle/sounds/244657
4. https://freesound.org/people/uEffects/sounds/180974
5. https://freesound.org/people/UberBosser/sounds/421582
(Licensed under Creative Commons 0 License)

Fonts used:

1. Ubuntu Titling font by Andrew Fitzsimon: https://www.fontsquirrel.com/fonts/ubuntu-title
(Licensed under GNU Lesser General Public License)

==========================================================
LANCELOT - CHANGELOG
==========================================================

=================================
Version v0.1 (13/May/2021)
=================================
First release of the game!
