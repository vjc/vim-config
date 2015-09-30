" .vimrc of Victor Cheng
" bits and pieces taken from https://github.com/spf13/spf13-vim

" Environment {
    set nocompatible        " must be first line
    set background=dark     " Assume a dark background

    " Setup Bundle Support {
    " The next two lines ensure that the ~/.vim/bundle/ system works
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
    " }
" }

" Bundles {
    " Deps
        Bundle 'gmarik/vundle'
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
        Bundle 'mileszs/ack.vim'

    " Use local bundles if available {
        if filereadable(expand("~/.vimrc.bundles.local"))
            source ~/.vimrc.bundles.local
        endif
    " }

    " General
        Bundle 'altercation/vim-colors-solarized'
        ""Bundle 'AutoClose'
        Bundle 'kien/ctrlp.vim'
        Bundle 'vim-scripts/bufkill.vim'
        ""Bundle 'matchit.zip'

    " General Programming
        Bundle 'scrooloose/syntastic'
        Bundle 'tpope/vim-fugitive'
        Bundle 'godlygeek/tabular'
        Bundle 'majutsushi/tagbar'
        ""Bundle 'Shougo/neocomplcache'
        Bundle 'vim-scripts/vcscommand.vim'

    " PHP
        Bundle 'spf13/PIV'

    " Python
        " Pick either python-mode or pyflakes & pydoc
        ""Bundle 'klen/python-mode'
        ""Bundle 'python.vim'
        ""Bundle 'python_match.vim'
        ""Bundle 'pythoncomplete'

    " Javascript
        Bundle 'leshill/vim-json'
        Bundle 'groenewege/vim-less'
        Bundle 'taxilian/vim-web-indent'
        Bundle 'kchmck/vim-coffee-script'

    " HTML
        Bundle 'HTML-AutoCloseTag'
        Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'

    " Clojure
        Bundle 'vim-scripts/VimClojure'
" }

" General {
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    set mouse=a                 " automatically enable mouse usage
    scriptencoding utf-8
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " always switch to the current file directory.
    set wildignore+=*/vendor/*

    " set autowrite                  " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set spell                       " spell checking on
    set hidden                      " allow buffer switching without saving

    " Setting up the directories {
        set backup                      " backups are nice ...
        set undofile                    " so is persistent undo ...
        set undolevels=1000 "maximum number of changes that can be undone
        set undoreload=10000 "maximum number lines to save for undo on a buffer reload
        " Could use * rather than *.*, but I prefer to leave .files unsaved
        au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
        au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)
    " }
" }

" Vim UI {
    color solarized                 " load a colorscheme
        let g:solarized_termtrans=1
        let g:solarized_termcolors=16
        let g:solarized_contrast="high"
        let g:solarized_visibility="high"
    colorscheme solarized
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    set cursorline                  " highlight current line

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set list
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace


" }

" Formatting {
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    "set matchpairs+=<:>                " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,coffee,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" }

" Key (re)Mappings {

    "The default leader is '\', but many people prefer ',' as it's in a standard
    "location
    let mapleader = ','

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    """ Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Fix home and end keybindings for screen, particularly on mac
    " - for some reason this fixes the arrow keys too. huh.
    map [F $
    imap [F $
    map [H g0
    imap [H g0

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Toggle folds with space
    nnoremap <space> za

    " Prefer the CommandT style

    nnoremap <C-t> :CtrlP ~/projects/flyerboard<CR>
    nnoremap <C-y> :CtrlP ~/projects/placelocal<CR>

    " Global Search
    nnoremap <C-f> :Ack

    " Don't want to keep holding shift to pull up prompt
    nnoremap ; :

    " Navigate buffers
    nnoremap <A-Right> :bn<CR>
    nnoremap <A-Left> :bp<CR>
    nnoremap <Leader>bd :BD<CR>

    " Navigate windows"
    nmap <silent> <A-k> :wincmd k<CR>
    nmap <silent> <A-j> :wincmd j<CR>
    nmap <silent> <A-h> :wincmd h<CR>
    nmap <silent> <A-l> :wincmd l<CR>
    nmap <C-tab> <C-W>w

    nnoremap <Leader>trim :%s/\s\+$//<CR>
    nnoremap <Leader>diff :VCSDiff<CR>
    nnoremap <Leader>comm :VCSCommit
    """ Insert mode mappings
    " Don't want to keep reaching for ESC, never type jj anyway? Except just now
    inoremap jj <Esc>
" }}}

" Misc {{{
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    let g:pdv_cfg_Package="Flyerboard"
    let g:pdv_cfg_Author="Victor Cheng"
    let g:pdv_cfg_Copyright="(c) 2012 PaperG, Inc."
    let g:pdv_cfg_Version=""
" }

" Plugins {

    " PIV {
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }

    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
    " }

    " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags
    " }

    " EasyTags {
        let g:easytags_cmd = 'ctags'
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    " Tabularize {
        if exists(":Tabularize")
          nmap <Leader>a= :Tabularize /=<CR>
          vmap <Leader>a= :Tabularize /=<CR>
          nmap <Leader>a: :Tabularize /:<CR>
          vmap <Leader>a: :Tabularize /:<CR>
          nmap <Leader>a:: :Tabularize /:\zs<CR>
          vmap <Leader>a:: :Tabularize /:\zs<CR>
          nmap <Leader>a, :Tabularize /,<CR>
          vmap <Leader>a, :Tabularize /,<CR>
          nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
          vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

          " The following function automatically aligns when typing a
          " supported character
          inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

          function! s:align()
              let p = '^\s*|\s.*\s|\s*$'
              if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
                  let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
                  let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
                  Tabularize/|/l1
                  normal! 0
                  call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
              endif
          endfunction

        endif
     " }

     " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
     " }

     " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
     " }

     " ctrlp {
        let g:ctrlp_working_path_mode = 2
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }
     "}

     " TagBar {
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
     "}

     " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <leader>gb :Git checkout 
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
     "}
" }

 " Functions {

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory',
              \ 'undo': 'undodir' }

  for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . dirname . "/"
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else
          let directory = substitute(directory, " ", "\\\\ ", "g")
          exec "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories()

" }

