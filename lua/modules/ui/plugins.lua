local ui = {}
local conf = require("modules.ui.config")

-- @func: 提供icon
-- @keymap: nil
-- @status: true ---------- all done
ui["kyazdani42/nvim-web-devicons"] = {
    opt = false,
}

-- @func: vim主题
-- @keymap: nil
-- @status: true ---------- all done
ui["morhetz/gruvbox"] = {
    opt = false,
    as = "morhetz",
    config = conf.gruvbox,
}
-- @func: 下方状态栏
-- @keymap: nil
-- @status: true ---------- all done
ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    after = "lualine-lsp-progress",
    config = conf.lualine,
}
-- @func: lualine.nvim的依赖项
-- @keymap: nil
-- @status: true ---------- all done
ui["arkav/lualine-lsp-progress"] = {
    opt = true,
}

-- @func: git 快速操作
-- @keymap: see keymap/init.lua
-- @status: true ---------- all done
ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = { "BufRead", "BufNewFile" },
    config = conf.gitsigns,
    requires = { "nvim-lua/plenary.nvim", opt = true },
}

-- @func: 显示缩进对齐线
-- @keymap: nil
-- @status: true ---------- all done
ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
	event = "BufRead",
	config = conf.indent_blankline,
}

-- @func: 显示上标缓冲区
-- @keymap: <leader>[0-9] | gb | gB
-- @status: true ---------- all done
-- ui["akinsho/nvim-bufferline.lua"] = {
--     opt = true,
--     event = "BufRead",
--     config = conf.nvim_bufferline
-- }

return ui
