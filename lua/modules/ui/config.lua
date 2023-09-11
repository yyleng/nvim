local config = {}

function config.lualine()
    local symbols_outline = {
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'filetype' },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' }
        },
        filetypes = { 'Outline' }
    }

    require("lualine").setup {
        options = {
            icons_enabled = true,
            theme = "gruvbox",
            disabled_filetypes = {},
            component_separators = "|",
            section_separators = { left = "", right = "" }
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "branch" }, { "diff" } },
            lualine_c = {
                { "lsp_progress" }
            },
            lualine_x = {
                {
                    "diagnostics",
                    sources = { 'nvim_diagnostic' },
                    symbols = { error = " ", warn = " ", info = " " }
                }
            },
            lualine_y = { "filetype", "encoding", "fileformat" },
            lualine_z = { "progress", "location" }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {
            "quickfix", "nvim-tree", "toggleterm", "fugitive", symbols_outline
        }
    }
end

-- function config.nvim_bufferline()
--     require("bufferline").setup {
--         options = {
--             number = "none",
--             modified_icon = "✥",
--             buffer_close_icon = "",
--             left_trunc_marker = "",
--             right_trunc_marker = "",
--             max_name_length = 14,
--             max_prefix_length = 13,
--             tab_size = 20,
--             show_buffer_close_icons = true,
--             show_buffer_icons = true,
--             show_tab_indicators = true,
--             diagnostics = "nvim_lsp",
--             always_show_bufferline = true,
--             separator_style = "thin",
--             offsets = {
--                 {
--                     filetype = "NvimTree",
--                     text = "File Explorer",
--                     text_align = "center",
--                     padding = 1
--                 }
--             }
--         }
--     }
-- end

function config.gitsigns()
    require('gitsigns').setup {
        signs                        = {
            add          = { text = 'A' },
            change       = { text = 'M' },
            delete       = { text = 'D' },
            topdelete    = { text = 'D' },
            changedelete = { text = 'D' },
            untracked    = { text = 'U' },
        },
        signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil, -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
    }
end

function config.indent_blankline()
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }
    require("ibl").setup { scope = { highlight = highlight } }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

function config.gruvbox()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd [[colorscheme gruvbox]]
    vim.cmd [[highlight link Operator GruvboxRed]]
    vim.cmd [[highlight link CocExplorerFileDiagnosticWarning None]]
    vim.cmd [[highlight link CocExplorerFileDiagnosticError None]]
    vim.cmd [[highlight link TelescopeSelection SignColumn]]
end

return config
