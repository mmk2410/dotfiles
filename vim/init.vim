" vim-plug plugin manager

if filereadable(expand("~/.vim/autoload/plug.vim")) || filereadable(expand("~/.config/nvim/autoload/plug.vim")) || filereadable(expand("~\vimfiles\autoload\plug.vim")) || filereadable(expand("~/.local/share/nvim/site/plugin/plug.vim"))

    call plug#begin('~/.vim/plugged')

    Plug 'benekastah/neomake'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'junegunn/vim-easy-align'
    Plug 'Shougo/deoplete.nvim'
    Plug 'vim-scripts/gitignore.vim'
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'StanAngeloff/php.vim'
    Plug 'rust-lang/rust.vim'
    Plug 'majutsushi/tagbar'
    Plug 'vim-scripts/taglist.vim'
    Plug 'bling/vim-airline'
    Plug 'Townk/vim-autoclose'
    Plug 'kchmck/vim-coffee-script'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-latex/vim-latex'
    Plug 'morhetz/gruvbox'
    Plug 'dag/vim-fish'
    Plug 'dart-lang/dart-vim-plugin'
    Plug 'KabbAmine/gulp-vim'
    Plug 'derekwyatt/vim-scala'
    Plug 'kovisoft/slimv'
    Plug 'vim-scripts/java.vim'
    Plug 'vim-php/vim-phpunit'
    Plug 'IN3D/vim-raml'
    Plug 'zchee/deoplete-clang'
    Plug 'parkr/vim-jekyll'

    call plug#end()

else
    echom "Didn't find Plug"
endif

set nocompatible
filetype indent plugin on

set wildmenu
set showcmd
set hlsearch

set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set mouse=a
set cmdheight=2
set number
set pastetoggle=<F11>

set softtabstop=4
set shiftwidth=4
set expandtab

set autoread

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>

" Visual

set so=7
set wildignore=*.o,*~,*.pyc,*.jar
set hid
set whichwrap+=<,>,h,l
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Color

syntax on
colorscheme gruvbox

set background=dark
set cursorline
if has("gui_running")
        set guioptions-=T
        set guioptions+=e
        set t_Co=256
        set guitablabel=%M\ %t
        if has("gui_gtk2")
            set guifont=Hermit\ 10
        endif
endif
set t_Co=256
set encoding=utf-8
set ffs=unix,dos,mac
set textwidth=80
set colorcolumn=+1
hi ColorColumn guibg=#2d2d2d ctermbg=238

" Files, Backups and undo

set nobackup
set nowb
set noswapfile

set smarttab
set tabstop=4
set ai
set si
set wrap

map j gj
map k gk
map <space> /
map <c-space> ?
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>lmap <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
"
" " Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
"
map <leader>W :w
"
" " Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry
"
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"Remember info about open buffers on close
set viminfo^=%

map 0 ^
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"
" Delete trailing white space on save, useful for Python and
"         CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Neomake lint
autocmd! BufWritePost,BufEnter * Neomake

map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

map <C-n> :NERDTreeToggle<CR>

" My Changes

inoremap jk <ESC>
set listchars=tab:>-,trail:-
set list
set clipboard+=unnamedplus

" Plugin settings
" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.6/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.6/lib/clang/3.6.2/include/'

set grepprg=grep\ -nH\ $*

" latexsuite
let g:tex_flavor='latex'
let g:tex_fold_enabled=1
let g:Tex_CompileRule_pdf = 'pdflatex --interaction=nonstopmode $*'

" slimv swank server
let g:slimv_swank_cmd = '! xterm -e sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp &'

" Filetype specific settings
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype coffee setlocal ts=2 sts=2 sw=2
autocmd Filetype dart setlocal ts=2 sts=2 sw=2

" Syntax highlighting for HtMd (Hypertext Markdown)
au BufRead,BufNewFile *.htmd set filetype=html
