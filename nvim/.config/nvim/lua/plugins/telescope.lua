vim.api.nvim_set_hl(0, "TelescopePath", { fg = "#B0B0B0" })

local entry_display = require("telescope.pickers.entry_display")
local make_entry = require("telescope.make_entry")

local custom_entry_maker = function(opts)
  opts = opts or {}
  local displayer = entry_display.create({
    separator = ": ",
    items = {
      { remaining = true },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.value.path, "TelescopePath" },
      entry.value.text:gsub("^%s+", ""),
    })
  end

  return function(line)
    local entry = make_entry.gen_from_vimgrep(opts)(line)
    if entry then
      entry.ordinal = entry.filename .. " " .. entry.text
      entry.display = make_display
      entry.value = {
        path = vim.fn.fnamemodify(entry.filename, ":."),
        text = entry.text,
      }
    end
    return entry
  end
end

local live_grep_config = {
  layout_strategy = "vertical",
  path_display = { "smart" },
  wrap_results = true,
  disable_coordinates = true,
  layout_config = {
    horizontal = {
      width = 9999,
      height = 9999,
      prompt_position = "bottom",
      results_width = 0.35,
      preview_width = 0.65,
    },
    vertical = {
      width = 9999,
      height = 9999,
      preview_height = 0.4,
      preview_cutoff = 0,
    },
  },
  entry_maker = custom_entry_maker(),
  attach_mappings = function(_, map)
    map("i", "<C-t>", function(bufnr)
      require("trouble.sources.telescope").open(bufnr)
    end)
    map("n", "<C-t>", function(bufnr)
      require("trouble.sources.telescope").open(bufnr)
    end)
    return true
  end,
}

return {
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "folke/trouble.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("live_grep_args")
          end)
        end,
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          preview = {
            timeout = 250,
          },
        },
      })

      require("telescope").load_extension("live_grep_args")

      vim.keymap.set("n", "<leader>/", function()
        require("telescope").extensions.live_grep_args.live_grep_args(live_grep_config)
      end, { desc = "Live Grep" })

      vim.keymap.set("n", "<leader>/p", function()
        local config = vim.tbl_deep_extend("force", live_grep_config, {
          default_text = vim.fn.getreg("+"):match("^[^\n\r]*"),
          additional_args = function()
            return { "-F" }
          end,
        })
        require("telescope").extensions.live_grep_args.live_grep_args(config)
      end, { desc = "Live Grep (clipboard)" })

      vim.keymap.set("n", "<leader>/r", "<cmd>Telescope resume<cr>", { desc = "Telescope resume" })
    end,
  },
}
