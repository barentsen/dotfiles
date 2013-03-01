execute pathogen#infect()
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
syntax on

set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set background=light
set number
filetype indent plugin on

let g:pep8_map='<leader>8'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <leader>n :NERDTreeToggle<CR>
