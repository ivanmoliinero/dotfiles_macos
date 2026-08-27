-- File: ~/.config/nvim/lua/plugins/colorscheme.lua
-- Return a table of plugins for Lazy plugin manager
return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Set the style to match Atom One Dark
      style = "dark",

      -- Enable transparency to inherit Ghostty background and padding
      transparent = true,

      -- Use terminal colors
      term_colors = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- Set the default colorscheme for LazyVim
      colorscheme = "onedark",
    },
  },
}
