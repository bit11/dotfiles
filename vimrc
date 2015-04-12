"---------------------------------------------
" vimrc
" ~/.vimrc
" Last updated 26 Jun 14
"---------------------------------------------

" General settings
set number				" Show line number
set cursorline          " Highlight current line
set hlsearch			" Highlights search terms
set incsearch			" Show immediately where so far typed pattern matches
set tabstop=4			" Tab automatically moves 4 spaces
set softtabstop=4		" Backspace automatically deletes 4 spaces
set expandtab			" Expand all tabs to spaces
set shiftwidth=4		" (Auto)indent moves 4 spaces
set showmatch			" Highlights corresponding bracket, if exists
set ignorecase			" Ignore case sensitivity in search
set smartcase			" Ignore 'ignorecase' if search term has upper case
set autoindent			" Auto indent when creating new line
set ruler				" Show cursor line and column number separated by comma
set autoread			" Auto reload files changed outside vim
set wrap				" Automatically wrap text
set linebreak			" Allow linebreaking only when 'Enter' key is pressed
set encoding=utf-8      " UTF-8 encoding for new files
set wildmenu            " Graphical menu for file tab completion
set lazyredraw          " Only redraw screen when needed
"set smarttab
"set smartindent
syntax on				" Enable syntax highlighting

" Enable filetype plugin
filetype plugin on
filetype plugin indent on

" Appearance
set background=light      " Set light background as default
let g:netrw_liststyle=3   " Default file explorer appearance to NERDTree
let base16colorspace=256  " Access colors present in 256 colorspace
source $HOME/dotfiles/colours/base16-atelierlakeside.vim

" Keymaps
:map <F2> :nohl<CR> " Toggle search highlighting
:map <F3> :setlocal spell! spelllang=en_gb<CR> " Spellcheck toggle

" Window movement
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_

" Folding
set foldenable              " Enable folding
set foldlevelstart=1        " Only open outside fold by default
set foldmethod=indent       " Fold based on indent level

" Commenting blocks of code.
" Set default comment characters
augroup block_comments
    autocmd!
    autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
    autocmd FileType sh,ruby,python   let b:comment_leader = '# '
    autocmd FileType conf,fstab       let b:comment_leader = '# '
    autocmd FileType tex              let b:comment_leader = '% '
    autocmd FileType mail             let b:comment_leader = '> '
    autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> " 'cc to comment blocks
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR> " ,cu to remove comments

