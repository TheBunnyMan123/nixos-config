vim.o.timeout = true
vim.o.timeoutlen = 500

vim.g.mapleader = " "

local wk = require("which-key")
wk.add { "<leader>tr", ":NvimTreeFocus<CR>", desc = "File Tree" }
wk.add { "<leader>ctr", ":NvimTreeClose<CR>", desc = "Close File Tree" }

wk.add { "<leader>ex", ":Ex<CR>", desc = "File Explorer" }

wk.add { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" }
wk.add { "<leader>gf", ":Telescope git_files<CR>", desc = "Git Files" }
wk.add { "<leader>bf", ":buffers<CR>", desc = "Buffers" }
wk.add { "<leader>ut", ":UndotreeToggle<CR>", desc = "Toggle Undo Tree" }

