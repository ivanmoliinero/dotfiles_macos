# USE CASES FOR THE ACTUAL CONFIG
This document has some use cases of the work setup that have been encountered while working with it, with some step-by-step guides to reproduce everything.

## AeroSpace: Show more than one window in screen
Whenever work is being done with accordeon tiles / full-screens, the other windows are not visible. Sometimes it is desirable to group various windows into the screen in order to see them at the same time.
To do so, a new mode has been created. The steps are:
- alt-shift-period (period == '.'): Change to 'service' mode.
- alt-shift-h/l: Join with window located at the left/right of the actual window (respectively).
- alt-shift-period | esc: Return back to 'main' mode.
In order to undo this change:
- alt-shift-period: Change to 'service' mode.
- r: Flatten all containers.
- alt-shift-period | esc: Return back to 'main' mode.
Or alternatively, just move one window outside the container (left or right).

NOTE: Some other options will be investigated:
- Pile multiple windows, not just two.
- Pile vertically, right now something odd happens and all windows are put into tiles layout.

## Ghostty: Quick terminal
Instead of opening Ghostty each time a new terminal is needed for quick commands, the quick terminal shortcut can be used.
It works as a singleton pop-up that allows the user to run fast commands to do quick checks instead of having a full terminal session opened and persisted in a window.
It has been configured in the Ghostty terminal to respond to the **alt-shift-t** shortcut in order to be consistent with the shortcuts of AeroSpace instead of using the Ghostty conventions (because this terminal can be accessed from anywhere).

NOTE: The global option has been used. This is needed to be able to invoke the terminal from wherever in the desktop. Moreover, Ghostty needs permissions into System Settings → Privacy & Security. Feel completely free to remove the global tag if you are not comfortable with this configuration.
