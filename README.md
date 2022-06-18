# Labyrinth Walker

NOTE: This project is abandoned. Please use FFRK-LabMem instead:

https://github.com/HughJeffner/FFRK-LabMem


This Autohotkey script goes through the Labyrinth dungeons in Final Fantasy Record Keeper semi-automatically. It will play an alarm whenever a Treasure Room is entered so you can choose which chests to open.

Requirements:

- Autohotkey installed on your PC
- Your favorite Android emulator (I used Nox with a mobile window resolution of 540x960)
- Your FFRK settings must be set to "Simplified Display" or else some animations will cause Autohotkey's ImageSearch to fail.
- Your top team must be unbeatable even at 10 fatigue points. A Holy Magic team is highly recommended.

To get this script to work you need to replace the snips in the "images" folder with your own. Take screenshots with Windows Snipping Tool while going through the dungeon manually. After all the images have been replaced with your own press F1 to unpuase/pause the script. You can press F2 to panic close the script.

If you want to make your own changes to the script open FFRK Labyrinth.ahk with notepad. Remember to exit and reload the script after saving changes. You can change the priority of the paintings by simply changing the number in "Priority#" variables inside the script with notepad.
