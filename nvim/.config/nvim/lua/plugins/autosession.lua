return {
  "rmagatti/auto-session",
  lazy = false,
  init = function()
    vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
  },
}
