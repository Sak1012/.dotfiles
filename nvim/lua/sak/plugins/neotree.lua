return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		-- OR setup with some options
		require("nvim-tree").setup({
			vim.keymap.set("n", "tt", ":NvimTreeToggle<CR>", { noremap = true, silent = true }),
			sort = {
				sorter = "case_sensitive",
			},

			view = {
				side="left",
				float = {
					enable = false,
					quit_on_focus_loss = true,
				},
				width = 30,
			},
			renderer = {
				full_name = true,
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})
	end,
}
