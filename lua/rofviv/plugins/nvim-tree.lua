local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
vim.cmd([[ highlight NvimTreeGitNew guifg=#00C300 ]])
vim.cmd([[ highlight NvimTreeGitDirty guifg=#C7C400 ]])

nvimtree.setup({
	-- change folder arrow icons
	renderer = {
		highlight_git = true,
		icons = {
			git_placement = "signcolumn",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				modified = true,
			},
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
				git = {
					-- unstaged = "✗",
					unstaged = "＊",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "+̶",
					-- deleted = "",
					deleted = "✗",
					ignored = "◌",
				},
			},
		},
	},
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
