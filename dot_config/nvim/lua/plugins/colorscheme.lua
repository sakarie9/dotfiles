return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      transparent_background = true,
      --      styles = {
      --        comments = {},
      --        conditionals = {},
      --        loops = {},
      --        functions = {},
      --        keywords = {},
      --        strings = {},
      --        variables = {},
      --        numbers = {},
      --        booleans = {},
      --        properties = {},
      --        types = {},
      --      },
      --      color_overrides = {},
    },
  },
}
