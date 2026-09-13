# Zen Browser: Additional configuration and some guides
## Configure tab opening below the currently selected tab
1. Search `about_config`.
2. Accept the warning.
3. Search for `browser.tabs.insertAfterCurrent` option and set it to true.

## GPU helper consumes to much RAM.
1. Search `about:processes`.
2. Find the process `GPU`.
3. Kill it with the cross symbol. 
NOTE: Some tabs will need to be restarted. I have identified Google Sheets to need a restart after doing this, for instance. Keep that in mind before actually performing this because some data may be lost during that refresh.
