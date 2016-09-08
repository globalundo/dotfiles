set laststatus=2
set softtabstop=4
set expandtab
" set cursorline
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

set nocompatible
set t_Co=16
set rtp+=~/.vim/bundle/Vundle.vim
" set number

call vundle#rc()

filetype plugin indent on

" Bundle 'vim-scripts/ShowMarks'
" Bundle 'vim-scripts/vim-misc'
" Bundle 'xolox/vim-notes'
" Bundle 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
" Plugin 'puppetlabs/puppet-syntax-vim'
if filereadable(expand('~/.vimlocal')) | source ~/.vimlocal | endif
syntax on
" background=dark " light | dark "
" colorscheme solarized
filetype plugin on
" filetype off
" set cursorline
"set colorcolumn=80"
" call togglebg#map("<F5>")
" nnoremap <F5> "=strftime("%Y-%m-%d,%R,:,iowops,RT,")<CR>p

colorscheme askapachecode

if &diff
"    set t_Co=256
"    set background=dark
  set laststatus=2 "show the status line
  set statusline=%-10.3n  "buffer number
  map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
  map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
  map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>

endif

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


