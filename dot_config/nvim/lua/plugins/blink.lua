return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap = {
        preset = "default",
      }

      vim.b.completion = true

      Snacks.toggle({
        name = "Completion",
        get = function()
          return vim.b.completion
        end,
        set = function(state)
          vim.b.completion = state
        end,
      }):map("<leader>uk")

      opts.enabled = function()
        return vim.b.completion ~= false
      end
      return opts
    end,
  },
}
