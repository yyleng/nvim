local global = require("core.global")
local vim = vim

-- Create cache dir and subs dir
local createdir = function()
	local data_dir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "session",
		global.cache_dir .. "swap",
		global.cache_dir .. "tags",
		global.cache_dir .. "undo",
	}
	-- There only check once that If cache_dir exists
	-- Then I don't want to check subs dir exists
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

local disable_distribution_plugins = function()
	vim.g.loaded_fzf = 1
	vim.g.loaded_gtags = 1
	vim.g.loaded_gzip = 1
	vim.g.loaded_tar = 1
	vim.g.loaded_tarPlugin = 1
	vim.g.loaded_zip = 1
	vim.g.loaded_zipPlugin = 1
	vim.g.loaded_getscript = 1
	vim.g.loaded_getscriptPlugin = 1
	vim.g.loaded_vimball = 1
	vim.g.loaded_vimballPlugin = 1
	vim.g.loaded_matchit = 1
	vim.g.loaded_matchparen = 1
	vim.g.loaded_2html_plugin = 1
	vim.g.loaded_logiPat = 1
	vim.g.loaded_rrhelper = 1
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.loaded_netrwSettings = 1
	vim.g.loaded_netrwFileHandlers = 1
end

local leader_map = function()
	-- <leader>
	vim.g.mapleader = ";"
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

code_annotation_for_code = function()
	-- get current line
	local line = vim.api.nvim_get_current_line()
	-- set current line
	vim.api.nvim_set_current_line(line .. "// @Annotation: ")
end

code_brief_for_function = function()
	-- get current line
	local line = vim.api.nvim_get_current_line()
	-- set current line
	vim.api.nvim_set_current_line(line .. "// @Brief: ")
end

local load_core = function()
	local pack = require("core.pack")
	createdir()
	disable_distribution_plugins()
	leader_map()

	-- set map to call code_annotation_for_function
	vim.api.nvim_set_keymap("n", "<leader>ca", "O<ESC>:lua code_annotation_for_code()<CR>A", { noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>cb", "O<ESC>:lua code_brief_for_function()<CR>A", { noremap = true })

	pack.ensure_plugins()
	vim.g.gruvbox_contrast_dark = "hard"
	-- 默认主题
	vim.cmd([[colorscheme gruvbox]])
	require("core.options")
	require("core.mapping")
	require("keymap")
	require("core.event")
	pack.load_compile()
end

load_core()
