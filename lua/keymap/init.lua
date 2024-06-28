-- 插件的快捷键映射在这里
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
require("keymap.config")

local plug_map = {
    -- buffer ui
    ["n|<leader>b"] = map_cr("lua require('buffer_manager.ui').toggle_quick_menu()"):with_noremap():with_silent(),
    -- git alternative (parent ] key only for git)
    ["n|]d"] = map_cr("Gitsigns diffthis"):with_noremap():with_silent(),
    ["n|[g"] = map_cr("Gitsigns prev_hunk"):with_noremap():with_silent(),
    ["n|]g"] = map_cr("Gitsigns next_hunk"):with_noremap():with_silent(),
    ["n|]s"] = map_cr("Gitsigns stage_hunk"):with_noremap():with_silent(),
    ["n|]u"] = map_cr("Gitsigns undo_stage_hunk"):with_noremap():with_silent(),
    ["n|]ph"] = map_cr("Gitsigns preview_hunk"):with_noremap():with_silent(),
    ["n|]b"] = map_cr("Gitsigns blame_line"):with_noremap():with_silent(),
    ["n|]a"] = map_cr("Gitsigns select_hunk"):with_noremap():with_silent(),
    ["n|]r"] = map_cr("Gitsigns reset_hunk"):with_noremap():with_silent(),
    ["n|]f"] = map_cr("CocCommand git.foldUnchanged"):with_noremap():with_silent(),
    ["n|]ch"] = map_cr("CocCommand git.keepCurrent"):with_noremap():with_silent(),
    ["n|]co"] = map_cr("CocCommand git.keepIncoming"):with_noremap():with_silent(),
    ["n|<Leader>G"] = map_cu("Git"):with_noremap():with_silent(),
    ["n|]ps"] = map_cr("G push"):with_noremap():with_silent(),
    ["n|]pl"] = map_cr("G pull"):with_noremap():with_silent(),
    -- symbols_outline
    ["n|<leader>so"] = map_cr("Vista"):with_noremap():with_silent(),
    -- Plugin Telescope
    ["n|<Leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent(),
    ["n|<Leader>fw"] = map_cu("Telescope grep_string"):with_noremap():with_silent(),
    ["n|<Leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent(),
    ["n|<Leader>fg"] = map_cu("Telescope live_grep"):with_noremap(),
    ["n|<Leader>fk"] = map_cu("Telescope keymaps"):with_noremap():with_silent(),
    ["n|<Leader>fh"] = map_cu("Telescope help_tags"):with_noremap():with_silent(),
    ["n|<Leader>fq"] = map_cu("Telescope frecency"):with_noremap():with_silent(),
    ["n|<Leader>ft"] = map_cu("Telescope treesitter"):with_noremap():with_silent(),
    ["n|<Leader>gf"] = map_cu("Telescope git_files"):with_noremap(),
    ["n|<Leader>gc"] = map_cu("Telescope git_commits"):with_noremap(),
    ["n|<Leader>gb"] = map_cu("Telescope git_branch"):with_noremap(),
    ["n|<Leader>bi"] = map_cu("Telescope builtin"):with_noremap():with_silent(),
    ["n|<Leader>ch"] = map_cu("Telescope command_history"):with_noremap():with_silent(),
    ["n|<Leader>sh"] = map_cu("Telescope search_history"):with_noremap():with_silent(),
    ["n|<Leader>cc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent(),
    -- Plugin accelerate-jk
    ["n|j"] = map_cmd("v:lua.enhance_jk_move('j')"):with_silent():with_expr(),
    ["n|k"] = map_cmd("v:lua.enhance_jk_move('k')"):with_silent():with_expr(),
    -- Plugin vim-eft
    ["n|f"] = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["n|F"] = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["n|t"] = map_cmd("v:lua.enhance_ft_move('t')"):with_expr(),
    ["n|T"] = map_cmd("v:lua.enhance_ft_move('T')"):with_expr(),
    -- Plugin Hop
    ["n|<leader>h"] = map_cu("HopWord"):with_noremap(),
    ["n|<leader>j"] = map_cu("HopLine"):with_noremap(),
    ["n|<leader>k"] = map_cu("HopChar1"):with_noremap(),
    ["n|<leader>l"] = map_cu("HopChar2"):with_noremap(),
    -- Plugin EasyAlign
    ["n|ga"] = map_cmd("v:lua.enhance_align('nga')"):with_expr(),
    ["x|ga"] = map_cmd("v:lua.enhance_align('xga')"):with_expr(),
    -- Plugin auto_session
    ["n|<leader>ss"] = map_cu("SaveSession"):with_noremap():with_silent(),
    ["n|<leader>sr"] = map_cu("RestoreSession"):with_noremap():with_silent(),
    ["n|<leader>sd"] = map_cu("DeleteSession"):with_noremap():with_silent(),
    -- Plugin dap
    ["n|<F6>"] = map_cr("lua require('dap').continue()"):with_noremap():with_silent(),
    ["n|<leader>dr"] = map_cr("lua require('dap').continue()"):with_noremap():with_silent(),
    ["n|<leader>dd"] = map_cr("lua require('dap').terminate() require('dapui').close()"):with_noremap():with_silent(),
    ["n|<leader>db"] = map_cr("lua require('dap').toggle_breakpoint()"):with_noremap():with_silent(),
    ["n|<leader>dB"] = map_cr("lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))")
        :with_noremap()
        :with_silent(),
    ["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_noremap():with_silent(),
    ["n|<leader>drc"] = map_cr("lua require('dap').run_to_cursor()"):with_noremap():with_silent(),
    ["n|<leader>drl"] = map_cr("lua require('dap').run_last()"):with_noremap():with_silent(),
    ["n|<F9>"] = map_cr("lua require('dap').step_over()"):with_noremap():with_silent(),
    ["n|<leader>dv"] = map_cr("lua require('dap').step_over()"):with_noremap():with_silent(),
    ["n|<F10>"] = map_cr("lua require('dap').step_into()"):with_noremap():with_silent(),
    ["n|<leader>di"] = map_cr("lua require('dap').step_into()"):with_noremap():with_silent(),
    ["n|<F11>"] = map_cr("lua require('dap').step_out()"):with_noremap():with_silent(),
    ["n|<leader>do"] = map_cr("lua require('dap').step_out()"):with_noremap():with_silent(),
    ["n|<leader>dl"] = map_cr("lua require('dap').repl.open()"):with_noremap():with_silent(),
    -- Plugin CopilotChat
    ["n|]cc"] = map_cr("CopilotChat"):with_noremap():with_silent(),

}

bind.nvim_load_mapping(plug_map)
