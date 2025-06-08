-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>fj", ":%!jq .<CR>", { desc = "Format JSON with jq" })
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select all" })
