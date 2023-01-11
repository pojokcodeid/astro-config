local m = {
  relativenumber = true, -- sets vim.opt.relativenumber
  number = true, -- sets vim.opt.number
  spell = false, -- sets vim.opt.spell
  signcolumn = "auto", -- sets vim.opt.signcolumn to auto
  shiftwidth = 2, -- Number of space inserted for indentation
  showtabline = 2, -- always display tabline
  tabstop = 2, -- Number of space in a tab
  -- Length of time to wait before triggering the plugin
  wrap = true, -- Disable wrapping of lines longer than the width of window
  guifont = "FiraCode_Nerd_Font:h16", -- the font used in graphical neovim applications
}
return m
