set nocp

filetype plugin on

fixdel

syntax on
"colorscheme darkblue"
"filetype plugin indent on"

"autocmd VimEnter * if !argc() | NERDTree $PWD | endif
autocmd VimEnter * NERDTree $PWD

"this is not working"
"autocmd VimEnter * if argc() == 0 | ConqueTermVSplit bash | endif"

nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>p

"toggle with tags F5
function Toggle()
    exec ':NERDTreeToggle'
    exec ':Tlist'
endfunction
nmap <F2> :call Toggle()<CR>

autocmd BufEnter * lcd %:p:h
"autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

" returns true iff is NERDTree open/active
function! rc:isNTOpen()
   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! rc:syncTree()
    if &modifiable && rc:isNTOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
     endif
endfunction

autocmd BufEnter * call rc:syncTree()

"set tags=/data/tagarwal/umg_kk_64_64/linux/tags,/data/tagarwal/umg_kk_64_64/frameworks/tags"
"set nu"
let c_space_errors=1
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

function FileCScope()
    let curNodePath = g:NERDTreeFileNode.GetSelected().path.str()
    exec ':cs add ' . curNodePath . '/cscope.out '
    exec ':cs show ' . curNodePath . '/cscope.out '
    echo curNodePath . '/cscope.out '
endfunction
nmap <silent> <F3> :call FileCScope()<CR>

function FileTags()
    let curNodePath = g:NERDTreeFileNode.GetSelected().path.str()
    exec ':!ctags -R -f ' . curNodePath . '/tags ' . curNodePath
    echo curNodePath . '/tags '
    exec ':set tags='. curNodePath . '/tags '
endfunction
nmap <silent> <F4> :call FileTags()<CR>

let g:opengrok_jar = '/home/acoskuns/Downloads/myGrokit/grokit/src/grokit_files/opengrok-0.12.1/lib/opengrok.jar'
let g:opengrok_ctags = '/home/acoskuns/Downloads/myGrokit/grokit/src/grokit_files/ctags58/ctags'
let g:opengrok_config_file = '/home/acoskuns/Downloads/myGrokit/grokit/src/grokit_files/projects/v3.18/etc/configuration.xml'
let g:opengrok_java = '/home/acoskuns/Downloads/myGrokit/grokit/src/grokit_files/jre1.7.0_65/bin/java'
