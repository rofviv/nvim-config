-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	rainbow = {
		enable = true,
		-- colors = {
		-- 	"#2c2c2c",
		-- 	"#ffffff",
		-- 	"#000000",
		-- 	"#ff0000",
		-- },
		extended_mode = true,
		max_file_lines = nil,
	},
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		-- "tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		-- "svelte",
		-- "graphql",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"php",
		"dart",
		"go",
		"vue",
	},
	-- auto install above language parsers
	auto_install = true,
})
