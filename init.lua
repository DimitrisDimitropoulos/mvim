-- In ~/.config/nvim/init.lua
require("options")
require("mappings")
require("commands")
require("lsp")

vim.cmd("colorscheme melange")
require("statusline")
require("nvim-treesitter.configs").setup({})

require("plugins.fzf")
require("mason").setup({
	ui = { icons = { package_installed = "", package_pending = "", package_uninstalled = "" } },
	PATH = "skip",
	max_concurrent_installers = 20,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("LazyEnter", { clear = true }),
	callback = function()
		vim.cmd.packadd("nvim-lspconfig")
		require("plugins.lspconfig")
		vim.cmd.packadd("gitsigns.nvim")
		require("plugins.signs")
	end,
})
--
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
-- 	group = vim.api.nvim_create_augroup("LazyInsetEnter", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd.packadd([[mini.splitjoin]])
-- 		require("mini.splitjoin").setup()
-- 		vim.cmd.packadd("nvim-cmp")
-- 		vim.cmd.packadd("LuaSnip")
-- 		vim.cmd.packadd("friendly-snippets")
-- 		vim.cmd.packadd("cmp-buffer")
-- 		vim.cmd.packadd("cmp-nvim-lsp")
-- 		vim.cmd.packadd("cmp-path")
-- 		vim.cmd.packadd("cmp-nvim-lsp-signature-help")
-- 		vim.cmd.packadd("cmp_luasnip")
-- 		vim.cmd.packadd("nvim-autopairs")
-- 		require("plugins.luasnip")
-- 		require("nvim-autopairs").setup()
-- 		require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
-- 	end,
-- })
