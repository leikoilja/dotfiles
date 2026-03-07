return {
  "pwntester/octo.nvim",
  opts = function(_, opts)
    vim.treesitter.language.register("markdown", "octo")

    -- fzf-lua is broken
    -- https://github.com/pwntester/octo.nvim/issues/1367
    -- opts.picker = "fzf-lua"
    opts.picker = "snacks"

    opts.suppress_missing_scope = {
      projects_v2 = true,
    }
    opts.users = "mentionable"

    -- Keep some empty windows in sessions
    vim.api.nvim_create_autocmd("ExitPre", {
      group = vim.api.nvim_create_augroup("octo_exit_pre", { clear = true }),
      callback = function(ev)
        local keep = { "octo" }
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.tbl_contains(keep, vim.bo[buf].filetype) then
            vim.bo[buf].buftype = "" -- set buftype to empty to keep the window
          end
        end
      end,
    })
  end,
}