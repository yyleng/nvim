-- @All
-- 与编辑相关的插件配置
-- LearnMap

local editor = {}
local conf = require("modules.editor.config")

-- @func: 自动对齐
-- @keymap: n | ga
-- @status: true ---------- all done
editor["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }

-- @func: 给光标所在的所有相同单词增加下划线
-- @keymap: nil
-- @status: true ---------- all done
editor["itchyny/vim-cursorword"] = {
	opt = true,
	event = { "BufReadPre", "BufNewFile" },
	config = conf.vim_cursorwod,
}

-- @func: 注释(结合使用了nvim_treesitter的子模块)
-- @keymap: n|gcc , v|gc , n|gcip, n|dip
-- @status: true ---------- all done
editor["terrortylor/nvim-comment"] = {
	opt = false,
	config = function()
		require("nvim_comment").setup({
			-- set cpp comment string
			vim.cmd([[augroup set-commentstring-ag]]),
			vim.cmd([[autocmd!]]),
			vim.cmd(
				[[autocmd BufEnter *.c,*.cc,*.cpp,*.hpp,*.h,*.json :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")]]
			),
			vim.cmd(
				[[autocmd BufFilePost *.c,*.cc,*.cpp,*.hpp,*.h,*.json :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")]]
			),
			vim.cmd([[augroup END]]),
		})
	end,
}

-- @func: 高亮集景
-- @keymap: nil
-- @status: true ---------- all done
editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufRead",
	config = conf.nvim_treesitter,
}

-- @func: %跳装匹配的扩展(nvim_treesitter的子模块)
-- @keymap: %(conf.nvim_treesitter的label 4)
-- @status: true ---------- all done
editor["andymass/vim-matchup"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.matchup,
}

-- @func: 加速j/k移动的速度
-- @keymap: j k
-- @status: true ---------- all done
editor["rhysd/accelerated-jk"] = { opt = true }

-- @func: 高亮f/t跳转的位置
-- @keymap: f t F T
-- @status: true ---------- all done
editor["hrsh7th/vim-eft"] = { opt = true }

-- @func: 使用删除键取消搜索高亮时，可以再次搜索，且自动不高亮 (asiryk/auto-hlsearch.nvim)
-- @keymap: n N
-- @status: true ---------- all done
editor["romainl/vim-cool"] = {
	opt = true,
	event = { "CursorMoved", "InsertEnter" },
}

-- @func: 热词跳转，可以跳转到任何想要跳到的地方
-- @keymap: <leader>h | <leader>j | <leader>k | <leader>l
-- @status: true ---------- all done
editor["phaazon/hop.nvim"] = {
	opt = true,
	branch = "v1",
	cmd = {
		"HopLine",
		"HopLineStart",
		"HopWord",
		"HopPattern",
		"HopChar1",
		"HopChar2",
	},
	config = function()
		require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
	end,
}

-- @func: 屏幕滚动
-- @keymap: conf.neoscroll
-- @status: true ---------- all done
editor["karb94/neoscroll.nvim"] = {
	opt = true,
	event = "WinScrolled",
	config = conf.neoscroll,
}

-- @func: vim shell
-- @keymap: <F12> | :vs :sp 是用来打开vim的
-- @status: true ---------- all done
editor["akinsho/nvim-toggleterm.lua"] = {
	opt = true,
	event = "BufRead",
	config = conf.toggleterm,
}

-- @func: 给#ffffff配上颜色
-- @keymap: nil
-- @status: true ---------- all done
editor["norcalli/nvim-colorizer.lua"] = {
	opt = true,
	event = "BufRead",
	config = conf.nvim_colorizer,
}

-- @func: 在vim 中运行 git 命令
-- @keymap: ':Git', ':G' , 'n | <Space>G'
-- @status: true ---------- all done
editor["tpope/vim-fugitive"] = {
	opt = true,
	cmd = { "Git", "G" },
}

-- @func: 修改变量形式
-- @keymap: :'n | crc', 'n | crm', 'n | crs' 最常用，更多用法请查阅帮助手册
-- @status: true ---------- all done
-- @doc: 3
editor["tpope/vim-abolish"] = {
	opt = false,
}

-- @func: 单词切割
-- @keymap: 'v | <alt>e', 'v | <alt>b', 'v | <alt>w' 最常用，更多用法请查阅帮助手册
-- @status: true ---------- all done
-- @doc: 18
editor["chaoren/vim-wordmotion"] = {
	opt = false,
	config = function()
		vim.api.nvim_exec([[source ~/.config/nvim/lua/modules/editor/wordmotion.vim]], false)
	end,
}

-- @func: v V 框选
-- @keymap: v -> 正选, V -> 反选(撤销)
-- @status: true ---------- all done
-- @doc: 41
editor["terryma/vim-expand-region"] = {
	opt = false,
	config = function()
		vim.api.nvim_exec([[source ~/.config/nvim/lua/modules/editor/vim_expand_region.vim]], false)
	end,
}

-- @func: 代码行拆分或合并
-- @keymap: gS -> 拆分, gJ -> 合并
-- @status: true --------- all done
-- @doc: 47
editor["AndrewRadev/splitjoin.vim"] = {
	opt = false,
}

-- @func: 自动调整窗口大小
-- @keymap: <C-w>z -> 最大化 | <C-w>= -> 恢复 | <C-w>| -> 垂直最大化 | <C-w>_ -> 水平最大化
-- @status: true --------- all done
editor["anuvyklack/windows.nvim"] = {
	opt = false,
	requires = {
		"anuvyklack/middleclass",
		"anuvyklack/animation.nvim",
	},
	config = function()
		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false
		require("windows").setup({
			autowidth = {
				--		       |windows.autowidth|
				enable = true,
				winwidth = 50, --		        |width = equal+50|
				filetype = { --	      |windows.autowidth.filetype|
					help = 2,
				},
			},
			-- 忽视文件
			ignore = {
				--			  |windows.ignore|
				buftype = { "quickfix" },
				filetype = { "coc-explorer", "NvimTree", "neo-tree", "undotree", "gundo" },
			},
			-- 展示动画
			animation = {
				enable = true,
				duration = 300,
				fps = 30,
				easing = "in_out_sine",
			},
		})
		local function cmd(command)
			return table.concat({ "<Cmd>", command, "<CR>" })
		end

		vim.keymap.set("n", "<C-w>z", cmd("WindowsMaximize"))
		vim.keymap.set("n", "<C-w>_", cmd("WindowsMaximizeVertically"))
		vim.keymap.set("n", "<C-w>|", cmd("WindowsMaximizeHorizontally"))
		vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"))
	end,
}

-- @func: symbols_outline
-- @keymap: <leader>so -> 打开 | q -> 关闭 | p -> 打开悬浮窗口
-- @status: true --------- all done
editor["liuchengxu/vista.vim"] = {
	opt = false,
	config = function()
		-- lua运行vim配置文件
		vim.api.nvim_exec([[source ~/.config/nvim/lua/modules/editor/vista.vim]], false)
	end,
}

-- @func: highlight symbols
-- @keymap: <F3> -> 打开 | <F4> -> 关闭 | :HSExport -> 导出 | : HSImport -> 导入
-- @status: true --------- all done
editor["Pocco81/HighStr.nvim"] = {
	opt = true,
	ft = { "conf", "vim" },
	config = function()
		-- lua运行vim配置文件
		vim.api.nvim_exec([[source ~/.config/nvim/lua/modules/editor/highlight.vim]], false)
	end,
}

-- @func: translator
-- @keymap: gt -> 翻译 | <c-w>p -> 打开/关闭翻译窗口
-- @status: true --------- all done
editor["voldikss/vim-translator"] = {
	opt = false,
	config = function()
		-- lua运行vim配置文件
		vim.api.nvim_exec([[source ~/.config/nvim/lua/modules/editor/translate.vim]], false)
	end,
}

-- @func: search replace
-- @keymap: <C-r> -> 选中区域搜索替换 | <leader>ro -> 打开搜索替换窗口 | <leader>rw -> 替换光标下的单词 | <leader>re -> 替换光标下的表达式
-- @status: true --------- all done
editor["roobert/search-replace.nvim"] = {
	opt = false,
	config = function()
		require("search-replace").setup({
			-- optionally override defaults
			default_replace_single_buffer_options = "g",
			default_replace_multi_buffer_options = "eg",
		})
		local opts = {}
		vim.api.nvim_set_keymap("v", "<C-r>", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts)

		vim.api.nvim_set_keymap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts)
		vim.api.nvim_set_keymap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
		vim.api.nvim_set_keymap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)

		-- show the effects of a search / replace in a live preview window
		vim.o.inccommand = "split"
	end,
}

-- @func: local translator and spelling
-- @keymap:
-- @status: true --------- all done
editor["JuanZoran/Trans.nvim"] = {
	opt = false,
	run = function()
		require("Trans").install()
	end,
	-- requires = 'kkharji/sqlite.lua',
	config = conf.Trans,
}

return editor
