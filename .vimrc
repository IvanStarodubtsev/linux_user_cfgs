" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
"if v:progname =~? "evim"
" finish
"endif
scriptencoding utf-8
set encoding=utf-8

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle config begins here

"filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

"Plugin 'rust-lang/rust.vim'

" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=120

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" binding "*y to the Ctrl+C hotkey to copy visually selected lines to the system' clipboard
" with clipboard adjusted to be part of a global system clipboard
" Short howto's:
" - in first vim opened file yank any line(s) using both ways: yy or Ctrl+c
" - in second vim opened file paste yanked lines using next way: pressing key p will paste yanked text right where
"   cursor is
" - have fun and good luck!
vnoremap <C-c> "*y
set clipboard=unnamedplus

" vim 72 old rc file
" set syntax=on
" set colorscheme
colorscheme elflord

" setting width of text
let g:width=120

let &textwidth=g:width
set formatoptions+=t
set nowrap linebreak nolist

" set automatic indent
set smartindent
set number
set autoindent

" additional settings from outerworld
set ci
set wmnu

" status line settings
set laststatus=2
set ruler
set showmode
" status line format
set statusline=file:\ %f
set statusline+=\ \|
set statusline+=\ [%M][%R]
set statusline+=\ \|
set statusline+=\ selected:\ %{VisualSelectionSize()}
set statusline+=%=
set statusline+=\ line:\ %l\ of\ %L,\ col:\ %c\ (%p%%)

" Only do this part when compiled with support for autocommands
if has ("autocmd")
  " for *.c files leave tabs as 8 chars set
  autocmd BufRead *.{c,cpp,py,js,log} set autoindent
  "autocmd bufread *.{c,cpp,py,js,log} set noexpandtab
  ""autocmd BufRead *.{c,cpp,py,js,log} set tabstop=8
  autocmd BufRead *.{c,cpp,py,js,log} set shiftwidth=8
  autocmd BufRead *.{c,cpp,py,js,log} set softtabstop=8
  autocmd BufRead *.{c,cpp,py,js,log} set expandtab
  " for *.h files leave tabs as 8 chars set
  autocmd BufRead *.{h,hpp} set autoindent
  "autocmd BufRead *.{h,hpp} set noexpandtab
  ""autocmd BufRead *.{h,hpp} set tabstop=8
  autocmd BufRead *.{h,hpp} set shiftwidth=8
  autocmd BufRead *.{h,hpp} set softtabstop=8
  autocmd BufRead *.{h,hpp} set expandtab

  " insert mode bindings for C/C++ langs
  autocmd FileType c,cpp,h,hpp inoremap #d #define
  autocmd FileType c,cpp,h,hpp inoremap #e #endif /*  */<Esc>hhi
  autocmd FileType c,cpp,h,hpp inoremap #i #include ""<Esc>i
  autocmd FileType c,cpp,h,hpp inoremap #< #include <><Esc>i
  autocmd FileType c,cpp,h,hpp inoremap " ""<Left>
  autocmd FileType c,cpp,h,hpp inoremap ' ''<Left>
  autocmd FileType c,cpp,h,hpp inoremap ( ()<Left>
  autocmd FileType c,cpp,h,hpp inoremap [ []<Left>
  autocmd FileType c,cpp,h,hpp inoremap { {}<Left>
endif

" highlightning extra whitespaces trailing text in grey
highlight ExtraWhitespace ctermbg=grey guibg=grey
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

set copyindent
"set pastetoggle=<F10>

" setting vertical color column at position of line_width chars
if exists ('+colorcolumn')
	let &colorcolumn=g:width
	highlight ColorColumn ctermbg=6
endif

" coloring text in red which rolls out of bound of line_width chars wide
au BufWinEnter * let w:m2=matchadd ('ErrorMsg', '\%' . g:width . 'v.\+', -1)

if exists ('+textwidth')
	set textwidth=120
	set formatoptions+=t
	set wrap linebreak
endif

" function for counting lines/chars/blocks selected
function! VisualSelectionSize()
	if mode() == "v"
		" Exit and re-enter visual mode, because the marks
		" ('< and '>) have not been updated yet.
		exe "normal \<ESC>gv"
		if line("'<") != line("'>")
			return (line("'>") - line("'<") + 1) . ' line(s)'
            	else
                	return (col("'>") - col("'<") + 1) . ' char(s)'
            	endif
        elseif mode() == "V"
            	exe "normal \<ESC>gv"
            	return (line("'>") - line("'<") + 1) . ' line(s)'
        elseif mode() == "\<C-V>"
            	exe "normal \<ESC>gv"
            	return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block(s)'
        else
		return 'none'
	endif
endfunction

" Note: add the lines below to the vim syntax file to
" enable custom highlightning for C functions - bold style
" syn match cCustomFunc /\w\+\s*(/me=e-1,he=e-1
" hi def link cCustomFunc		Function
" hi Function cterm=bold
" in /usr/local/share/vim/vim74/syntax/c.vim

" highlightning types
autocmd BufRead, BufNewFile *.{c,h} len fname = expand ('<afile>:p:h') . '/types.vim'
autocmd BufRead, BufNewFile *.{c,h} if filereadable (fname)
autocmd BufRead, BufNewFile *.{c,h}    exe 'so ' . fname
autocmd BufRead, BufNewFile *.{c,h} endif

" press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" warn that they are running custom vim script
silent !echo "running custom .vimrc script from user:" $USER [$HOME]
