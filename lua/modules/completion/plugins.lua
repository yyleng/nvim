local completion = {}
local conf = require("modules.completion.config")

completion["neoclide/coc.nvim"] = {
    opt = true,
    event = "BufRead",
    branch = "release",
    config = function()
        -- lua运行vim配置文件
        vim.api.nvim_exec(
            [[source ~/.config/nvim/lua/modules/completion/coc_config.vim]],
            false)
    end
}
completion["github/copilot.vim"] = {
    opt = false,
    -- opt == false, the cmd should be empty
    -- cmd = "Copilot",
    config = function()
        -- lua运行vim配置文件
        vim.api.nvim_exec(
            [[source ~/.config/nvim/lua/modules/completion/copilot.vim]],
            false)
    end
}

completion["CopilotC-Nvim/CopilotChat.nvim"] = {
    opt = false,
    requires = {
        "github/copilot.vim",
        "nvim-lua/plenary.nvim",
    },
    branch = "canary",
	config = conf.copilot_chat,
}

return completion
