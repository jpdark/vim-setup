syntax on

colorscheme monokai_pro

set number
set encoding=utf-8
set laststatus=2
set timeoutlen=1000 ttimeoutlen=0
set eol
set nowrap
set pastetoggle=<F3>

filetype plugin on

set textwidth=99
" CORRECT TABS
" On pressing tab, insert 4 spaces
set expandtab
set softtabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
autocmd FileType hcl setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd BufRead *.map set filetype=map
autocmd FileType map setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" INDENTATION
set smartindent
set background=dark
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermbg=237
hi IndentGuidesEven ctermbg=238

if !has('gui_running')
  set t_Co=256
endif

" Load all packages now
packloadall
" Generate help tags from all packages and ignore errors
silent! helptags ALL

" Change key to activate shortcut
let mapleader = " "

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" FZF
set rtp+=~/.fzf
nmap <C-p> :GFiles<CR>
nmap <C-@> :GFiles?<CR>
nmap <C-g> :Ag<CR>
nmap <C-e> :Buffers<CR>
let g:fzf_action = { 'ctrl-e': 'edit',
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" close all buffers except one
command! BufCurOnly execute '%bdelete|edit#|bdelete#'

" LOCALVIMRC
" whitelist all local vimrc files in users project foo and bar
let g:localvimrc_whitelist='/home/jpdark/dev/\(solarmonkey\|terasol\)/.*'

" GITGUTTER
nnoremap <c-U> :GitGutterUndoHunk<CR>
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" AUTOCOMPLETE
let g:ycm_auto_trigger=1
let g:ycm_python_binary_path = "/usr/bin/python3.8"

" SYNTAX HIGHLIGHTING
let g:python_highlight_all = 1

" LIGHTLINE
let g:lightline = {
  \     'active': {
  \         'left': [
  \             ['mode', 'paste' ],
  \             ['gitbranch', 'readonly', 'filename', 'modified']
  \         ],
  \         'right': [
  \             ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'] ,
  \             ['lineinfo'],
  \             ['percent'],
  \             ['fileformat', 'filetype', 'fileencoding'],
  \         ],
  \     },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
  \ }

" ALE (LINTING)
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'python': ['flake8'],
\   'cpp': ['clang'],
\   'c': ['clang']
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'jsx': ['prettier'],
\   'python': ['black', 'isort'],
\}
let g:ale_python_black_executable = 'black'
let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_isort_executable = 'isort'
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ALE-LIGHTLINE
let g:lightline.component_expand = {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_info': 'lightline#ale#info',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\ }
let g:lightline.component_type = {
\   'linter_checking': 'left',
\   'linter_infos': 'right',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\ }
let g:lightline#ale#indicator_checking = "⏳ "
let g:lightline#ale#indicator_warnings = "⚠ "
let g:lightline#ale#indicator_errors = "✘ "
let g:lightline#ale#indicator_ok = "✔ "

" Mappings
map <F6> :NERDTreeToggle<CR>

command! Bd bp | sp | bn | bd

" GITGUTTER
nnoremap <C-l> :GitGutterAll<CR>

au BufRead,BufNewFile *.rst setlocal textwidth=80

" SESSIONS
let g:session_autoload = 'no'
function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  if a:overwrite == 0 && !empty(glob(b:filename))
    return
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession(1)
else
  au VimLeave * :call MakeSession(0)
endif

" VIM-TEST
let test#strategy = 'vimux'
let test#python#pytest#executable = 'poetry run pytest'

set tags=.tags;/
au BufWritePost *.py,*.c,*.cpp,*.h silent! !ctags -R -f .tags &

nmap <F8> :TagbarToggle<CR>
