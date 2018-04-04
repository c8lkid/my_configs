" 
" Vundle counfiguration
" 
set nocompatible              " be iMproved, required
filetype off                  " required

"  set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"  alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

"  let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
" Plugin 'klen/python-mode'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'xolox/vim-lua-ftplugin'
" Plugin 'xolox/vim-misc'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'kshenoy/vim-signature'
" Plugin 'davidhalter/jedi'
" Plugin 'tmhedberg/SimpylFold'
" Plugin 'fholgado/minibufexpl.vim'
Plugin 'majutsushi/tagbar'
call vundle#end()            " required
filetype plugin indent on    " required
set hidden
" 
" End vundle configuration
" 
" Colorized
if has('gui_running')
	colorscheme wombat256mod
    set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline\ 10
else 
	colorscheme darkblue
endif
" colorscheme wombat256mod
set t_Co=256
" 
set wrap
set linebreak
set expandtab
" set listchars=tab:➔\ ,trail:⋅,precedes:‹,extends:›,eol:↲,nbsp:␣
set listchars=tab:➔\ ,trail:⋅,precedes:‹,extends:›,eol:↲,space:␣

au FocusGained * :redraw!

" Помним что редактировали в последний раз.
if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
endif
" 
"   при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
    autocmd!
    autocmd FileType yaml,json,lua,html set sw=2 ts=2 
    autocmd FileType php,ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType php,ruby,python,javascript,c,cpp match Excess /\%81v.*/
    autocmd FileType php,ruby,python,javascript,c,cpp set nowrap
    autocmd FileType python colorscheme pychimp
augroup END
" Cyrillic in input mode change layout by pressing Ctrl+^
set keymap=russian-jcukenwin  
set iminsert=0  
set imsearch=0 
highlight lCursor guifg=NONE guibg=Cyan  
" set langmap=!\\"№\\;%?*ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;!@#$%&*`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
" 
" Common settings
syntax on
set number
set backspace=indent,start,eol
set showcmd
set hls
set bg=dark
set nolist
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ignorecase
" no backup and swap files
set noswapfile
set nobackup
set nowritebackup
set incsearch	     " инкреминтируемый поиск
"  прячем панельки
set guioptions-=m   " меню
set guioptions-=T    " тулбар
set guioptions-=r    " hide right scrollbar
" set guioptions-=r   "  скроллбары

" My functions
" Show unprintble characters
function My_list()
	if ! &list
		let &list = 1
	else
		let &list = 0
	endif
endfunction
" 
" My maps
" 
let mapleader = ","

"  TagBar настройки
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии

"  NERDTree settings
map <silent> <F2> :NERDTreeToggle<CR>
" map <silent> <C-P> :tabprevious<CR>
" map <silent> <C-N> :tabnext<CR>
" map <silent> <C-T> :tabnew<CR>
" map <C-C> "+y
" noremap <C-V> "+p
nnoremap <F1> :help <C-R><C-W><cr>:cw<cr>			" show vim help for a word under cursor
noremap <Tab> <C-W>w
noremap <S-Tab> <C-W>W
" nnoremap <Space> <PageDown>
" nnoremap <S-Space> <PageUp>
nnoremap * *N
noremap <C-H> :nohlsearch<CR>
inoremap ,, <ESC>l
" inoremap jk <Esc>l
" inoremap ол <Esc>l
inoremap <leader>q <Esc><Esc>l
" inoremap <C-C> <Esc><Esc>
inoremap <Left> <nop>
inoremap <Right> <nop>
" inoremap <Up> <nop>
" inoremap <Down> <nop>
inoremap <Esc> <nop>
noremap <leader>ve :split $MYVIMRC<CR>
noremap <leader>vs :source $MYVIMRC<CR>
noremap <leader>tl :call My_list()<CR>
nnoremap <Left> gT
nnoremap <Right> gt
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>T :enew<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :BuffergatorToggle<CR>
nmap <leader>p :CtrlP<CR>
nmap <leader>bb :CtrlPBuffer<CR>
nmap <leader>bm :CtrlPMixed<CR>

" Pymode settings
" let g:pymode_rope = 0
" let g:pymode_rope_complete_on_dot = 0
" let g:pymode_python = 'python3'
" let g:pymode_rope_completion = 0
" let g:pymode_run_bind = '<F5>'
" 
" " Jedi mode
" let g:jedi#use_tabs_not_buffers = 1
" let g:jedi#documentation_command = '' 
" let g:jedi#rename_command = ''
" " let g:jedi#goto_assignments_command = ''
" " let g:jedi#goto_command = ''
" 
" 
" " Airline configuration
set laststatus=2
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" 
" " Lua mode settings
" let g:lua_complete_omni = 1 

" YouCompleteMe configuration
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_server_python_interpreter = '/usr/bin/python'
nnoremap <leader>g :YcmCompleter GoToDefinition<CR>
nnoremap <leader>G :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>Gr :YcmCompleter GoToReferences<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
