" init.vim

call plug#begin()

" List your plugins here
Plug 'ThePrimeagen/vim-be-good'
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'preservim/nerdtree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/tokyonight.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'          " The completion plugin
Plug 'hrsh7th/cmp-nvim-lsp'      " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'        " Buffer completions
Plug 'hrsh7th/cmp-path'          " Path completions
Plug 'hrsh7th/cmp-cmdline'       " Command line completions
Plug 'saadparwaiz1/cmp_luasnip'  " Snippet completions
Plug 'L3MON4D3/LuaSnip'          " Snippet engine
Plug 'lewis6991/gitsigns.nvim'
Plug 'thedenisnikulin/vim-cyberpunk'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
call plug#end()

" Enable NerdTree"
autocmd VimEnter * NERDTree | wincmd p


" Enable auto-pairing for parentheses, brackets, etc.
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Surroundings 
vnoremap <silent> S( xi()<esc>P
vnoremap <silent> Sb xi()<esc>P
vnoremap <silent> S[ xi[]<esc>P
vnoremap <silent> S{ xi{}<esc>P
vnoremap <silent> SB xi{}<esc>P
vnoremap <silent> S<lt> xi<lt>><esc>P
vnoremap <silent> S' xi''<esc>P
vnoremap <silent> S" xi""<esc>P

" Enable line numbers
set relativenumber
"Switch screen"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" vertical and horizontal split
nnoremap <C-v> :vs<CR>
nnoremap <C-s> :sp<CR>

" Toggle NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Focus on NERDTree
nnoremap <C-f> :NERDTreeFocus<CR>

" Set tab and indentation settings
set tabstop=4        " Number of spaces that a <Tab> counts for
set shiftwidth=4     " Number of spaces to use for each step of (auto)indent
set expandtab        " Use spaces instead of tabs

" Enable syntax highlighting
syntax on

" Enable 24-bit RGB color in the TUI
set termguicolors

" Set the default colorscheme
colorscheme nightfly 

" Enable mouse support
set mouse=a

" Set the clipboard to use the system clipboard
set clipboard=unnamedplus

" Enable line wrapping
set wrap

" Set the scroll offset
set scrolloff=8       " Keep 8 lines visible above and below the cursor

" Show the sign column
set signcolumn=yes

" Enable incremental search
set incsearch

" Highlight search results
set hlsearch

" Set the command line height
set cmdheight=2

" Set the status line to always be visible
set laststatus=2

" Enable file type detection
filetype plugin indent on

" Set the backup and swap file options
set backupdir=~/.local/share/nvim/backup// " Backup files
set directory=~/.local/share/nvim/swap//    " Swap files
set undodir=~/.local/share/nvim/undo//       " Undo files
set backup              " Enable backup files
set swapfile            " Enable swap files
set undofile            " Enable undo files

" Set the leader key
let mapleader = " "  " Set the leader key to space

" Key mappings
nnoremap <leader>w :w<CR>        " Save file
nnoremap <leader>q :q<CR>        " Quit Neovim
nnoremap <leader>h :set hlsearch!<CR> " Toggle highlight search

augroup FormatOnSave
    autocmd!
    autocmd BufWritePre *.cs lua vim.lsp.buf.format()
augroup END

lua << END 
require('gitsigns').setup()
END

lua << END
require('lualine').setup()
END

lua << EOF
require("nvim-lsp-installer").setup {}
EOF

lua << EOF
local lspconfig = require('lspconfig')


require'lspconfig'.omnisharp.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.clangd.setup{}


EOF

lua << EOF
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For luasnip users.
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
})
EOF

