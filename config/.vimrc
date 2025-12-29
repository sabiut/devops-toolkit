" DevOps Toolkit - Vim Configuration

" General settings
set nocompatible
set encoding=utf-8
set fileencoding=utf-8

" UI settings
set number
set relativenumber
set cursorline
set showcmd
set showmode
set wildmenu
set laststatus=2
set ruler
set scrolloff=5

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Editor behavior
set backspace=indent,eol,start
set wrap
set linebreak
set mouse=a
set clipboard=unnamedplus

" File handling
set autoread
set noswapfile
set nobackup
set nowritebackup
set hidden

" Colors and syntax
syntax on
set background=dark
set t_Co=256

" Status line
set statusline=%f\ %m%r%h%w\ [%{&ff}]\ [%Y]\ [%l,%c]\ [%p%%]

" Key mappings
let mapleader=" "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>n :noh<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

" YAML settings (common in DevOps)
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType yml setlocal tabstop=2 shiftwidth=2 expandtab

" Dockerfile syntax
autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile

" Terraform files
autocmd BufNewFile,BufRead *.tf set filetype=terraform
autocmd BufNewFile,BufRead *.tfvars set filetype=terraform
