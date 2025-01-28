lvim.colorscheme = "tokyonight"
lvim.transparent_window = true

-- rebind
local cmp = require("cmp")
local jumpable = require("lvim.core.cmp").methods.jumpable
local luasnip = require("luasnip")
lvim.builtin.cmp.mapping = cmp.mapping.preset.insert({
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
    ["<C-f>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
            luasnip.jump(1)
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
})
lvim.builtin.cmp.mapping['<Down>'] = {}
lvim.builtin.cmp.mapping['<Up>'] = {}

lvim.plugins = {
    {
        'xiyaowong/transparent.nvim',
        config = function()
            require("transparent").setup({
                groups = {
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = {
                    "NormalFloat",
                    "NvimTreeNormal",
                },
                exclude_groups = {},
            })
        end
    },
    { 'github/copilot.vim' },
    {
        'gen740/SmoothCursor.nvim',
        config = function()
            require('smoothcursor').setup({
                type = "default",
                cursor = "",
                texthl = "SmoothCursor",
                linehl = nil,
                fancy = {
                    enable = false,
                    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
                    body = {
                        { cursor = "󰝥", texthl = "SmoothCursorRed" },
                        { cursor = "󰝥", texthl = "SmoothCursorOrange" },
                        { cursor = "●", texthl = "SmoothCursorYellow" },
                        { cursor = "●", texthl = "SmoothCursorGreen" },
                        { cursor = "•", texthl = "SmoothCursorAqua" },
                        { cursor = ".", texthl = "SmoothCursorBlue" },
                        { cursor = ".", texthl = "SmoothCursorPurple" },
                    },
                    tail = { cursor = nil, texthl = "SmoothCursor" }
                },
                matrix = {
                    head = {
                        cursor = require('smoothcursor.matrix_chars'),
                        texthl = { 'SmoothCursor' },
                        linehl = nil,
                    },
                    body = {
                        length = 6,
                        cursor = require('smoothcursor.matrix_chars'),
                        texthl = { 'SmoothCursorGreen' },
                    },
                    tail = {
                        cursor = nil,
                        texthl = { 'SmoothCursor' },
                    },
                    unstop = false,
                },
                autostart = true,
                always_redraw = true,
                flyin_effect = nil,
                speed = 25,
                intervals = 35,
                priority = 10,
                timeout = 3000,
                threshold = 3,
                max_threshold = nil,
                disable_float_win = false,
                enabled_filetypes = nil,
                disabled_filetypes = nil,
                show_last_positions = nil,
            })
        end
    },
    { "CRAG666/code_runner.nvim", config = true },
    {
        'wakatime/vim-wakatime',
        lazy = false,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- bigfile = { enabled = true },
            dashboard = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true }
                }
            }
        },
        keys = {
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
            { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
            { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
            { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
            { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
            }
        },
        init = function()
            Snacks = require("snacks")
            vim.api.nvim_create_autocmd("User", {
                callback = function()
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd
                end,
            })
        end,
    },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            any = {
                                { find = '%d+L, %d+B' },
                                { find = '; after #%d+' },
                                { find = '; before #%d+' },
                                { find = '%d fewer lines' },
                                { find = '%d more lines' },
                            },
                        },
                        opts = { skip = true },
                    }
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        },
        config = function()
            require("lsp_lines").setup()
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        config = true
    },
    -- {
    --     "CopilotC-Nvim/CopilotChat.nvim",
    --     dependencies = {
    --         { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    --         { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    --     },
    --     build = "make tiktoken", -- Only on MacOS or Linux
    --     opts = {
    --         -- See Configuration section for options
    --         model = "claude-3.5-sonnet",
    --         window = {
    --             layout = "float",
    --             relative = 'cursor',
    --             width = 1,
    --             height = 0.4,
    --             row = 1
    --         },
    --     },
    --     -- See Commands section for default commands if you want to lazy load on them
    -- },

    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
      opts = {
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        copilot = {
          model = "claude-3.5-sonnet",
        },
        behaviour = {
          auto_suggestions = true
        },
        hints = { enabled = false },
        file_selector = {
          provider = "snacks",
        }
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = true,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        }
      }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        '3rd/image.nvim',
        dependencies = { "kiyoon/magick.nvim" },
        build = false,
        opts = {
            integrations = {
                html = { enabled = true },
                css = { enabled = true },
            },

        }
    },
    {
        'windwp/nvim-ts-autotag',
        -- opts = {}
        -- opts = {
        --     enable_close = false,
        --     enable_close_on_slash = true,
        -- }
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- enable_close = false,
                    enable_close_on_slash = true,
                }
            })
        end
    }
}

lvim.autocommands = {
    {
        "BufReadPost", {
            callback = function(args)
                local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
                local not_commit = vim.b[args.buf].filetype ~= 'commit'

                if valid_line and not_commit then
                    vim.cmd([[normal! g`"]])
                end
            end,
        }
    }
}

-- keybinds
lvim.keys.normal_mode["<leader>r"] = ":RunFile<CR>"
lvim.keys.normal_mode["<leader>sr"] = ":'<,'>SnipRun<CR>"
lvim.keys.normal_mode["<leader>nn"] = ":Noice dismiss<CR>"
lvim.keys.normal_mode["<leader>,"] = ":lua vim.lsp.buf.code_action()<CR>"
lvim.keys.normal_mode["<C-f>"] = false
lvim.keys.normal_mode["<leader>,"] = ":lua vim.lsp.buf.code_action()<CR>"
lvim.keys.insert_mode['<C-BS>'] = "<C-w>"
-- tabs
lvim.keys.normal_mode["<leader>1"] = ":BufferLineGoToBuffer 1<CR>"
lvim.keys.normal_mode["<leader>2"] = ":BufferLineGoToBuffer 2<CR>"
lvim.keys.normal_mode["<leader>3"] = ":BufferLineGoToBuffer 3<CR>"
lvim.keys.normal_mode["<leader>4"] = ":BufferLineGoToBuffer 4<CR>"
lvim.keys.normal_mode["<leader>5"] = ":BufferLineGoToBuffer 5<CR>"
lvim.keys.normal_mode["<leader>6"] = ":BufferLineGoToBuffer 6<CR>"
lvim.keys.normal_mode["<leader>7"] = ":BufferLineGoToBuffer 7<CR>"
lvim.keys.normal_mode["<leader>8"] = ":BufferLineGoToBuffer 8<CR>"
lvim.keys.normal_mode["<leader>9"] = ":BufferLineGoToBuffer 9<CR>"
lvim.keys.normal_mode["<leader>0"] = ":BufferLineGoToBuffer 10<CR>"

-- undo tabs
lvim.keys.insert_mode["<S-Tab>"] = "<C-d>"

-- options
lvim.swapfile = false
lvim.ignorecase = true
-- vim
vim.diagnostic.config({
    virtual_text = false,
})
-- vim.o.tabstop = 4
-- vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.expandtab = true

-- alias(cnoreabbrev)
-- vim.api.nvim_command("cnoreabbrev coc CopilotChat")

