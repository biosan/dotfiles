" ===== VIM-PLUG =====

" Install vim-plug and all the plugins when its not installed
" (https://github.com/junegunn/vim-plug/wiki/faq)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.dotfiles/vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" ========= PLUG =========
call plug#begin('~/.dotfiles/vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'w0rp/ale'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'

" --- Coding ---
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Python
Plug 'nvie/vim-flake8'
Plug 'fs111/pydoc.vim'
Plug 'zchee/deoplete-jedi'
" C & Co.
Plug 'zchee/deoplete-clang'
" Swift
Plug 'landaire/deoplete-swift'
" CSS
Plug 'ap/vim-css-color'
" Rails
Plug 'tpope/vim-rails'

" --- Prose ---
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'
"Plug 'reedes/vim-lexical'
" Markdown
"Plug 'nelstrom/vim-markdown-folding'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'tpope/vim-liquid'
"Plug 'dhruvasagar/vim-table-mode'
"Plug 'tpope/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" LaTeX
"Plug 'poppyschmo/deoplete-latex'
"Plug 'lervag/vimtex'

" --- macOS Specific ---
Plug 'sjl/vitality.vim'
Plug 'jonhiggs/MacDict.vim'

" --- Appearance ---
Plug 'reedes/vim-thematic'
" --- Colorschemes ---
Plug 'romainl/Apprentice'
Plug 'altercation/vim-colors-solarized'
Plug 'gilgigilgil/anderson.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'nelstrom/vim-mac-classic-theme'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'
Plug 'ewilazarus/preto'
Plug 'chriskempson/base16-vim'
Plug 'baeuml/summerfruit256.vim'
Plug 'joshdick/onedark.vim'
Plug 'trusktr/seti.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'reedes/vim-colors-pencil'
Plug 'arcticicestudio/nord-vim'
Plug 'connorholyday/vim-snazzy'
Plug 'jacoborus/tender.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'logico-dev/typewriter'
Plug 'nathanlong/vim-colors-writer'
Plug 'YorickPeterse/happy_hacking.vim'
Plug 'rakr/vim-one'
Plug 'owickstrom/vim-colors-paramount'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'fenetikm/falcon'
Plug 'mhartington/oceanic-next'


" --- Plugs to call last ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

call plug#end()
" ---------------


" ========= Mappings =========
" Movement
map j gj
map k gk


" ========= Swap, Backup & Undo directories =========
set swapfile
set backup
set writebackup
set undofile
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
set undodir=$HOME/.vim/undos

" ========= Search settings =========
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <silent> <Leader>/ :nohlsearch<CR>  " Switch off current search highlight


" ========= Autocommands =========
" --- PGP/GPG files ---
" Make sure nothing will be written on disk
autocmd BufReadPre,FileReadPre *.{gpg,asc,pgp} setlocal viminfo=
autocmd BufReadPre,FileReadPre *.{gpg,asc,pgp} setlocal noswapfile noundofile nobackup
" --- Pass ---
" Make sure nothing will be written on disk
autocmd BufReadPre,FileReadPre /private/* setlocal viminfo=
autocmd BufReadPre,FileReadPre /private/* setlocal noswapfile noundofile nobackup

" ========= iTerm and system integration =========
" Enable mouse in any mode
set mouse+=a

" ========= Language and spell checking =========
" Set Vim language
language en_US.UTF-8
" Set spell checking languages (English & Italian)
set spelllang=en ",it

" ========= Appearance =========
" Enable True Color (24-bit) when in NeoVim
colorscheme base16-oceanicnext
set background=dark
set termguicolors
let ayucolor="light"
set showtabline=1
"let g:guifont=FuraCodeNerdComplete-Retina:h14


" ========= Plugins =========
" Vim-Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
" Deoplete
let g:deoplete#enable_at_startup = 1
" LanguageClient
set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" Indent guide lines
let g:indent_guides_auto_colors = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" PyDoc
autocmd CursorMovedI * if pumvisible() == 0 | pclose | endif  " Automatically close the PyDoc buffer when
autocmd InsertLeave * if pumvisible() == 0 | pclose| endif    " leaving insert mode or moving the cursor
" Limelight
let g:limelight_conceal_ctermfg = 'gray'   " Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray' " Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.5  " Dim coefficient
let g:limelight_paragraph_span = 0         " Number of preceding/following paragraphs to include (default: 0)
let g:limelight_priority = -1              " Highlighting priority (default: 10). Set it to -1 not to overrule hlsearch
" Vim-Pencil
let g:pencil#wrapModeDefault = 'soft'  " Set soft wrap mode as default
" Pandoc
let g:pandoc#formatting#equalprg = 'pandoc -t markdown_mmd --no-wrap --atx-headers'
let g:pandoc#syntax#codeblocks#embeds#langs = ["python", "c", "ruby", "cpp","bash=sh"]  " Enable syntax highlighting in markdown's fenced codeblocks for the listed languages
" Plastiboy/Mardown
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_math = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" Goyo
let g:goyo_width = "120"
let g:goyo_height = "80%"
let g:goyo_liner = "0"
" MacDict
map <C-d> "dyiw:call MacDict(@d)<CR>  " Search the word under cursor



""""""""""""""""""""""
""""  CODE SETUP  """"
""""""""""""""""""""""
func! Code()

    " Colorscheme
    colorscheme base16-oceanicnext
    set background=dark
    " Non-printable character
    " Good UTF-8 chars: ↩ ⠿↯■⌻†‖‡⍀⌇∲⊙∫
    set listchars=tab:‣\ ,trail:∬,extends:⇉,precedes:⇇
    set list
    " Show wrapped lines
    set showbreak=↪\ 
    " Lines numbers
    set number
    set relativenumber
    " Show cursor column and line
    set cursorcolumn
    set cursorline
    " Text folding
    set foldmethod=indent
    set foldlevel=99
    " --- Indentation settings ---
    set tabstop=4    " (ts) width (in spaces) that a <tab> is displayed as
    set expandtab    " (et) expand tabs to spaces (use :retab to redo entire file)
    set shiftwidth=4 " (sw) width (in spaces) used in each step of autoindent (or << and >>)
    " --- Plugins ---
    NoPencil
    GitGutterEnable

endfu



"""""""""""""""""""""""
""""  PROSE SETUP  """"
"""""""""""""""""""""""
func! Prose()

    " Colorscheme
    colorscheme PaperColor
    AirlineTheme pencil
    set background=light
    " Non-printable character
    " Good UTF-8 chars: ⠿↯■⌻†‖‡⍀⌇∲⊙∫
    set listchars=tab:‣\ ,trail:∬,extends:⇉,precedes:⇇
    set list
    " Show wrapped lines
    set showbreak=↪\ 
    " Lines numbers
    set nonumber
    set norelativenumber
    " Show cursor column and line
    set nocursorcolumn
    set cursorline
    " Text folding
    set foldmethod=indent
    set foldlevel=99
    " Spellcheck
    set spelllang=
    " --- Indentation settings ---
    set tabstop=4    " (ts) width (in spaces) that a <tab> is displayed as
    set expandtab    " (et) expand tabs to spaces (use :retab to redo entire file)
    set shiftwidth=4 " (sw) width (in spaces) used in each step of autoindent (or << and >>)

    " --- Plugins ---
    Pencil
    GitGutterDisable
    let g:ale_linters={'text':['proselint', 'vale']}
    AirlineTheme pencil
    " Pandoc
    set foldcolumn=8
    let g:pandoc#folding#fdc = 8

endfu


""""""""""""""""""""
"""" FOCUS MODE """"
""""""""""""""""""""
func! Focus()

    Limelight!!
    Goyo

endfu

com! Prose call Prose()
com! Code call Code()
com! Focus call Focus()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ProseOrCode = 1

func! ChooseProseOrCode()
    if g:ProseOrCode
        call Code()
    else
        call Prose()
    endif
endfu

augroup SetProse
    autocmd FileType text,markdown,mkd,md,tex,latex let g:ProseOrCode=0
augroup END

autocmd BufNewFile,BufRead * call ChooseProseOrCode()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
