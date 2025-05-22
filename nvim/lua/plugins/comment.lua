return {
  "numToStr/Comment.nvim",
  event = "VeryLazy", -- carrega automaticamente quando necessário
  config = function()
    require("Comment").setup()
  end
}

