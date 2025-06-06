return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "bundled_build.lua",
  opts = {
    use_bundled_binary = true,
  },
  config = function(_, opts)
    require("mcphub").setup(opts)
  end,
}
