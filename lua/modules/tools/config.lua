local config = {}

function config.telescope()
    vim.cmd([[packadd telescope-fzf-native.nvim]])
    vim.cmd([[packadd sqlite.lua]])
    vim.cmd([[packadd telescope-frecency.nvim]])

    require("telescope").setup {
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            layout_strategy = "horizontal",
            prompt_prefix = "🔍 ",
            selection_caret = " ",
            layout_config = {
                prompt_position = "bottom",
                horizontal = {
                    preview_width = 0.5,
                },
            },
            entry_prefix = '',
            initial_mode = "insert",
            path_display = { "absolute" },
            file_ignore_patterns = {},
            -- mapping config ( all here )
            mappings = {
                i = {
                    ["<C-/>"] = "which_key",
                    ["<esc>"] = "close",
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-p>"] = "move_to_top",
                    ["<C-n>"] = "move_to_bottom",
                    ["<C-b"] = "preview_scrolling_up",
                    ["<C-d>"] = "preview_scrolling_down",
                    ["<C-c>"] = false,
                    ["<Up>"] = false,
                    ["<Down>"] = false,
                    ["<PageDown>"] = false,
                    ["<PageUp>"] = false,
                    ["<C-x>"] = "select_horizontal",
                    ["<C-v>"] = "select_vertical",
                    ["<C-t>"] = "select_tab",
                    ["<M-q>"] = false,
                    ["<C-q>"] = false,
                    ["<C-l>"] = false,
                },
            }
        },
        pickers = {
            colorscheme = {
                enable_preview = true,
            },
            -------git_commits
            -- - `<cr>`: checks out the currently selected commit
            -- - `<C-r>m`: resets current branch to selected commit using mixed mode
            -- - `<C-r>s`: resets current branch to selected commit using soft mode
            -- - `<C-r>h`: resets current branch to selected commit using hard mode
            -------git_status
            -- - `<Tab>`: stages or unstages the currently selected file
            -- - `<cr>`: opens the currently selected file


        },
        -- extensions config
        extensions = {
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            fzf = {
                fuzzy = false,                  -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
            },
        },
    }
    require('telescope').load_extension('fzf')
    require("telescope").load_extension("frecency")
end

function config.wilder()
    local wilder = require('wilder')
    wilder.setup({ modes = { ':', '/', '?' } })
    -- Disable Python remote plugin
    wilder.set_option('use_python_remote_plugin', 0)

    wilder.set_option('pipeline', {
        wilder.branch(
            wilder.cmdline_pipeline({
                fuzzy = 1,
                fuzzy_filter = wilder.lua_fzy_filter(),
            }),
            wilder.vim_search_pipeline()
        )
    })

    wilder.set_option('renderer', wilder.renderer_mux({
        [':'] = wilder.popupmenu_renderer({
            highlighter = wilder.lua_fzy_highlighter(),
            left = {
                ' ',
                wilder.popupmenu_devicons()
            },
            right = {
                ' ',
                wilder.popupmenu_scrollbar()
            },
        }),
        ['/'] = wilder.wildmenu_renderer({
            highlighter = wilder.lua_fzy_highlighter(),
        }),
    }))
    -- -- set up basic
    -- local wilder = require('wilder')
    -- wilder.setup({ modes = { ':', '/', '?' } })
    --
    -- -- vim command set up fzf
    -- wilder.set_option('pipeline', {
    --     wilder.branch(
    --     -- vim commamd file or directory fzf
    --         wilder.python_file_finder_pipeline({
    --             -- to use ripgrep : {'rg', '--files'}
    --             -- to use fd      : {'fd', '-tf'}
    --             -- file_command = { 'find', '.', '-type', 'f', '-printf', '%P\n' },
    --             file_command = { 'rg', '--files' },
    --             -- to use fd      : {'fd', '-td'}
    --             -- dir_command = { 'find', '.', '-type', 'd', '-printf', '%P\n' },
    --             dir_command = { 'fd', '-td' },
    --             -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
    --             -- found at https://github.com/nixprime/cpsm
    --             filters = { 'fuzzy_filter', 'difflib_sorter' },
    --         }),
    --         wilder.substitute_pipeline({
    --             pipeline = wilder.python_search_pipeline({
    --                 skip_cmdtype_check = 1,
    --                 pattern = wilder.python_fuzzy_pattern({
    --                     start_at_boundary = 0,
    --                 }),
    --             }),
    --         }),
    --         wilder.cmdline_pipeline({
    --             fuzzy = 2,
    --             fuzzy_filter = wilder.lua_fzy_filter(),
    --         }),
    --         {
    --             wilder.check(function(ctx, x) return x == '' end),
    --             wilder.history(),
    --         },
    --         wilder.python_search_pipeline({
    --             pattern = wilder.python_fuzzy_pattern({
    --                 start_at_boundary = 0,
    --             }),
    --         })
    --     ),
    -- })
    -- -- set pop menu
    -- local gradient = {
    --     '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
    --     '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
    --     '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
    --     '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
    -- }
    --
    -- for i, fg in ipairs(gradient) do
    --     gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = fg } })
    -- end
    -- wilder.set_option('renderer', wilder.popupmenu_renderer({
    --     -- highlighter = wilder.basic_highlighter(),
    --     highlights = {
    --         gradient = gradient, -- must be set
    --         -- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
    --     },
    --     highlighter = wilder.highlighter_with_gradient({
    --         -- wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
    --         wilder.lua_fzy_highlighter(),
    --     }),
    --     left = { ' ', wilder.popupmenu_devicons() },
    --     right = { ' ', wilder.popupmenu_scrollbar() },
    -- }))
end

function config.debugprint()
    require("debugprint").setup()
end

function config.silicon()
    require('silicon').setup({
        theme = "auto",
        output = "/home/aico/Pictures/code/Aico_$year-$month-$date-$time.png",
        bgColor = vim.g.terminal_color_5,
        bgImage = "", -- path to image, must be png
        roundCorner = true,
        windowControls = true,
        lineNumber = true,
        font = "monospace",
        lineOffset = 1, -- from where to start line number
        linePad = 2,    -- padding between lines
        padHoriz = 80,  -- Horizontal padding
        padVert = 100,  -- vertical padding
        shadowBlurRadius = 10,
        shadowColor = "#555555",
        shadowOffsetX = 8,
        shadowOffsetY = 8,
    })
end

-- function config.fsread()
--     vim.g.flow_strength = 0.7         -- low: 0.3, middle: 0.5, high: 0.7 (default)
--     vim.g.skip_flow_default_hl = true -- If you want to override default highlights
--     vim.api.nvim_set_hl(0, "FSPrefix", { fg = "#ff8700" })
--     vim.api.nvim_set_hl(0, "FSSuffix", { fg = "#98f6ff" })
-- end

-- function config.flote()
--     -- defaults
--     require('flote').setup {
--         q_to_quit = true,
--         window_style = 'minimal',
--         window_border = 'solid',
--         window_title = true,
--         notes_dir = vim.fn.stdpath('cache') .. '/flote',
--         files = {
--             global = 'flote-global.md',
--             cwd = function()
--                 return vim.fn.getcwd()
--             end,
--             file_name = function(cwd)
--                 local base_name = vim.fs.basename(cwd)
--                 local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
--                 return parent_base_name .. '_' .. base_name .. '.md'
--             end
--         }
--
--     }
-- end

-- function config.chatgpt()
--     require("chatgpt").setup(
--         {
--             api_key_cmd = nil,
--             yank_register = "+",
--             edit_with_instructions = {
--                 diff = false,
--                 keymaps = {
--                     close = "<C-c>",
--                     accept = "<C-y>",
--                     toggle_diff = "<C-d>",
--                     toggle_settings = "<C-o>",
--                     cycle_windows = "<Tab>",
--                     use_output_as_input = "<C-i>",
--                 },
--             },
--             chat = {
--                 welcome_message = WELCOME_MESSAGE,
--                 loading_text = "Loading, please wait ...",
--                 question_sign = "",
--                 answer_sign = "🤓",
--                 max_line_length = 120,
--                 sessions_window = {
--                     border = {
--                         style = "rounded",
--                         text = {
--                             top = " Sessions ",
--                         },
--                     },
--                     win_options = {
--                         winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--                     },
--                 },
--                 keymaps = {
--                     close = { "<C-c>" },
--                     yank_last = "<C-y>",
--                     yank_last_code = "<C-k>",
--                     scroll_up = "<C-u>",
--                     scroll_down = "<C-d>",
--                     new_session = "<C-n>",
--                     cycle_windows = "<Tab>",
--                     cycle_modes = "<C-f>",
--                     select_session = "<Space>",
--                     rename_session = "r",
--                     delete_session = "d",
--                     draft_message = "<C-d>",
--                     toggle_settings = "<C-o>",
--                     toggle_message_role = "<C-r>",
--                     toggle_system_role_open = "<C-s>",
--                     stop_generating = "<C-x>",
--                 },
--             },
--             popup_layout = {
--                 default = "center",
--                 center = {
--                     width = "80%",
--                     height = "80%",
--                 },
--                 right = {
--                     width = "30%",
--                     width_settings_open = "50%",
--                 },
--             },
--             popup_window = {
--                 border = {
--                     highlight = "FloatBorder",
--                     style = "rounded",
--                     text = {
--                         top = " ChatGPT ",
--                     },
--                 },
--                 win_options = {
--                     wrap = true,
--                     linebreak = true,
--                     foldcolumn = "1",
--                     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--                 },
--                 buf_options = {
--                     filetype = "markdown",
--                 },
--             },
--             system_window = {
--                 border = {
--                     highlight = "FloatBorder",
--                     style = "rounded",
--                     text = {
--                         top = " SYSTEM ",
--                     },
--                 },
--                 win_options = {
--                     wrap = true,
--                     linebreak = true,
--                     foldcolumn = "2",
--                     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--                 },
--             },
--             popup_input = {
--                 prompt = "  ",
--                 border = {
--                     highlight = "FloatBorder",
--                     style = "rounded",
--                     text = {
--                         top_align = "center",
--                         top = " Prompt ",
--                     },
--                 },
--                 win_options = {
--                     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--                 },
--                 submit = "<C-Enter>",
--                 submit_n = "<Enter>",
--                 max_visible_lines = 20
--             },
--             settings_window = {
--                 border = {
--                     style = "rounded",
--                     text = {
--                         top = " Settings ",
--                     },
--                 },
--                 win_options = {
--                     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--                 },
--             },
--             openai_params = {
--                 model = "gpt-3.5-turbo",
--                 frequency_penalty = 0,
--                 presence_penalty = 0,
--                 max_tokens = 300,
--                 temperature = 0,
--                 top_p = 1,
--                 n = 1,
--             },
--             openai_edit_params = {
--                 model = "gpt-3.5-turbo",
--                 max_tokens = 300,
--                 temperature = 0,
--                 top_p = 1,
--                 n = 1,
--             },
--             actions_paths = {},
--             show_quickfixes_cmd = "Trouble quickfix",
--             predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
--         })
-- end

function config.leetcode()
    require('leetcode').setup(
        {
            domain = "com", -- For now "com" is the only one supported
            arg = "leetcode.nvim",
            lang = "cpp",
            sql = "mysql",
            directory = vim.fn.stdpath("data") .. "/leetcode/",
            logging = true,
            console = {
                open_on_runcode = false, ---@type boolean

                dir = "row", ---@type "col" | "row"

                size = {
                    width = "90%", ---@type string | integer
                    height = "75%", ---@type string | integer
                },

                result = {
                    size = "60%", ---@type string | integer
                },

                testcase = {
                    size = "40%", ---@type string | integer
                },
            },

            description = {
                position = "left", ---@type "top" | "right" | "bottom" | "left"

                width = "40%", ---@type string | integer
            },
        }

    )
end

return config
