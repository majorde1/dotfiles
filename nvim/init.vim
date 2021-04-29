call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
  Plug 'chrisbra/csv.vim'
  Plug 'simeji/winresizer'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'simnalamburt/vim-mundo'
  Plug 'neoclide/coc.nvim'
  Plug 'honza/vim-snippets'
  Plug 'jez/vim-superman'
  Plug 'google/vim-maktaba'
  Plug 'bazelbuild/vim-bazel'
  Plug 'google/vim-codefmt'
  Plug 'google/vim-glaive'
call plug#end()
call glaive#Install()

colorscheme majorde

set nohlsearch
set hidden
set clipboard+=unnamedplus

" no swap file: allows multiple Vim instances to open a file at once.
set noswapfile

" save undo-trees in files
set undofile
set undodir=$HOME/.config/nvim/undo

" number of undo saved
set undolevels=10000
set undoreload=10000

" set line number
set number

" use 2 spaces instead of tab ()
" cop yindent from current line when starting a new line
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" chrisbra/csv.vim config
augroup csv
  au!
  autocmd BufRead,BufWritePost *.csv :%ArrangeColumn!
  autocmd BufWritePre *.csv :%UnArrangeColumn
augroup END

" simeji/winresizer config
let g:winresizer_start_key = "<leader>w"

" junegunn/fzf.vim config
" See https://github.com/junegunn/fzf.vim for additional commands.
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fht :Helptags<CR>
nnoremap <leader>fh: :History:<CR>
nnoremap <leader>fh/ :History/<CR>
nnoremap <leader>fm :Maps<CR>

" google/vim-codefmt"
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /home/majorde/bin/jar_files/google-java-format-1.10.0-all-deps.jar"
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
augroup END

" neoclide/coc.nvim
source ~/.config/nvim/config/coc.vim

" Custom statusline
source ~/.config/nvim/config/statusline.vim
