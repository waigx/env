"""""""""""""""""""""""""
"Pathogen plugin management
execute pathogen#infect()
:Helptags


"""""""""""""""""""""""""
"General settings

set number
set ruler
set visualbell
set showcmd
set showmatch
set guifont=Monaco:h12
set showtabline=2
set laststatus=2  
set tabstop=4
set cindent
set shiftwidth=4
set softtabstop=4

syntax enable

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

"Set NERDTree's options
let NERDTreeQuitOpen=1
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""
"Set customize shortcuts

"Set leader
let mapleader = ","
"Map shortcuts for NERDTree
map <leader>ff :NERDTreeTabsToggle<CR>
map <leader>f :NERDTreeTabsFind<CR>
"Map shortcuts for highlight search
map <leader><space> :set hlsearch!<CR>
"Map tab shortcuts
map <leader>n :tabe<CR>
map <leader>t :tabe<CR>
map <leader>h :tabp<CR>
map <leader>l :tabn<CR>
"Map shortcuts for close opeations
map <leader>q :qa<CR>
map <leader>w :q<CR>
map <leader>`q :qa!<CR>
map <leader>`w :q!<CR>
"Map shortcuts for Maxmize and restore a window
map <leader>m :MaximizerToggle<CR>
"
map <leader>cck :SyntasticCheck<CR>

"Set shortcuts for moving between window
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h
