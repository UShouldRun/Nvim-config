-- Bootstrap packer on fresh machines
local function ensure_packer()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'everblush/nvim',
    as = 'everblush',
    config = function()
      vim.cmd('colorscheme everblush')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
  }
  use('ThePrimeagen/harpoon')
  use('lervag/vimtex')

  use {
    'chomosuke/typst-preview.nvim',
    tag = 'v1.*',
    config = function()
      require 'typst-preview'.setup {}
    end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

