-- plugins
lvim.plugins = {
    --{ 'xiyaowong/transparent.nvim', config=true },
    { 'codota/tabnine-nvim' },
}
--lvim.builtin.lualine.style = "default"
lvim.transparent_window = true
lvim.keys.normal_mode["<leader>,"] = ":lua vim.lsp.buf.code_action()<CR>"
vim.api.nvim_set_keymap('i', '<C-H>', '<C-w>', { noremap = true })
--lvim.colorscheme = "tokyonight-storm" -- no transparency so ya
--vim.cmd("set undofile")
--vim.api.nvim_command("set runtimepath+=~/.vim_runtime")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/basic.vim")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/filetypes.vim")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/plugins_config.vim")
vim.api.nvim_command("set runtimepath+=~/.vim_runtime")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/basic.vim")
vim.api.nvim_command("source ~/.vim_runtime/vimrcs/filetypes.vim")
vim.api.nvim_command("source ~/.vim_runtime/vimrcs/plugins_config.vim")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/extended.vim")
vim.api.nvim_command("source ~/.vim_runtime/my_configs.vim")
--vim.api.nvim_command("source $VIMRUNTIME/syntax/syntax.vim")
lvim.ignorecase = true
lvim.swapfile = false
