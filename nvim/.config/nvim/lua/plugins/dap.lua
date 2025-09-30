return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.rust = {
      {
        name = "Debug Rust",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = false,
        initCommands = function()
          local commands = {
            "command script import "
              .. vim.fn.stdpath("data")
              .. "/mason/packages/codelldb/extension/lldb_rust_formatters.py",
            "type category enable Rust",
          }
          return commands
        end,
      },
    }

    vim.api.nvim_create_user_command("RustDebugTest", function()
      local cargo_cmd =
        "cargo test --no-run --message-format=json | jq -r 'select(.profile.test == true) | .executable'"
      local handle = io.popen(cargo_cmd)
      if not handle then
        print("Failed to run cargo command.")
        return
      end
      local output = handle:read("*a")
      handle:close()

      local binaries = {}
      for line in output:gmatch("[^\r\n]+") do
        table.insert(binaries, line)
      end

      if #binaries == 0 then
        print("No test binaries found")
        return
      end

      vim.ui.select(binaries, { prompt = "Select Rust test binary to debug" }, function(bin)
        if not bin then
          return
        end

        vim.ui.input({ prompt = "Test name (--exact)? (optional): " }, function(test_name)
          local args = {}
          if test_name and #test_name > 0 then
            table.insert(args, test_name)
            table.insert(args, "--exact")
            table.insert(args, "--nocapture")
          end

          dap.run({
            type = "codelldb",
            request = "launch",
            name = "Debug Rust Test",
            program = bin,
            args = args,
            cwd = vim.fn.getcwd(),
            stopOnEntry = false,
            runInTerminal = false,
          })
        end)
      end)
    end, {})
  end,
}
