-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local setup, flutter = pcall(require, "flutter-tools")
if not setup then
	return
end

local keymap = vim.keymap -- for conciseness

local opts = { noremap = true, silent = true }
keymap.set("n", "<space>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set("n", "<space>ld", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
keymap.set("n", "<space>la", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
keymap.set("n", "[D", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap.set("n", "]D", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mapping
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", bufopts)
	keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", bufopts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
	-- keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	-- keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", bufopts)
	-- keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	-- keymap.set("n", "<leader>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>", bufopts)
	-- keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts)
	-- keymap.set("n", "gr", vim.lfp.buf.references, bufopts)
	keymap.set("n", "<leader>fm", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = "??? ", Warn = "??? ", Hint = "??? ", Info = "??? " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure python
lspconfig["pyright"].setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure intelephense
lspconfig["intelephense"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "php" },
})

lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure vue server
lspconfig["volar"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure eslint
-- lspconfig["eslint"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure lua server (with special settings)
-- lspconfig["sumneko_lua"].setup({
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

flutter.setup({
	ui = {
		-- the border type to use for all floating windows, the same options/formats
		-- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
		border = "rounded",
		-- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
		-- please note that this option is eventually going to be deprecated and users will need to
		-- depend on plugins like `nvim-notify` instead.
		-- notification_style = "native" | "plugin",
		notification_style = "plugin",
	},
	decorations = {
		statusline = {
			-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
			-- this will show the current version of the flutter app from the pubspec.yaml file
			app_version = false,
			-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
			-- this will show the currently running device if an application was started with a specific
			-- device
			device = true,
		},
	},
	debugger = { -- integrate with nvim dap + install dart code debugger
		enabled = true,
		run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
		-- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
		-- see |:help dap.set_exception_breakpoints()| for more info
		-- exception_breakpoints = {},
		-- register_configurations = function(paths)
		--   require("dap").configurations.dart = {
		--     <put here config that you would find in .vscode/launch.json>
		--   }
		-- end,
	},
	flutter_path = "/Users/rofviv/dev/flutter/bin/flutter", -- <-- this takes priority over the lookup
	-- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
	fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
	widget_guides = {
		enabled = false,
	},
	closing_tags = {
		-- highlight = "ErrorMsg", -- highlight for the closing tag
		highlight = "EndOfBuffer", -- highlight for the closing tag
		prefix = " // ", -- character to use for close tag e.g. > Widget
		enabled = true, -- set to false to disable
	},
	dev_log = {
		enabled = true,
		open_cmd = "tabedit", -- command to use to open the log buffer
	},
	dev_tools = {
		autostart = false, -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	outline = {
		open_cmd = "30vnew", -- command to use to open the outline buffer
		auto_open = false, -- if true this will open the outline automatically when it is first populated
	},
	lsp = {
		color = { -- show the derived colours for dart variables
			enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
			background = false, -- highlight the background
			foreground = false, -- highlight the foreground
			virtual_text = true, -- show the highlight using virtual text
			virtual_text_str = "???", -- the virtual text character to highlight
		},
		on_attach = on_attach,
		capabilities = capabilities, -- e.g. lsp_status capabilities
		-- --- OR you can specify a function to deactivate or change or control how the config is created
		-- capabilities = function(config)
		--   config.specificThingIDontWant = false
		--   return config
		-- end,
		-- see the link below for details on each option:
		-- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
		settings = {
			showTodos = false,
			completeFunctionCalls = true,
			analysisExcludedFolders = {},
			renameFilesWithClasses = "prompt", -- "always"
			enableSnippets = true,
		},
	},
})
