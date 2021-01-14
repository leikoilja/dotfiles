
" =================
" Startup
" =================
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif

" =================
" Pluggins
" =================

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Themes
Plug 'morhetz/gruvbox'

" NERD Tree - tree explorer
Plug 'scrooloose/nerdtree'

" nerdtree-git-plugin - show git status in NERD Tree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Fuzzy serach both for terminal and vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Enforce editor settings
Plug 'editorconfig/editorconfig-vim'

" Time tracking
Plug 'wakatime/vim-wakatime'

" Language support
Plug 'kchmck/vim-coffee-script'

" The fancy start screen
Plug 'mhinz/vim-startify'

" Python folding
Plug 'tmhedberg/SimpylFold'

" Cursor easymotion
Plug 'easymotion/vim-easymotion'

" Syntax checker
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }

" airline (powerline like statusbar)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" python syntax highlighter
Plug 'kh3phr3n/python-syntax'

" Thesaurus like sinonym backend
Plug 'ron89/thesaurus_query.vim'

" commenter
Plug 'scrooloose/nerdcommenter'

" multiple cursors
Plug 'terryma/vim-multiple-cursors'

" yaml support
Plug 'mrk21/yaml-vim'

" Git blame
Plug 'zivyangll/git-blame.vim'

" Surround
Plug 'tpope/vim-surround'

" Surround-repeat
Plug 'tpope/vim-repeat'

" Snippets
Plug 'honza/vim-snippets'

" Latex support
Plug 'lervag/vimtex'
Plug 'matze/vim-tex-fold'

" Folding
Plug 'matze/vim-tex-fold'
Plug 'Konfekt/FastFold'

" Arduino
Plug 'stevearc/vim-arduino'

" JS & React Native support
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'  " JS and JSX syntax
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'peitalin/vim-jsx-typescript'

Plug 'jparise/vim-graphql'

" Autoformatter
" Plug 'Chiel92/vim-autoformat'

" Autoclose tags
Plug 'alvan/vim-closetag'

" MJML support
Plug 'amadeus/vim-mjml'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Slime
Plug 'jpalardy/vim-slime'

" Neoterm
Plug 'kassio/neoterm'

" Python import sorter
Plug 'fisadev/vim-isort'

" Python black
Plug 'psf/black', { 'branch': 'stable' }

" Asynctasks (VS code inspired tasks)
" Plug 'skywind3000/asynctasks.vim'
" Plug 'skywind3000/asyncrun.vim'

" Lineformatter
" Plug 'leikoilja/nvim-lineformatter'

" Initialize plugin system
call plug#end()


" =================
" Keybindings
" =================
let mapleader=","

" Thesaurus
" wt - word thesaurus
nnoremap <Leader>wt :ThesaurusQueryReplaceCurrentWord<CR>

" CoC
" Code Action
nmap <leader>do <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Show autocomplete when Tab is pressed
inoremap <silent><expr> <Tab> coc#refresh()
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call CocAction('doHover')<CR>
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#util#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(1000, 'ShowDocIfNoDiagnostic')
endfunction

" autocmd CursorHoldI * :call <SID>show_hover_doc()
" autocmd CursorHold * :call <SID>show_hover_doc()

" CoC Snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:UltiSnipsSnippetDirectories = ['/Users/leikoilja/Development/Dev_settings/dotfiles/vim-own-snippets', 'UltiSnips']


" use ,,  for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ,, <Esc>

" Map keys to navigate dropdown
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" go to next buffer
" nnoremap <silent> <leader>bn :bn<CR>
" nnoremap <Tab> :bnext<CR>

" go to previous buffer
" nnoremap <silent> <leader>bp :bp<CR>
" nnoremap <S-Tab> :bprevious<CR>

" close buffer with the window
nnoremap <silent> <leader>bc :bd<CR>

" kill buffer, but not the window
nnoremap <silent> <leader>bk :bp\|bd #<CR>

" kill all the buffers
nnoremap <leader>bak :bufdo bd

" close all windows except current
nnoremap <silent> <leader>wo :only<CR>

" map +- to resize the window
nnoremap <silent> + <C-W>+
nnoremap <silent> - <C-W>-

" clear search highlighted items
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" NERDTree
nnoremap <silent> <leader>n :call MyNerdToggle()<CR>
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>

" Toggle undo tree
nnoremap <F5> :UndotreeToggle<CR> :UndotreeFocus<CR>

" toggle colors to optimize based on light or dark background
nnoremap <leader>ct :call ToggleLightDark()<CR>

" FZF
" Open files in vertical split
nnoremap <silent> <Leader>wv :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

" Open files in horizontal split
nnoremap <silent> <Leader>wh :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

" Locate (grep within the whole system) (search/global)
nnoremap <silent> <Leader>sg :Locate /<CR>

" Grep(silver search) in project (search/project)
" Note ! adds preview
nnoremap <silent> <Leader>sp :Ag!<CR>

" File search in git files of a project
nnoremap <Leader>f :GFiles<CR>

" File search in current working directory
nnoremap <Leader>F :Files<CR>

" File search in current working directory
nnoremap <Leader>gs :BCommits<CR>

" Grep(silver search) in project using the word under cursor
noremap <silent><leader>sw :Ag! <C-r>=expand('<cword>')<CR><CR>

" Change buffer
nnoremap <silent> <Leader>bb :Buffers<CR>

" Better move to end and beginning of line
nnoremap H ^
nnoremap L $

" Copy/Yank the rest of line
nnoremap Y y$

noremap <Leader>ww :update<CR> " Quick save
noremap <Leader>we :e<CR> " Quick reload

" Windows navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Marks tab
nnoremap M :Marks<CR>

" Tag finder
nmap <Leader>t :BTags<CR>

" Terminal mode double pressed leader as Esc
:tnoremap ,, <C-\><C-n>

" Remap CapsLock to AltGt key (mode_switch) when entering vim
" For linux using xmodmap package
" au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

" Return to default when leaving vim
" au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" moving line up and down easily
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap n nzz
nnoremap N Nzz

" Git blame pluggin
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

" Toggle Quick List
noremap <Leader>l :call QFixToggle()<CR>

" Spell check toggle
nnoremap <silent> <F2> :set spell!<cr>
inoremap <silent> <F2> <C-O>:set spell!<cr>
nnoremap <silent> <F3> z=<cr>

" Arduino
nnoremap <Leader>av :ArduinoVerify<CR>
nnoremap <Leader>au :ArduinoUpload<CR>
nnoremap <Leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <Leader>ab :ArduinoChooseBoard<CR>
nnoremap <Leader>ap :ArduinoChooseProgrammer<CR>

" Autoformatter
" noremap <F1> :call AutoFormatCurrentLine()<CR>
noremap <F1> :Autoformat<CR>

" Neoterm
nnoremap <leader>tc :<c-u>exec v:count.'Tclear'<cr>
nnoremap <leader>tt :call JBLRunCurrentTest()<cr>
" Send selected to REPL
vnoremap <leader>tss :TREPLSendSelection<cr>
" Rerun last command
nnoremap <silent> <leader>tl :<c-u>exec printf("%sTexec !! \<lt>cr>", v:count)<cr>

" Python black
" nnoremap <F9> :Black<CR>

" Python darker (applies black only for a modified code)
nnoremap <silent> <F9> :call Darker()<CR>
" Auto call darker on python file save
autocmd BufWritePost *.py call Darker()

" =================
" Configurations
" =================

" EasyMotion cursor
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap S <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap S <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" CoC extensions
let g:coc_global_extensions = [
	\'coc-tsserver',
	\'coc-angular',
	\'coc-css',
	\'coc-cssmodules',
	\'coc-eslint',
	\'coc-highlight',
	\'coc-html',
	\'coc-jedi',
	\'coc-json',
	\'coc-markdownlint',
	\'coc-python',
	\'coc-prettier',
	\'coc-sh',
	\'coc-stylelint',
	\'coc-snippets',
	\'coc-spell-checker',
	\'coc-texlab',
    \'coc-tsserver',
	\'coc-yaml',
	\'coc-xml'
	\]
" \'coc-fzf-preview',

" Asynctasks
" let g:asyncrun_open = 6

" Neovim
let g:python3_host_prog = '/Users/leikoilja/Development/Envs/nvim/bin/python3'

" JS and React Native
let g:vim_jsx_pretty_colorful_config = 1

" Tags autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.js'

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" set folding level for all files
:set foldmethod=indent
:set foldlevelstart=0
:set textwidth=80

" Enable folding with the spacebar
nnoremap <space> za
vnoremap <space> zf

" SimpylFold python code folding
let g:SimpylFold_docstring_preview = 1

" Arduino slime support
let g:arduino_use_slime = 1

" Slime support
let g:slime_target = "tmux"
" let g:slime_dont_ask_default = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom}"}

" turn hybrid(relative and absolute) line numbers on
:set number relativenumber
:set nu rnu

" Automatic toggling between line number modes
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Highlighting for large files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Auto start NERD tree when opening a directory
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" enable line and column display
set ruler

syntax enable
filetype plugin indent on

" Always show statusline
set laststatus=2

" Virtualenv auto detect
let g:virtualenv_auto_activate = 1

" Display invisible characters
set listchars=tab:>\ ,trail:•,extends:>,precedes:<,nbsp:+
set list

" commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Show hidden files (starting with dot)
let g:NERDTreeShowHidden = 1

" insert new line without entering insert mode
nnoremap <A-Enter> o<Esc>k

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" json pretty format (run it by typing gg=G)
au FileType json setlocal equalprg=python\ -m\ json.tool

" Clipboard share
set clipboard=unnamedplus

" Spell languages
set spelllang=en,sv_se

" For Latex
" https://yufanlu.net/2018/09/03/neovim-latex/
" Preview by calling :LLPStartPreview
autocmd Filetype tex setl updatetime=1
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_open_on_warning = 0

" -----------------------------------------------------------------------------
"  VIMTEX OPTIONS
"  ----------------------------------------------------------------------------
if has('unix')
    if has('mac')
        let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer
                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
        let g:vimtex_compiler_progname = 'Users/leikoilja/Development/Envs/nvim/bin/nvr'
        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:tex = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']
            if !empty(system('pgrep Skim'))
            call extend(l:cmd, ['-g'])
            endif
            if has('nvim')
            call jobstart(l:cmd + [line('.'), l:out, l:tex])
            elseif has('job')
            call job_start(l:cmd + [line('.'), l:out, l:tex])
            else
            call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
            endif
        endfunction
    else
        let g:vimtex_compiler_progname = 'nvr'
        let g:vimtex_view_general_viewer = 'okular'
        let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
        let g:vimtex_view_general_options_latexmk = '--unique'
    endif
elseif has('win32')

endif

" TOC settings
let g:vimtex_toc_config = {
      \ 'name' : 'TOC',
      \ 'layers' : ['content', 'todo', 'include'],
      \ 'resize' : 1,
      \ 'split_width' : 50,
      \ 'todo_sorted' : 0,
      \ 'show_help' : 1,
      \ 'show_numbers' : 1,
      \ 'mode' : 2,
      \}

if !has('gui_running')
  set t_Co=256
endif

" Default theme
syntax on
autocmd vimenter * colorscheme gruvbox
" let g:dracula_italic = 0
" colorscheme onedark

" Markdown previewer settings
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 1

" neoterm
let g:neoterm_default_mod = "vertical"
let g:neoterm_autoscroll = 1
" Disable automap keys which is def bind to ,tt
let g:neoterm_automap_keys = 0
let g:neoterm_auto_repl_cmd = 0
" let g:neoterm_repl_python = ['clear', 'ipython']
" let g:neoterm_repl_enable_ipython_paste_magic = 1

" =================
" Custom Functions
" =================
" my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
function! ArduinoStatusLine()
  let port = arduino#GetPort()
  let line = '%f [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
  if !empty(port)
    let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
  endif
  return line
endfunction

" Set Airline status bar
autocmd BufNewFile,BufRead *.ino let g:airline_section_x='%{ArduinoStatusLine()}'

function! Light()
    echom "set bg=light"
    set bg=light
    colorscheme PaperColor
    set list
endfunction

function! Dark()
    echom "set bg=dark"
    set bg=dark
    colorscheme dracula
    "darcula fix to hide the indents:
    set nolist
endfunction

function! ToggleLightDark()
  if &bg ==# "light"
    call Dark()
  else
    call Light()
  endif
endfunction

function! MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

function! Darker()
    " Note: darker pip package must be installed
    if &filetype == 'python'
        let filename = expand('%:p')
        " darker manage.py --isort --lint pylint --lint flake8
        let command = '!darker ' . filename
        try
            silent execute command
            " Reload the current file
            execute ':e'
            echo "Ran Darker on the file '" . filename . "' and reloaded"
        catch
            echo 'Failed to run Darker. Try running manually "darker ' . filename . '"'
        endtry
    endif
endfunction

" Function to run a test JBL test based on a
" place where the cursor is placed
function! JBLRunCurrentTest()
    " Extract test method name
    try
        let method_ln = search('def test_', 'bn')
        let method_name = split(split(getline(method_ln), ' ')[1], '(')[0]
    catch
        echo "Unable to find & process any method for test"
        return
    endtry

    " Extract test class name
    try
        let class_ln = search('^class ', 'bn')
        let class_name = split(split(getline(class_ln), ' ')[1], '(')[0]
    catch
        echo "Unable to find & process any class for test"
        return
    endtry

    " Extracting file path
    try
        let file_name = expand('%')
        let short_file_name = split(split(file_name, 'jbl_web/')[0], '.py')[0]
        let j_file_name = substitute(short_file_name, '/', '.', 'g')
    catch
        echo "Unable to process the file path"
        return
    endtry

    let j_test_path = j_file_name . '.' . class_name . '.' . method_name

    " Note this command uses bash alias for 'jtest'
    let command = 'T ' . 'jtest ' . j_test_path
    echo 'Running test for ' . j_test_path
    try
        execute command
    catch
        echo 'Failed to run test. Check current directory with :pwd'
    endtry

endfunction

function! QFixToggle()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

" function! AutoFormatCurrentLine()
"         let current_line = join([line("."),"-",line(".")])
"         " echo current_line
"         exec "Autoformat ".current_line
" endfunction

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=* Files
  \ call fzf#vim#files(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Likewise, GFiles command wth preview window
command! -bang -nargs=* GFiles
  \ call fzf#vim#gitfiles(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" startify
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [
    \{'rc': '~/Development/Dev_settings/dotfiles/vimrc'},
    \{'a': '~/Development/Dev_settings/dotfiles/aliases'},
    \]

" session management
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
" --------------------------------------------------
" Searching
" --------------------------------------------------
" Enable smartcase (needs ignorecase) - lower finds all / upper finds exact
" Enable incremental search to see matches as we type
set ignorecase
set smartcase
set incsearch
