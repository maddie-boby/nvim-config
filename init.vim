set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set list
" set spell                 " enable spell check (may need to download language package)
set termguicolors

lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
EOF

call plug#begin()

Plug 'tpope/vim-sensible'
" Visual stuff
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'EdenEast/nightfox.nvim' 
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" LSP
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Rust
Plug 'simrat39/rust-tools.nvim'

" Rust Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" coq
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

call plug#end()

lua require('mason').setup()
lua require('mason-lspconfig').setup()
lua require('lspconfig').clangd.setup({})
lua require('lspconfig').pyright.setup({})
lua require('lspconfig').perlnavigator.setup({})
lua require('lspconfig').intelephense.setup({})
lua require('lspconfig').ruby_ls.setup({})
lua require('lspconfig').gopls.setup({})
lua require('lspconfig').tsserver.setup({})

lua require('rust-tools').setup()

" init coq
lua << EOF
vim.g.coq_settings = {
    auto_start = 'shut-up'
}
local coq = require('coq')
EOF

lua require('lualine').setup()

lua require('nvim-tree').setup()

lua require('telescope').setup()
lua require('telescope').load_extension('fzf')

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 noexpandtab

colorscheme nightfox
