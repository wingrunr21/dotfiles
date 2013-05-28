if has("win32")
  let g:ruby_path = 'C:\Ruby192\bin'
else
  source ~/.vim/vimrc
end

" Run syntastic against a 1.9 ruby
let g:syntastic_ruby_exec = '~/.rbenv/versions/1.9.3-p392/bin/ruby'

colorscheme ir_black

" Support for Marked.app
:nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
