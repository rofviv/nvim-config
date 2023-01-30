local setup, nvimwebicons = pcall(require, "nvim-web-devicons")
if not setup then
	return
end

nvimwebicons.setup({
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh",
		},
	},
	color_icons = true,
	default = true,
})
