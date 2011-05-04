if has("win32") 
  source ~/vimfiles/vimrc
  cd F:\Documents\Sites
  let g:ruby_path = 'C:\Ruby192\bin'
else
  source ~/.vim/vimrc
  cd ~/Sites
end

colorscheme ir_black
let mapleader = ","
imap jj <Esc>

let NERDTreeChDirMode=2

set directory=~/.vim/swapfiles
