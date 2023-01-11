local M = {
  mapleader = " ", -- sets vim.g.mapleader
  autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
  cmp_enabled = true, -- enable completion at start
  autopairs_enabled = true, -- enable autopairs at start
  diagnostics_enabled = true, -- enable diagnostics at start
  status_diagnostics_enabled = true, -- enable diagnostics in statusline
  icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
  ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  heirline_bufferline = false, -- enable new heirline based bufferline (requires :PackerSync after changing)
}

return M
