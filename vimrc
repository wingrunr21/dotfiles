if has("win32")
  source ~/vimfiles/vimrc
  cd F:\Documents\Sites
  let g:ruby_path = 'C:\Ruby192\bin'
elseif has("unix")
  source ~/.vim/vimrc

  let s:uname = system("echo -n \"$(uname)\"")
  if s:uname == "Darwin"
    cd ~/Sites
  elseif s:uname == "Linux"
    cd ~
  end
end

colorscheme ir_black
let mapleader = ","
imap jj <Esc>

let NERDTreeChDirMode=2

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set directory=~/.vim/swapfiles
