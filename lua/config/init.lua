vim.api.colorscheme = "tokyonight-storm"
--vim.cmd("set undofile")
--vim.api.nvim_command("set runtimepath+=~/.vim_runtime")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/basic.vim")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/filetypes.vim")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/plugins_config.vim")
vim.api.nvim_set_hl(0, 'LineNr', { fg = "white"})
vim.api.nvim_command("set runtimepath+=~/.vim_runtime")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/basic.vim")
vim.api.nvim_command("source ~/.vim_runtime/vimrcs/filetypes.vim")
vim.api.nvim_command("source ~/.vim_runtime/vimrcs/plugins_config.vim")
--vim.api.nvim_command("source ~/.vim_runtime/vimrcs/extended.vim")
vim.api.nvim_command("source ~/.vim_runtime/my_configs.vim")
vim.api.nvim_command("source $VIMRUNTIME/syntax/syntax.vim")
vim.opt.ignorecase = true
vim.opt.swapfile = false
