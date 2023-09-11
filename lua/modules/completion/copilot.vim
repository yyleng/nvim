let g:copilot_no_tab_map = v:true
let g:copilot_proxy = 'localhost:7890'
let g:copilot_filetypes = {'markdown': v:true}
highlight CopilotSuggestion guifg=#555555 ctermfg=8
imap <c-]> <Plug>(copilot-dismiss)
imap <c-s> <Plug>(copilot-previous)
imap <c-l> <Plug>(copilot-next)
imap <silent><script><expr> <C-R> copilot#Accept("\<CR>")

