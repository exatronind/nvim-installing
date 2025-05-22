-- lazy.nvim plugin manager bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { "numToStr/Comment.nvim", opts = {} },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  
  { "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- opcional, mas recomendado
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = false,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    })
  end
  },
  
  -- Linha de baixo definida

  {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- você pode trocar por 'tokyonight', 'gruvbox', etc.
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end
  },

  -- COC (require Node.js instalado)

  {
    "neoclide/coc.nvim",
    branch = "release"
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  },

  -- Tema tokyonight (com opções de estilos)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
      })
    end
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },


  {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- ou "tabs" se preferir tabs de verdade
        diagnostics = "nvim_lsp", -- mostra erros/lint no buffer
        separator_style = "slant", -- opções: "slant" | "thick" | "thin" | { "left", "right" }
        show_close_icon = false,
        show_buffer_close_icons = false,
        always_show_bufferline = true,
      },
    })
    vim.opt.termguicolors = true
  end
}

})

