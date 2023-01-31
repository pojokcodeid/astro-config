local m = {
  init = {
    -- start for rust
    -- {
    --   "simrat39/rust-tools.nvim",
    --   after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
    --   config = function()
    --     require("rust-tools").setup {
    --       server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
    --     }
    --   end,
    -- },
    -- end rust
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
        wilder.set_option(
          "renderer",
          wilder.popupmenu_renderer {
            highlighter = wilder.basic_highlighter(),
            left = { " ", wilder.popupmenu_devicons() },
            right = { " ", wilder.popupmenu_scrollbar() },
          }
        )

        -- *ini untuk popup dialog
        -- wilder.set_option(
        --   "renderer",
        --   wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
        --     -- 'single', 'double', 'rounded' or 'solid'
        --     -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
        --     border = "rounded",
        --     max_height = "40%", -- max height of the palette
        --     max_width = "40%",
        --     min_height = 0, -- set to the same as 'max_height' for a fixed height window
        --     prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        --     reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        --     left = { " ", wilder.popupmenu_devicons() },
        --     right = { " ", wilder.popupmenu_scrollbar() },
        --     pumblend = 20,
        --   })
        -- )
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
    -- ensure_installed = { "rust_analyzer" }, -- buka remark ini untuk rust
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
    -- ensure_installed = { "prettier", "stylua" },
  },
  ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
    -- ensure_installed = { "python" },
  },
}

return m
