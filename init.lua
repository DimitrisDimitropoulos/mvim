require 'options'
require 'mappings'
require 'commands'
require 'lsp'

vim.cmd [[colorscheme melange]]
require 'statusline'

require 'plugins.fzf'
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
  incremental_selection = {
    enable = false,
  },
}

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('LazyEnter', { clear = true }),
  callback = function()
    vim.cmd.packadd 'nvim-lspconfig'
    require 'plugins.lspconfig'
    vim.cmd.packadd 'gitsigns.nvim'
    require 'plugins.signs'
  end,
})
