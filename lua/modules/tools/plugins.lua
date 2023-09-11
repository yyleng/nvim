local tools = {}
local conf = require("modules.tools.config")

-- Required by telescope.nvim
tools["RishabhRD/popfix"] = { opt = false }
-- Required by telescope.nvim
tools["nvim-lua/plenary.nvim"] = { opt = false }

-- @func: 包含一系列窗口级的功能
-- @keymap: keymap/init.lua Telescope 模块
-- @status: true ---------- all done
tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    module = "telescope",
    cmd = "Telescope",
    branch = "0.1.x",
    config = conf.telescope,
    requires = {
        {
            "nvim-lua/plenary.nvim",
            opt = false,
        },
        {
            "nvim-lua/popup.nvim",
            opt = true,
        }
    }
}

-- @func: 修改 telescope fzf 规则
-- @keymap: nil
-- @status: true ---------- all done
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim",
}

-- @func: 搜索最近使用的文件
-- @keymap: <Space>fq
-- @status: true ---------- all done
tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    requires = {
        {
            -- @Manually: 需要手动安装 sqlite3-libs 并建立 libsqlite3.so 软链接
            "tami5/sqlite.lua",
            opt = true,
        },
    },
}

-- @func: 命令行模糊搜索以及自动补充
-- @keymap: / | : | ?
-- @status: true ---------- all done
tools["gelguy/wilder.nvim"] = {
    event = "CmdlineEnter",
    config = conf.wilder,
    requires = {
        {
            "romgrk/fzy-lua-native",
            after = "wilder.nvim",
        },
    }
}

-- @func: 调试输出
-- @keymap: g?v | g?V | g?p | g?P
-- @status: true ---------- all done
tools["andrewferrier/debugprint.nvim"] = {
    opt = true,
    ft = {
        "c",
        "cpp",
        "cxx",
        "h",
        "hpp",
        "hxx",
        "lua",
        "py",
        "sh",
        "go",
        "vim",
        "zsh",
    },
    config = conf.debugprint,
}

-- @func: emoji input
-- @keymap: 'i | <A-m>'
-- @status: true ---------- all done
tools["WilsonOh/emoji_picker-nvim"] = {
    opt = true,
    event = "InsertEnter",
    config = function()
        require("emoji_picker").setup()
        vim.keymap.set("i", "<A-m>", "<cmd>EmojiPicker<cr>")
    end,
}

-- @func: show json path in statusline
-- @keymap: y<C-p>
-- @status: true ---------- all done
tools["phelipetls/jsonpath.nvim"] = {
    opt = true,
    ft = "json",
    config = function()
        -- show json path in the winbar
        if vim.fn.exists("+winbar") == 1 then
            vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
        end
        -- send json path to clipboard
        vim.keymap.set("n", "y<C-p>", function()
            vim.fn.setreg("+", require("jsonpath").get())
        end, { desc = "copy json path", buffer = true })
    end,
}

-- @func: open file in github on browser
-- @keymap: :OpenInGHFile | :OpenInGHRepo
-- @status: true ---------- all done
tools["almo7aya/openingh.nvim"] = {
    opt = false,
}

-- @func: color picker
-- @keymap: :CccPick ( hjkl | i | o | a | q | g | w(W) | b(B) | d | s | H | M | L | 1-9)
-- @status: true ---------- all done
-- tools["uga-rosa/ccc.nvim"] = {
--     opt = false,
--     config = function()
--         require("ccc").setup()
--     end,
-- }

-- @func: show nvim register and interactive with it
-- @keymap: "r -> open register | "p("P) -> open register and paste
-- @status: true ---------- all done
-- tools["gennaro-tedesco/nvim-peekup"] = {
--     opt = false,
--     config = function()
--         vim.api.nvim_exec(
--             [[source ~/.config/nvim/lua/modules/tools/register.vim]],
--             false)
--     end
-- }

-- @func: show nvim buffer and interactive with it
-- @keymap: <leader>b
-- @status: true ---------- all done
tools["j-morano/buffer_manager.nvim"] = {
    opt = false,
    requires = {
        {
            "nvim-lua/plenary.nvim",
            opt = false,
        },
    },
    config = function()
        require("buffer_manager").setup()
    end
}

-- @func: generate code image
-- @keymap: v | <c-s> -> copy image to clipboard , v | <c-a> -> save image to file
-- @status: true ---------- all done
-- @requires: silicon(https://github.com/aloxaf/silicon)
-- @requires: mkdir -p $HOME/Pictures/code
tools["narutoxy/silicon.lua"] = {
    opt = false,
    requires = {
        {
            "nvim-lua/plenary.nvim",
            opt = false,
        },
    },
    commit = "3223d26456f728870cacab91662d03bbace6e354",
    config = conf.silicon,
}

-- @func: read text more friendly
-- @keymap: :FSRead | :FSToggle | :FSClear
-- @status: true ---------- all done
-- tools["nullchilly/fsread.nvim"] = {
--     opt = false,
--     config = conf.fsread,
-- }

-- @func: global note for myself
-- @keymap:
-- @status: true ---------- all done
-- tools["JellyApple102/flote.nvim"] = {
--     opt = false,
--     config = conf.flote,
-- }

-- @func: chatgpt
-- @keymap:
-- @status: true ---------- all done
-- tools["jackMort/ChatGPT.nvim"] = {
--     opt = false,
--     requires = {
--         "MunifTanjim/nui.nvim",
--         "nvim-lua/plenary.nvim",
--         "nvim-telescope/telescope.nvim"
--     },
--     config = conf.chatgpt
-- }

-- @func: neoai
-- @keymap:
-- @status: true ---------- all done
-- tools["Bryley/neoai.nvim"] = {
--     opt = false,
--     requires = {
--         "MunifTanjim/nui.nvim",
--     },
--     cmd = {
--         "NeoAI",
--         "NeoAIOpen",
--         "NeoAIClose",
--         "NeoAIToggle",
--         "NeoAIContext",
--         "NeoAIContextOpen",
--         "NeoAIContextClose",
--         "NeoAIInject",
--         "NeoAIInjectCode",
--         "NeoAIInjectContext",
--         "NeoAIInjectContextCode",
--     },
--     config = function()
--         require("neoai").setup({
--             -- Below are the default options, feel free to override what you would like changed
--             ui = {
--                 output_popup_text = "NeoAI",
--                 input_popup_text = "Prompt",
--                 width = 34,               -- As percentage eg. 30%
--                 output_popup_height = 80, -- As percentage eg. 80%
--                 submit = "<Enter>",       -- Key binding to submit the prompt
--             },
--             models = {
--                 {
--                     name = "openai",
--                     model = "gpt-3.5-turbo",
--                     params = nil,
--                 },
--             },
--             -- :put g | :put c
--             register_output = {
--                 ["g"] = function(output)
--                     return output
--                 end,
--                 ["c"] = require("neoai.utils").extract_code_snippets,
--             },
--             inject = {
--                 cutoff_width = 75,
--             },
--             prompts = {
--                 context_prompt = function(context)
--                     return "Hey, I'd like to provide some context for future "
--                         .. "messages. Here is the code/text that I want to refer "
--                         .. "to in our upcoming conversations:\n\n"
--                         .. context
--                 end,
--             },
--             mappings = {
--                 ["select_up"] = "<C-k>",
--                 ["select_down"] = "<C-j>",
--             },
--             open_ai = {
--                 api_key = {
--                     env = "OPENAI_API_KEY",
--                     value = nil,
--                     -- `get` is is a function that retrieves an API key, can be used to override the default method.
--                     -- get = function() ... end
--
--                     -- Here is some code for a function that retrieves an API key. You can use it with
--                     -- the Linux 'pass' application.
--                     -- get = function()
--                     --     local key = vim.fn.system("pass show openai/mytestkey")
--                     --     key = string.gsub(key, "\n", "")
--                     --     return key
--                     -- end,
--                 },
--             },
--             shortcuts = {
--                 {
--                     name = "textify",
--                     key = "<leader>as",
--                     desc = "fix text with AI",
--                     use_context = true,
--                     prompt = [[
--                 Please rewrite the text to make it more readable, clear,
--                 concise, and fix any grammatical, punctuation, or spelling
--                 errors
--             ]],
--                     modes = { "v" },
--                     strip_function = nil,
--                 },
--                 {
--                     name = "gitcommit",
--                     key = "<leader>ac",
--                     desc = "generate git commit message",
--                     use_context = false,
--                     prompt = function()
--                         return [[
--                     Using the following git diff generate a consise and
--                     clear git commit message, with a short title summary
--                     that is 75 characters or less:
--                 ]] .. vim.fn.system("git diff --cached")
--                     end,
--                     modes = { "n" },
--                     strip_function = nil,
--                 },
--             },
--         })
--     end
-- }

-- @func: leetcode
-- @keymap:
-- @status: true ---------- all done
tools["kawre/leetcode.nvim"] = {
    opt = false,
    run = ":TSUpdate html",
    requires = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",
    },
    config = conf.leetcode
}

return tools
