lvim.colorscheme = "tokyonight"
lvim.transparent_window = true

lvim.plugins = {
    {
        'xiyaowong/transparent.nvim',
        config = function()
            require("transparent").setup({
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = {
                    "NormalFloat",
                    "NvimTreeNormal",
                }, -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    },
    { 'github/copilot.vim' },
    {
        'gen740/SmoothCursor.nvim',
        config = function()
            require('smoothcursor').setup({
                type = "default",           -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

                cursor = "",              -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
                texthl = "SmoothCursor",   -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
                linehl = nil,              -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

                fancy = {
                    enable = false,        -- enable fancy mode
                    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
                    body = {
                        { cursor = "󰝥", texthl = "SmoothCursorRed" },
                        { cursor = "󰝥", texthl = "SmoothCursorOrange" },
                        { cursor = "●", texthl = "SmoothCursorYellow" },
                        { cursor = "●", texthl = "SmoothCursorGreen" },
                        { cursor = "•", texthl = "SmoothCursorAqua" },
                        { cursor = ".", texthl = "SmoothCursorBlue" },
                        { cursor = ".", texthl = "SmoothCursorPurple" },
                    },
                    tail = { cursor = nil, texthl = "SmoothCursor" } -- false to disable fancy tail
                },

                matrix = {  -- Loaded when 'type' is set to "matrix"
                    head = {
                        -- Picks a random character from this list for the cursor text
                        cursor = require('smoothcursor.matrix_chars'),
                        -- Picks a random highlight from this list for the cursor text
                        texthl = {
                            'SmoothCursor',
                        },
                        linehl = nil,  -- No line highlight for the head
                    },
                    body = {
                        length = 6,  -- Specifies the length of the cursor body
                        -- Picks a random character from this list for the cursor body text
                        cursor = require('smoothcursor.matrix_chars'),
                        -- Picks a random highlight from this list for each segment of the cursor body
                        texthl = {
                            'SmoothCursorGreen',
                        },
                    },
                    tail = {
                        -- Picks a random character from this list for the cursor tail (if any)
                        cursor = nil,
                        -- Picks a random highlight from this list for the cursor tail
                        texthl = {
                            'SmoothCursor',
                        },
                    },
                    unstop = false,  -- Determines if the cursor should stop or not (false means it will stop)
                },

                autostart = true,           -- Automatically start SmoothCursor
                always_redraw = true,       -- Redraw the screen on each update
                flyin_effect = nil,         -- Choose "bottom" or "top" for flying effect
                speed = 25,                 -- Max speed is 100 to stick with your current position
                intervals = 35,             -- Update intervals in milliseconds
                priority = 10,              -- Set marker priority
                timeout = 3000,             -- Timeout for animations in milliseconds
                threshold = 3,              -- Animate only if cursor moves more than this many lines
                max_threshold = nil,         -- If you move more than this many lines, don't animate (if `nil`, deactivate check)
                disable_float_win = false,  -- Disable in floating windows
                enabled_filetypes = nil,    -- Enable only for specific file types, e.g., { "lua", "vim" }
                disabled_filetypes = nil,   -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
                -- Show the position of the latest input mode positions. 
                -- A value of "enter" means the position will be updated when entering the mode.
                -- A value of "leave" means the position will be updated when leaving the mode.
                -- `nil` = disabled
                show_last_positions = nil,
            })
        end
    },
    { "CRAG666/code_runner.nvim", config = true },
    {
        'echasnovski/mini.nvim', version = '*',
        config = function()
            local animate = require('mini.animate')
            animate.setup({
                cursor = {
                    timing = animate.gen_timing.linear({ duration = 100, unit='total' }),
                },
                scroll = { enable = false }
            })

        end
    },
}

lvim.autocommands = {
    {
      "BufReadPost",
      {
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

lvim.keys.normal_mode["<leader>r"] = ":RunFile<CR>"
lvim.keys.normal_mode["<leader>sr"] = ":'<,'>SnipRun<CR>"

lvim.keys.normal_mode["<leader>,"] = vim.lsp.buf.code_action()
-- lvim.keys.normal_mode["<C-f>"] = vim.lsp.buf.
lvim.swapfile = false

lvim.ignorecase = true
lvim.keys.insert_mode['<C-BS>'] = "<C-w>"
--vim.api.nvim_set_keymap('i', '<C-w>', '<C-o>db', { noremap = true })

-- lvim.builtin.which_key.mappings['<Tab>'] = {}
-- lvim.builtin.cmp.mapping['<Tab>'] = {}
lvim.builtin.cmp.mapping['<S-Tab>'] = {}
lvim.builtin.cmp.mapping['<C-Space>'] = {}
-- confirm lsp
-- lvim.builtin.cmp.mapping['C-y'] = 


vim.o.tabstop = 4
vim.o.shiftwidth = 4
-- vim.o.noexpandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.relativenumber = true
