local dap = require("dap")
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup()

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.continue) -- also starts dap.
vim.keymap.set("n", "<LocalLeader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<LocalLeader>dl", dap.run_to_cursor)
vim.keymap.set("n", "<LocalLeader>dq", function() -- quit dap.
  dap.disconnect()
  dap.close()
  dapui.close()
end)
vim.keymap.set("n", "<LocalLeader>dc", function()
  dap.set_breakpoint(vim.fn.input({ prompt = "Break condition: " }))
end)
