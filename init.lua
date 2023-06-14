require("custom")

--local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
--vim.api.nvim_create_autocmd('BufWritePost packer.lua', {
--    command = 'source | PackerCompile',
--    group = packer_group,
--})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

--Plug 'https://github.com/vim-airline/vim-airline'
--Plug 'preservim/nerdtree'
Plug 'http://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/lifepillar/pgsql.vim'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
--Plug 'https://github.com/neoclide/coc.nvim'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/terryma/vim-multiple-cursors'


vim.call('plug#end')


