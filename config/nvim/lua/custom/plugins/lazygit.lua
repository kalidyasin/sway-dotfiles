-- lazygit packege

return {

  "kdheepak/lazygit.nvim",
  dependencies =  {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit Show" },
  },
  config = function()
    require("telescope").load_extension("lazygit")
  end
}
