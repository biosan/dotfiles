" My NeoVim config

let mapleader = ","

""" Set shell
set lazyredraw
set ttyfast

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

set mouse+=a
set ignorecase
set smartcase

" ========= Swap, Backup & Undo directories =========
set swapfile " Defaults to $XDG_DATA_HOME/nvim/swap
set undofile " Defaults to $XDG_DATA_HOME/nvim/undo
" Enable backup file and set directory
" set backup
" set backupdir='$XDG_DATA_HOME/nvim/back/'


" Enable 24bit true color
if (has("termguicolors"))
 set termguicolors
endif

set background=dark
let g:one_allow_italics = 1 " Enable Vim-One colorscheme italics support
let g:onedark_terminal_italics = 1

try
    colorscheme one "dark
catch /.*/
    colorscheme default
endtry

" Non-printable character
" Good UTF-8 chars: ↩ ⠿↯■⌻†‖‡⍀⌇∲⊙∫
set listchars=tab:‣\ ,trail:∬,extends:⇉,precedes:⇇
set list

set showbreak=↪\    " Show wrapped lines

set number          " Lines numbers
set relativenumber  " Lines numbers relative to cursor

set cursorcolumn    " Show cursor column
set cursorline      " Show cursor line
" Text folding
set foldmethod=indent
set foldlevel=12
" --- Indentation settings ---
set tabstop=4    " (ts) width (in spaces) that a <tab> is displayed as
set expandtab    " (et) expand tabs to spaces (use :retab to redo entire file)
set shiftwidth=4 " (sw) width (in spaces) used in each step of autoindent (or << and >>)


let g:lightline = {
\ 'colorscheme': 'one',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'branch', 'readonly', 'relativepath', 'modified' ] ]
\ },
\ 'component': {
\   'lineinfo': ' %3l:%-2v',
\ },
\ 'component_function': {
\   'readonly': 'LightlineReadonly',
\   'branch': 'LightlineFugitive'
\ },
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' }
\ }

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

" CoC config
" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Close buffer
nnoremap <Leader>q :Bwipeout<CR>

""" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

""" Lua Colorizer
try
    lua require'colorizer'.setup()
catch /.*/
endtry

" Performance settings
set norelativenumber
set nocursorline
set nocursorcolumn

function! s:lightline_update()
    try
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    catch
    endtry
endfunction
