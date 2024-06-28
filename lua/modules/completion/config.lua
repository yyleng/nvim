local config = {}

function config.copilot_chat()
    local prompts = require('CopilotChat.prompts')
    local select = require('CopilotChat.select')
    require("CopilotChat").setup(
        {
            debug = false,                   -- Enable debug logging
            proxy = "http://127.0.0.1:7890", -- [protocol://]host[:port] Use this proxy
            allow_insecure = false,          -- Allow insecure server connections

            system_prompt = prompts.COPILOT_INSTRUCTIONS,
            model = 'gpt-4', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
            temperature = 0.1, -- GPT temperature

            question_header = '## User ', -- Header to use for user questions
            answer_header = '## Copilot ', -- Header to use for AI answers
            error_header = '## Error ', -- Header to use for errors
            separator = '───', -- Separator to use in chat

            show_folds = true, -- Shows folds for sections in chat
            show_help = true, -- Shows help message as virtual lines when waiting for user input
            auto_follow_cursor = true, -- Auto-follow cursor in chat
            auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
            clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
            highlight_selection = true, -- Highlight selection

            context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
            history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
            callback = nil, -- Callback to use when ask response is received

            -- default selection (visual or line)
            selection = function(source)
                return select.visual(source) or select.line(source)
            end,

            -- default prompts
            prompts = {
                Complete = {
                    prompt = 'Use Chinese To Answer. Please help me complete the code.',
                    description = 'Complete the code.',
                    selection = require('CopilotChat.select').visual,
                },
                Explain = {
                    prompt =
                    '/COPILOT_EXPLAIN Use Chinese To Answer. Write an explanation for the active selection as paragraphs of text.',
                },
                Review = {
                    prompt = '/COPILOT_REVIEW Use Chinese To Answer. Review the selected code.',
                    callback = function(response, source)
                        local ns = vim.api.nvim_create_namespace('copilot_review')
                        local diagnostics = {}
                        for line in response:gmatch('[^\r\n]+') do
                            if line:find('^line=') then
                                local start_line = nil
                                local end_line = nil
                                local message = nil
                                local single_match, message_match = line:match('^line=(%d+): (.*)$')
                                if not single_match then
                                    local start_match, end_match, m_message_match = line:match(
                                        '^line=(%d+)-(%d+): (.*)$')
                                    if start_match and end_match then
                                        start_line = tonumber(start_match)
                                        end_line = tonumber(end_match)
                                        message = m_message_match
                                    end
                                else
                                    start_line = tonumber(single_match)
                                    end_line = start_line
                                    message = message_match
                                end

                                if start_line and end_line then
                                    table.insert(diagnostics, {
                                        lnum = start_line - 1,
                                        end_lnum = end_line - 1,
                                        col = 0,
                                        message = message,
                                        severity = vim.diagnostic.severity.WARN,
                                        source = 'Copilot Review',
                                    })
                                end
                            end
                        end
                        vim.diagnostic.set(ns, source.bufnr, diagnostics)
                    end,
                },
                Fix = {
                    prompt =
                    '/COPILOT_GENERATE Use Chinese To Answer. There is a problem in this code. Rewrite the code to show it with the bug fixed.',
                },
                Optimize = {
                    prompt =
                    '/COPILOT_GENERATE Use Chinese To Answer. Optimize the selected code to improve performance and readablilty.',
                },
                Docs = {
                    prompt =
                    '/COPILOT_GENERATE Use Chinese To Answer. Please add documentation comment for the selection.',
                },
                Tests = {
                    prompt = '/COPILOT_GENERATE Use Chinese To Answer. Please generate tests for my code.',
                },
                FixDiagnostic = {
                    prompt = 'Use Chinese To Answer. Please assist with the following diagnostic issue in file:',
                    selection = select.diagnostics,
                },
                Commit = {
                    prompt =
                    'Use Chinese To Answer. Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    selection = select.gitdiff,
                },
                CommitStaged = {
                    prompt =
                    'Use Chinese To Answer. Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    selection = function(source)
                        return select.gitdiff(source, true)
                    end,
                },
            },

            -- default window options
            window = {
                layout = 'float',
                relative = 'cursor',
                width = 1,
                height = 0.4,
                row = 1
                -- layout = 'vertical',       -- 'vertical', 'horizontal', 'float', 'replace'
                -- width = 0.5,            -- fractional width of parent, or absolute width in columns when > 1
                -- height = 0.5,           -- fractional height of parent, or absolute height in rows when > 1
                -- -- Options below only apply to floating windows
                -- relative = 'win',    -- 'editor', 'win', 'cursor', 'mouse'
                -- border = 'single',      -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                -- row = nil,              -- row position of the window, default is centered
                -- col = nil,              -- column position of the window, default is centered
                -- title = 'Copilot Chat', -- title of chat window
                -- footer = nil,           -- footer of chat window
                -- zindex = 1,             -- determines if window is on top or below other floating windows
            },

            -- default mappings (in tables first is normal mode, second is insert mode)
            mappings = {
                complete = {
                    detail = 'Use @<Tab> or /<Tab> for options.',
                    insert = '<Tab>',
                },
                close = {
                    normal = 'q',
                    insert = '<C-c>',
                },
                reset = {
                    normal = '<C-l>',
                    insert = '<C-l>',
                },
                submit_prompt = {
                    normal = '<CR>',
                    insert = '<C-s>',
                },
                accept_diff = {
                    normal = '<C-y>',
                    insert = '<C-y>',
                },
                yank_diff = {
                    normal = 'gy',
                },
                show_diff = {
                    normal = 'gd',
                },
                show_system_prompt = {
                    normal = 'gp',
                },
                show_user_selection = {
                    normal = 'gs',
                },
            },
        }
    )
end

return config
