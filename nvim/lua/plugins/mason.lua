return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate", -- optional
	config = function()
		require("mason").setup()
	end,
}
