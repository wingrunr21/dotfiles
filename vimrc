if has("win32")
  let g:ruby_path = 'C:\Ruby192\bin'
else
  source ~/.vim/vimrc
end

" Run syntastic against the default rbenv ruby
let g:syntastic_ruby_exec = 'ruby'

colorscheme ir_black

" Support for Marked.app
:nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
