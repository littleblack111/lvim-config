-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.colorscheme = "tokyonight-storm"

lvim.plugins = {
    { 'github/copilot.vim' }
}

lvim.transparent_window = true
lvim.ignorecase = true
lvim.keys.normal_mode["<leader>,"] = ":lua vim.lsp.buf.code_action()<CR>"
vim.api.nvim_set_keymap('i', '<C-H>', '<C-w>', { noremap = true })



vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.noexpandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
