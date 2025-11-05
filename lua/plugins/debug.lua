return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("nvim-dap-virtual-text").setup()

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    vim.keymap.set("n", "<F2>", dap.step_into,
      { desc = "Step into" })
    vim.keymap.set("n", "<F3>", dap.step_over,
      { desc = "Step over" })
    vim.keymap.set("n", "<F4>", dap.step_out,
      { desc = "Step out" })
    vim.keymap.set("n", "<F5>", dap.continue,
      { desc = "Continue" })
    vim.keymap.set("n", "<LocalLeader>db", dap.toggle_breakpoint,
      { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<LocalLeader>dl", dap.run_to_cursor,
      { desc = "Run to cursor" })
    vim.keymap.set("n", "<LocalLeader>dq", function()
      dap.disconnect()
      dap.close()
      dapui.close()
    end,
    { desc = "Quit dap" })
    vim.keymap.set("n", "<LocalLeader>dc", function()
      dap.set_breakpoint(vim.fn.input({ prompt = "Break condition: " }))
    end)
  end
}
