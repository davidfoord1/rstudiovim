unmap <Space>

" Multiple paste replace
noremap <Space>p "0p

nnoremap <Space>o o<Esc>
nnoremap <Space>O O<Esc>

" Enter today's date
noremap <Space>td :R<Space>cat(as.character(Sys.Date()))<CR>

" Reflow text in paragraph
nnoremap <Space>wp vipgq
