local m = {
  init = {
    -- You can disable default plugins as follows:
    -- ["goolord/alpha-nvim"] = { disable = true },

    -- You can also add new plugins here as well:
    -- Add plugins, the packer syntax without the "use"
    -- { "andweeb/presence.nvim" },
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- },

    -- We also support a key value style plugin definition similar to NvChad:
    -- ["ray-x/lsp_signature.nvim"] = {
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- },
    --add by akn
    ["goolord/alpha-nvim"] = {
      config = function() require "user.config.alpha_config" end,
    },
    -- ini untuk color scheme
    ["folke/tokyonight.nvim"] = {
      commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764",
      config = function() require "user.colorscheme.tokyonight-config" end,
    },
    ["kyazdani42/nvim-tree.lua"] = {
      config = function() require "user.config.nvim-tree" end,
    },
    -- untuk pewarnaan TODO:
    ["folke/todo-comments.nvim"] = {
      event = "BufRead",
      config = function() require("todo-comments").setup() end,
    },
    ["manzeloth/live-server"] = {},
    ["mg979/vim-visual-multi"] = {},
    ["CRAG666/code_runner.nvim"] = {
      config = function() require "user.config.coderunner" end,
    },
    -- untuk scroll view
    ["karb94/neoscroll.nvim"] = {
      config = function() require("neoscroll").setup() end,
    },
    ["dstein64/nvim-scrollview"] = {
      event = { "BufRead", "BufNewFile" },
      config = function() require "user.config.nvimscroll" end,
    },
    -- ini untuk overide icons
    ["nvim-tree/nvim-web-devicons"] = {
      config = function() require "user.config.webdevicons" end,
    },
    ["iamcco/markdown-preview.nvim"] = {
      run = "cd app && npm install",
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" },
    },
    ["williamboman/nvim-lsp-installer"] = {},
    -- untuk auto comp commond mode
    ["gelguy/wilder.nvim"] = {
      config = function()
        local wilder = require "wilder"
        wilder.setup { modes = { ":", "/", "?" } }
        -- wilder.set_option(
        --   "renderer",
        --   wilder.popupmenu_renderer {
        --     highlighter = wilder.basic_highlighter(),
        --     left = { " ", wilder.popupmenu_devicons() },
        --     right = { " ", wilder.popupmenu_scrollbar() },
        --   }
        -- )

        -- *ini untuk popup dialog
        wilder.set_option(
          "renderer",
          wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
            -- 'single', 'double', 'rounded' or 'solid'
            -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
            border = "rounded",
            max_height = "40%", -- max height of the palette
            max_width = "40%",
            min_height = 0, -- set to the same as 'max_height' for a fixed height window
            prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
            reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
            left = { " ", wilder.popupmenu_devicons() },
            right = { " ", wilder.popupmenu_scrollbar() },
            pumblend = 20,
          })
        )
      end,
    },
    -- untuk auto save
    ["907th/vim-auto-save"] = { event = "InsertEnter" },
    -- Manage your yank history
    ["gbprod/yanky.nvim"] = {
      config = function() require "user.config.yanky" end,
    },
    ["dstein64/vim-startuptime"] = { cmd = "StartupTime" },
    ["echasnovski/mini.indentscope"] = {
      version = false,
      event = "BufReadPre",
      opts = {
        -- symbol = "▏",
        symbol = "│",
        options = { try_as_border = true },
      },
      config = function(_, opts)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
          callback = function() vim.b.miniindentscope_disable = true end,
        })
        require("mini.indentscope").setup(opts)
      end,
    },
    ["mfussenegger/nvim-jdtls"] = { module = "jdtls" }, -- load jdtls on module
  },
  ["cmp"] = function() require "user.config.cmp" end,
  -- ["nvim-web-devicons"] = function() require "user.config.webdevicons" end,
  -- All other entries override the require("<key>").setup({...}) call for default plugins
  ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
    -- config variable is the default configuration table for the setup function call
    -- local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
    }
    return config -- return final config table
  end,
  -- use mason-lspconfig to configure LSP installations
  ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
    -- ensure_installed = { "sumneko_lua" },
    -- ensure_installed = { "jdtls" },   -- buka remark ini untuk java
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
    -- ensure_installed = { "prettier", "stylua" },
  },
  ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
    -- ensure_installed = { "python" },
  },
  -- config ini khusus untuk mode transparant background
  ["notify"] = function() vim.notify = require("notify").setup { background_colour = "#000000" } end,

  --hire line
  -- override the heirline setup call
  heirline = function(config)
    -- the first element of the configuration table is the statusline
    config[1] = {
      -- default highlight for the entire statusline
      hl = { fg = "fg", bg = "bg" },
      -- each element following is a component in astronvim.status module

      -- add the vim mode component
      astronvim.status.component.mode {
        -- enable mode text with padding as well as an icon before it
        mode_text = { hl = { bold = true }, icon = { kind = "VimIcon", padding = { right = 1, left = 1 } } },
        -- define the highlight color for the text
        hl = { fg = "bg" },
        -- surround the component with a separators
        surround = {
          -- it's a left element, so use the left separator
          separator = "left",
          -- set the color of the surrounding based on the current mode using astronvim.status module
          color = function() return { main = astronvim.status.hl.mode_bg(), right = "blank_bg" } end,
        },
      },
      -- we want an empty space here so we can use the component builder to make a new section with just an empty string
      astronvim.status.component.builder {
        { provider = "" },
        -- define the surrounding separator and colors to be used inside of the component
        -- and the color to the right of the separated out section
        surround = { separator = "left", color = { main = "blank_bg", right = "file_info_bg" } },
      },
      -- add a section for the currently opened file information
      astronvim.status.component.file_info {
        -- enable the file_icon and disable the highlighting based on filetype
        file_icon = { hl = false, padding = { left = 0 } },
        filename = { fallback = "Empty" },
        -- add padding
        padding = { right = 1 },
        -- define the section separator
        surround = { separator = "left", condition = false },
      },
      -- add a component for the current git branch if it exists and use no separator for the sections
      astronvim.status.component.git_branch { surround = { separator = "none" } },
      -- add a component for the current git diff if it exists and use no separator for the sections
      astronvim.status.component.git_diff { padding = { left = 1 }, surround = { separator = "none" } },
      -- fill the rest of the statusline
      -- the elements after this will appear in the middle of the statusline
      astronvim.status.component.fill(),
      -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
      astronvim.status.component.lsp { lsp_client_names = false, surround = { separator = "none", color = "bg" } },
      -- fill the rest of the statusline
      -- the elements after this will appear on the right of the statusline
      astronvim.status.component.fill(),
      -- add a component for the current diagnostics if it exists and use the right separator for the section
      astronvim.status.component.diagnostics { surround = { separator = "right" } },
      -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
      astronvim.status.component.lsp { lsp_progress = false, surround = { separator = "right" } },
      -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
      -- all of the children of this table will be treated together as a single component
      {
        -- define a simple component where the provider is just a folder icon
        astronvim.status.component.builder {
          -- astronvim.get_icon gets the user interface icon for a closed folder with a space after it
          { provider = astronvim.get_icon "FolderClosed" },
          -- add padding after icon
          padding = { right = 1 },
          -- set the foreground color to be used for the icon
          hl = { fg = "bg" },
          -- use the right separator and define the background color
          surround = { separator = "right", color = "folder_icon_bg" },
        },
        -- add a file information component and only show the current working directory name
        astronvim.status.component.file_info {
          -- we only want filename to be used and we can change the fname
          -- function to get the current working directory name
          filename = { fname = function(nr) return vim.fn.getcwd(nr) end, padding = { left = 1 } },
          -- disable all other elements of the file_info component
          file_icon = false,
          file_modified = false,
          file_read_only = false,
          -- use no separator for this part but define a background color
          surround = { separator = "none", color = "file_info_bg", condition = false },
        },
      },
      -- the final component of the NvChad statusline is the navigation section
      -- this is very similar to the previous current working directory section with the icon
      { -- make nav section with icon border
        -- define a custom component with just a file icon
        astronvim.status.component.builder {
          { provider = astronvim.get_icon "ScrollText" },
          -- add padding after icon
          padding = { right = 1 },
          -- set the icon foreground
          hl = { fg = "bg" },
          -- use the right separator and define the background color
          -- as well as the color to the left of the separator
          surround = { separator = "right", color = { main = "nav_icon_bg", left = "file_info_bg" } },
        },
        -- add a navigation component and just display the percentage of progress in the file
        astronvim.status.component.nav {
          -- add some padding for the percentage provider
          percentage = { padding = { left = 1, right = 1 } },
          -- disable all other providers
          ruler = false,
          scrollbar = false,
          -- define the foreground color
          hl = { fg = "nav_icon_bg" },
          -- use no separator and define the background color
          surround = { separator = "none", color = "file_info_bg" },
        },
      },
    }

    -- a second element in the heirline setup would override the winbar
    -- by only providing a single element we will only override the statusline
    -- and use the default winbar in AstroNvim

    -- return the final confiuration table
    return config
  end,
}

return m
