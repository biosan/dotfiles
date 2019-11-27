" My NeoVim config

" Install vim-plug automatically
" (https://github.com/junegunn/vim-plug/wiki/tips)
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.dotfiles/neovim/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" Set shell
set shell=/bin/sh

" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'

" Colorschemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jacoborus/tender.vim'
Plug 'chriskempson/base16-vim'

" Plugs to call last
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" CoC Plugins
let g:coc_global_extensions = [
    \ 'coc-word',
    \ 'coc-emoji',
    \ 'coc-highlight',
    \ 'coc-dictionary',
    \ 'coc-lists',
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-python',
    \ 'coc-solargraph',
    \ 'coc-stylelint',
    \ 'coc-css',
    \ 'coc-tsserver'
    \ ]


set mouse+=a
set ignorecase
set smartcase

" ========= Swap, Backup & Undo directories =========
set swapfile
set backup
set writebackup
set undofile
set backupdir=$HOME/.config/nvim/backups
set directory=$HOME/.config/nvim/swaps
set undodir=$HOME/.config/nvim/undos

" colorscheme palenight
colorscheme tender
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


" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'cocstatus', 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
"       \   'right':[ [ ''  ]]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'fugitive#head',
"       \   'cocstatus': 'coc#status'
"       \ },
"       \ }
let g:lightline = {
\ 'colorscheme': 'wombat',
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

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <C-c> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


""" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
