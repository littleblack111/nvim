return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup {
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
                { find = "%d fewer lines" },
                { find = "%d more lines" },
              },
            },
            opts = { skip = true },
          },
        },
        lsp = {
          signature = {
            enabled = false,
          },
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
