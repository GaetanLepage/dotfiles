" Gaetan Lepage's vim config file, intended to use with neovim but surely
"" compatible with vim
"" Originally based on the vim 8 config file by Ensimag

"" - install some font with powerline symbols for eye candy and icons
"" (see https://github.com/powerline/fonts)
"" - You may want to install nerd fonts for more compatibility with airline and vim
"" devicons https://github.com/ryanoasis/nerd-fonts

"" after that copy this file as your $HOME/.config/nvim/init.vim (or ~/.vimrc for classic vim) and execute :PlugInstall

"""""""""""
" PLUGINS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'                                                   " Sane defaults
Plug 'vim-airline/vim-airline'                                              " status bar (needs special fonts)
Plug 'ryanoasis/vim-devicons'                                               " various symbols
Plug 'gruvbox-community/gruvbox'                                            " nice colorscheme
Plug 'ryanoasis/vim-devicons'                                               " coloured icons
Plug 'preservim/nerdcommenter'                                              " Nerd Commenter
Plug 'preservim/nerdtree'                                                   " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'                                          " NerdTree Git plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                         " Fuzzy file finder (fzf)
Plug 'junegunn/fzf.vim'                                                     " fzf
Plug 'majutsushi/tagbar'                                                    " TagBar
Plug 'dstein64/nvim-scrollview', {'branch': 'main'}                         " Scrollbar
Plug 'neoclide/coc.nvim', {'branch': 'release'}                             " Coc autocompletion
Plug 'honza/vim-snippets'                                                   " Snippets engine
Plug 'tpope/vim-fugitive'                                                   " Git Fugitive
Plug 'lervag/vimtex'                                                        " LateX
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}                      " [Python] color scheme
Plug 'tmhedberg/SimpylFold'                                                 " [Python] improved folding
Plug 'sheerun/vim-polyglot'                                                 " [Python] syntax highlighting
Plug 'dense-analysis/ale'                                                   " Linter
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }    " Markdown
Plug 'antoinemadec/FixCursorHold.nvim'                                      " Fix CursorHold behaviour in Neovim. It is needed for coc for example.
call plug#end()


""""""""""""""""
" VIM SETTINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""

""""""""
" Sets "
""""""""
filetype plugin indent on

" Line numbers
set relativenumber          " Relative line numbers
set nu                      " display the absolute line number of the current line
set hidden                  " keep closed buffer open in the background
set clipboard+=unnamedplus  " Use system clipboard
set mouse=a                 " Enable mouse control
set splitbelow              " A new window is put below the current one
set splitright              " A new window is put right of the current one
set noerrorbells            " Disable the error bell for errors
set noswapfile              " Disable the swap file
set undofile                " Automatically save and restore undo history
set incsearch               " Incremental search: show match for partly typed search command
set scrolloff=8             " number of screen lines to show around the cursor
set signcolumn=yes          " whether to show the signcolumn
set colorcolumn=100         " columns to highlight
set laststatus=2            " 0, 1 or 2; when to use a status line for the last window
set encoding=utf-8          " encoding used to print the PostScript file for :hardcopy
set nospell                 " highlight spelling mistakes (local to window)
filetype off
syntax on                   " Enable syntax highlighting
let mapleader=' '           " Set escape as the leader key

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Tab options
set tabstop=4               " number of spaces a <Tab> in the text stands for (local to buffer)
set softtabstop=4           " number of spaces used for each step of (auto)indent (local to buffer)
set shiftwidth=4            " number of spaces used for each step of (auto)indent (local to buffer)
set softtabstop=0           " if non-zero, number of spaces to insert for a <Tab> (local to buffer)
set expandtab               " expand <Tab> to spaces in Insert mode (local to buffer)
set smartindent             " do clever autoindenting

" Folding
set foldmethod=indent       " Set folding type to indent
set foldlevel=99            " Folds with a level higher than this number will be closed

""""""""""""""""""""""""
" Vim-related mappings "
""""""""""""""""""""""""
" Disable macro recording
map q <Nop>

" Quick indentation formatting for the whole file
noremap <F7> gg=G''

" Fix Y behaviour
nnoremap Y y$

" fast buffer navigation
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
nnoremap <C-w> :q<CR>

" save by Ctrl+s
nmap <C-s> :w<CR>

" Quick indentation formatting for the whole file
map <F7> gg=G''

" Comment line or block
vmap <C-b> <plug>NERDCommenterToggle
nmap <C-b> <plug>NERDCommenterToggle

" Split navigations
let g:BASH_Ctrl_j = 'off'
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Esc to clear search results
nnoremap <esc> :noh<return><esc>


"""""""""""""""""
" Basic AutoCmd "
"""""""""""""""""
" Vertically center document when entering insert mode
autocmd InsertEnter * norm zz

" Remove trailing whitespace on save
autocmd BufWrite * %s/\s\+$//e

" yml files indent
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

""""""""""""""
" APPEARANCE "
""""""""""""""

colorscheme gruvbox
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/


"""""""""""""""""""
" Plugin settings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""

"""""""
" FZF "
"""""""
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :History<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>t :Ag TODO<CR>


""""""""""
" TagBar "
""""""""""
nmap <C-g> :TagbarToggle<CR>
let g:tagbar_width = 50
"autocmd FileType python,c,cpp,h,java nested :call tagbar#autoopen(0)


""""""""""""""""""
" Pandoc preview "
""""""""""""""""""
let g:pandoc_preview_pdf_cmd = "zathura"
nnoremap <leader>v :PandocPreview<cr>


"""""""
" COC "
"""""""
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-texlab',
    \ 'coc-markdownlint',
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ ]

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:coc_snippet_next = '<enter>'

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


""""""""""""
" NerdTree "
""""""""""""
map <C-n> :NERDTreeToggle<CR>

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif


"""""""
" ALE "
"""""""
let g:ale_linters = {
            \'python': ['pylint', 'mypy'],
            \'latex': ['chktex']}
let g:ale_set_balloons = 1


""""""""""""
" Markdown "
""""""""""""
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown


""""""""""
" PYTHON "
""""""""""
let g:python3_host_prog = '/usr/bin/python3'
let g:python_highlight_all = 1
let g:SimpylFold_docstring_preview = 1


"""""""""
" LATEX "
"""""""""
autocmd BufRead,BufNewFile *.tex set filetype=tex "| VimtexTocOpen
" autocmd FileType tex setl updatetime=1000
let g:vimtex_view_method = 'zathura'

let g:tex_flavor = 'latex'

let g:vimtex_compiler_progname = 'nvr'

let g:vimtex_quickfix_enabled = 1
let g:vimtex_quickfix_open_on_warning = 0
"nmap <C-m> :VimtexTocToggle <CR>
autocmd FileType tex,latex nnoremap <buffer> m :VimtexView<CR>

autocmd BufReadPre *.tex let b:vimtex_main = 'main.tex'

" Spell check
autocmd FileType tex,latex,markdown setlocal spell spelllang=en,fr

" folding
set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()

" Compile on initialization, cleanup on quit
augroup vimtex_event_1
  au!
  au User VimtexEventQuit     call vimtex#compiler#clean(0)
  au User VimtexEventInitPost call vimtex#compiler#compile()
augroup END

"""""""""""""""""
" FixCursorHold "
"""""""""""""""""
" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100
