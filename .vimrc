"""""""""""""""""""""""""
"Set VIM default encoding
set encoding=utf-8


"""""""""""""""""""""""""
"Pathogen plugin management
execute pathogen#infect()
:Helptags


"""""""""""""""""""""""""
"Get platfrom info.
if has("unix")
	let s:uname = substitute(system('uname -s'), "\n", "", "")
endif


"""""""""""""""""""""""""
"General settings

"For OS X
if s:uname == "Darwin"
"Begin for OS X
set guifont=Monaco:h12
if has('gui_running')
	set transparency=2
endif
"End for OS X
endif

"Platform independent
set number
set ruler
set showcmd
set showmatch
set showtabline=2
set laststatus=2  
set tabstop=4
set shiftwidth=4
set softtabstop=4
syntax enable
set smartindent
"Set line/column highlight
set cursorline
set cursorcolumn
"Set indent guide
set list
set listchars=tab:┊\ 


"""""""""""""""""""""""""""
"Set Themes

"Use solarized light in GUI model, dark in CLI model
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized 
let g:solarized_termcolors=256
let g:airline_theme='solarized'


"""""""""""""""""""""""""""
"Plugins' options


"""""""""""""""""""""""""""
"Set customize shortcuts

"Set leader
let mapleader = ","

"Map shortcuts for highlight search
map <leader><space> :set hlsearch!<CR>
"Map tab shortcuts
map <leader>n :tabe<CR>
map <leader>t :tabe<CR>
"Map shortcuts for close opeations
map <leader>q :qa<CR>
map <leader>w :q<CR>
map <leader>`q :qa!<CR>
map <leader>`w :q!<CR>
"Map shortcuts for Maxmize and restore a window
map <leader>m :MaximizerToggle<CR>
"Map shortcuts for Tagbar
map <leader>g :TagbarToggle<CR>
"Map 'Check Grammar'
map <leader>ck :SyntasticCheck<CR>

"Map 'Undo Graphic'
map <leader>z :GundoToggle<CR>

"Map Run Current Script
map <leader>r :!chmod a+x "%:p";"%:p"<CR>
map <leader>cr :!chmod a+x "%:p";clear;"%:p"<CR>
"Map capital K to find system manual in a new window
runtime! ftplugin/man.vim
nnoremap K :Man 3 <cword><CR>
if s:uname=="SunOS"
	nnoremap K :Man -s 3c <cword><CR>
endif

"Set shortcuts for moving between window
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

"Set shortcut for moving between tab
nnoremap _ :tabp<CR>
nnoremap + :tabn<CR>


""""""""""""""""""""""""""
"Allow saving of files as sudo
cmap w!! w !sudo tee % > /dev/null

