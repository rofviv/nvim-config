local setup, dap = pcall(require, "dap")
if not setup then
	return
end

vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "S", texthl = "", linehl = "", numhl = "" })

dap.adapters.dart = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/dev/Dart-Code/out/dist/debug.js", "flutter" },
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch flutter",
		dartSdkPath = os.getenv("HOME") .. "/dev/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = os.getenv("HOME") .. "/dev/flutter",
		program = "${workspaceFolder}/lib/main.dart",
		cwd = "${workspaceFolder}",
	},
}
