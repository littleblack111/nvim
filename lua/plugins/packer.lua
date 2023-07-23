-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --  use ('hrsh7th/cmp-nvim-lsp')
  --use ('EtiamNullam/deferred-clipboard.nvim')
  use ('xiyaowong/transparent.nvim')
  use ('williamboman/nvim-lsp-installer')
  --use ('tzachar/cmp-tabnine')
  ----
  use ('neovim/nvim-lspconfig')
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
	    -- LSP Support
	    {'neovim/nvim-lspconfig'},             -- Required
	    {                                      -- Optional
	      'williamboman/mason.nvim',
	      run = function()
		pcall(vim.cmd, 'MasonUpdate')
	      end,
	    },
	    {'williamboman/mason-lspconfig.nvim'}, -- Optional

	    -- Autocompletion
	    {'hrsh7th/nvim-cmp'},     -- Required
	    {'hrsh7th/cmp-nvim-lsp'}, -- Required
	    {'L3MON4D3/LuaSnip'},     -- Required
	  }
  }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'ojroques/nvim-lspfuzzy' }
    use {
      'folke/lazy.nvim',
      lazy = true,
      dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },

  }
  use 'RRethy/vim-illuminate'
--
  use {
  	'nvim-telescope/telescope.nvim', tag = '0.1.1',
	-- or                            , branch = '0.1.x',
  	requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'folke/tokyonight.nvim'
  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  --use 'nvim-treesitter/nvim-treesitter-context'
  use ('nvim-treesitter/playground')
  use { 'm-demare/hlargs.nvim' }
  use ('nvim-treesitter/nvim-treesitter-textobjects')
  use ('RRethy/nvim-treesitter-textsubjects')
  use ('mbbill/undotree')
  -- use ('theprimeagen/harpoon')
  use ('tpope/vim-fugitive')
  use ('folke/trouble.nvim')
  --cmd = 'TroubleToggle'
  use ('codota/tabnine-nvim')
  use ('pwntester/octo.nvim')
  use ('pwntester/codeql.nvim')
  use ('ldelossa/gh.nvim')
  use ('hrsh7th/nvim-cmp')
  use ( 'hrsh7th/nvim-compe' )
  use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }
  --use 'honza/vim-snippets'


  use { 'nvim-tree/nvim-web-devicons' }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  --use 'akinsho/bufferline.nvim'
  use("tiagovla/scope.nvim")
  use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
  }

  use("loctvl842/breadcrumb.nvim")

  use 'nvim-tree/nvim-tree.lua'
  --use 'ranjithshegde/ccls.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'jiangmiao/auto-pairs'
  --use {'neoclide/coc.nvim', branch = 'release'}


  --require('packer').startup(function(use)
    --use('Bekaboo/dropbar.nvim')
  --end)
--  use({
--    'glepnir/galaxyline.nvim',
--    branch = 'main',
--    -- your statusline
--    config = function()
--      require('my_statusline')
--    end,
--    -- some optional icons
--    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
--  })

end)


