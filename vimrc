"---------------------------------------
" Key Mapping (common)
"---------------------------------------

" Easy to enter normal mode
inoremap df <esc>

" Set comma as the mapleader
let mapleader = ","

" Convenient multi-window movement
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Switch buffer
nnoremap <silent> <C-N> :bp<cr>
nnoremap <silent> <C-M> :bn<cr>

" Easy to close and save file
nnoremap <silent> <Leader>q :confirm q<cr>
nnoremap <Leader>w :w<cr>

nnoremap <silent> <Leader>r :tabnew<cr>
nnoremap <silent> <Leader><Leader>r :tabclose<cr>

noremap <silent> <Leader>t :term<cr>

" Handling permission-denied error
command W w !sudo tee % > /dev/null

" Edit vimrc
command Vimrc :edit $MYVIMRC

" Toggle paste mode
set pastetoggle=<Leader>p


"---------------------------------------
" Option Initialization
"---------------------------------------

" 兼容中文
set encoding=utf-8

" Show line number
set number

" Not compatible with vi
set nocompatible

" Show the cursor position all the time
set ruler

" Setting for indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Turn on wildmenu
set wildmenu

" Set location of a new vertical split
set splitbelow

" Show the command I entered
set showcmd

" About folding
"set fdm=indent

" Locating current line
set cursorline

" Show matching brackets
set showmatch

" Sarching configuration
set ignorecase

" Auto update files
set autoread

" Syntax highlighting
syntax on

" Enable filetype plugins
filetype plugin on


"---------------------------------------
" Plugin Management & Configuration
"---------------------------------------

call plug#begin('~/.vim/myplugin')

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'

"Plug 'dense-analysis/ale'
"
"    let g:ale_sign_error = '✘'
"    let g:ale_sign_warning = '➡'

Plug 'KeitaNakamura/neodark.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

    set laststatus=2  " 永远显示状态栏
    let g:airline_powerline_fonts = 0  " 支持 powerline 字体
    let g:airline#extensions#tabline#enabled = 1  " 显示窗口 tab 和 buffer
    let g:airline_theme = "neodark"

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
"    " use <tab> for trigger completion and navigate to next complete item
"    function! s:check_back_space() abort
"        let col = col('.') - 1
"        return !col || getline('.')[col - 1]  =~ '\s'
"    endfunction
"
"    inoremap <silent><expr> <TAB>
"        \ pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ coc#refresh()
"    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
"    " Format code
"    nnoremap <Leader>F <Plug>(coc-format)
"
"    " Remap keys for gotos
"    nmap <silent> gd <Plug>(coc-definition)
"    nmap <silent> gy <Plug>(coc-type-definition)
"    nmap <silent> gi <Plug>(coc-implementation)
"    nmap <silent> gr <Plug>(coc-references)
"
"    " You will have bad experience for diagnostic messages when it's default 4000.
"    set updatetime=300
"
"    " Using CocList
"    nnoremap <silent> <leader>c :<C-u>CocList<cr>
"    " Show commands
"    nnoremap <silent> .a  :<C-u>CocList commands<cr>
"    " Find symbol of current document
"    nnoremap <silent> .o  :<C-u>CocList outline<cr> " Search workspace symbols
"    nnoremap <silent> .s  :<C-u>CocList -I symbols<cr>
"    " Resume latest coc list
"    nnoremap <silent> .p  :<C-u>CocListResume<cr>
"
"    " Remap for format selected region
"    xmap <leader>f  <Plug>(coc-format-selected)
"    nmap <leader>f  <Plug>(coc-format-selected)

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()

" Set colorscheme after declaring
colorscheme neodark
