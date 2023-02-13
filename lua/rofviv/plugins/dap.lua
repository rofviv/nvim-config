local setup, dap = pcall(require, "dap")
if not setup then
	return
end

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🚩", texthl = "", linehl = "", numhl = "" })

-- dap.adapters.dart = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { os.getenv("HOME") .. "/dev/Dart-Code/out/dist/debug.js", "flutter" },
-- }
-- dap.configurations.dart = {
-- 	{
-- 		type = "dart",
-- 		request = "launch",
-- 		name = "Launch flutter",
-- 		dartSdkPath = os.getenv("HOME") .. "/dev/flutter/bin/cache/dart-sdk/",
-- 		flutterSdkPath = os.getenv("HOME") .. "/dev/flutter",
-- 		program = "${workspaceFolder}/lib/main.dart",
-- 		cwd = "${workspaceFolder}",
-- 	},
dap.adapters.dart = {
	type = "executable",
	command = "dart",
	-- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
	args = { "debug_adapter" },
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch Dart Program",
		-- The nvim-dap plugin populates this variable with the filename of the current buffer
		program = "${file}",
		-- The nvim-dap plugin populates this variable with the editor's current working directory
		cwd = "${workspaceFolder}",
		args = { "--help" }, -- Note for Dart apps this is args, for Flutter apps toolArgs
	},
}
