# Load autoconfig false
config.load_autoconfig(False)

# Set the tab bar position to the left (can also be 'right')
c.tabs.position = 'left'

# Define the width of the vertical tab bar (accepts pixels or percentages)
c.tabs.width = '15%'

# Optional: Hide the tab bar when there is only one tab open
c.tabs.show = 'multiple'

# Increase the font size for both selected and unselected tabs
c.fonts.tabs.selected = '14pt default_family'
c.fonts.tabs.unselected = '14pt default_family'

# Add internal padding to make the tab hitboxes larger and more comfortable
c.tabs.padding = {'top': 10, 'bottom': 10, 'left': 12, 'right': 12}

# Define background and foreground colors for unselected tabs (dark grey)
c.colors.tabs.even.bg = '#1e1e2e'
c.colors.tabs.odd.bg = '#1e1e2e'
c.colors.tabs.even.fg = '#a6adc8'
c.colors.tabs.odd.fg = '#a6adc8'

# Define background and foreground colors for the selected tab (blue highlight)
c.colors.tabs.selected.even.bg = '#89b4fa'
c.colors.tabs.selected.odd.bg = '#89b4fa'
c.colors.tabs.selected.even.fg = '#1e1e2e'
c.colors.tabs.selected.odd.fg = '#1e1e2e'

# Customize the pinned tab colors to match the theme
c.colors.tabs.pinned.even.bg = '#f38ba8'
c.colors.tabs.pinned.odd.bg = '#f38ba8'
c.colors.tabs.pinned.even.fg = '#1e1e2e'
c.colors.tabs.pinned.odd.fg = '#1e1e2e'

# Customize the loading indicator on the side of the tab
c.tabs.indicator.width = 4
c.colors.tabs.indicator.start = '#89b4fa'
c.colors.tabs.indicator.stop = '#a6e3a1'
c.colors.tabs.indicator.error = '#f38ba8'

# Increase the font size for the standard text in the status bar
c.fonts.statusbar = '12pt default_family'

# Increase the font size for the command-line prompts (when pressing ':')
c.fonts.prompts = '12pt default_family'

# Increase the font size for temporary messages (info, warnings, errors)
c.fonts.messages.info = '12pt default_family'
c.fonts.messages.warning = '12pt default_family'
c.fonts.messages.error = '12pt default_family'

# Add moderate padding to increase the height of the bar
# Values are smaller than the tabs to keep it proportional
c.statusbar.padding = {'top': 6, 'bottom': 6, 'left': 8, 'right': 8}

# Increase the font sizes for the completion list items and categories
c.fonts.completion.entry = '12pt default_family'
c.fonts.completion.category = 'bold 12pt default_family'

# Increase the overall height of the completion menu (percentage of the window)
c.completion.height = '33%'
