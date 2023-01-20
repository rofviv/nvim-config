-- au FileType dart,ts,java,c,cpp call rainbow#load()

local setup, rainbow = pcall(require, "rainbow#load")
if not setup then
	return
end

vim.g.rainbow_active = 1

rainbow.setup({
	guifgs = { "royalblue3", "darkorange3", "seagreen3", "firebrick" },
	ctermfgs = { "lightblue", "lightyellow", "lightcyan", "lightmagenta" },
})
-- vim.g.rainbow_load_separately = {
--     '*' , [['(', ')'], ['\[', '\]'], {', ',
--     \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
--     \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
--     \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
-- }
-- vim.g.rainbow_guifgs = { "RoyalBlue3", "DarkOrange3", "DarkOrchid3", "FireBrick" }
-- vim.g.rainbow_ctermfgs = { "lightblue", "lightgreen", "yellow", "red", "magenta" }
