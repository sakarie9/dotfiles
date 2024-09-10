local HOME = vim.fn.expand("~/.config/nvim/.markdownlint-cli2.yaml")
return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", HOME, "--" },
        },
      },
    },
  },
}
