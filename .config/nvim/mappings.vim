" mappings.vim
" Vim mappings configuration
" Callum Howard

" add word under cursor to search pattern
nnoremap <leader>* /<C-R>/\\|\<<C-R><C-W>\><CR><C-O>

" go to alternate file
nnoremap <leader>e :e %<.
nnoremap <leader>E :vs %<.

" toggle diff
function! ToggleDiff()
    if &diff
        windo diffoff
    else
        windo diffthis
    endif
    wincmd w
endfunction

nnoremap <leader>d :call ToggleDiff()<CR>

let g:tbone_write_pane='bottom-right'
nnoremap <leader>t V:Twrite<CR>
xnoremap <leader>t :Twrite<CR>

" gina mappings
nnoremap <leader>a :GitGutterStageHunk<CR>
nnoremap <leader>gs :Gina status<CR>
nnoremap <leader>gc :Gina commit<CR>
nnoremap <leader>gp :Gina push<CR>
nnoremap <leader>g :Gina 
nnoremap <silent> <leader>b :Gina browse : --scheme=blame<CR>

" xcode mappings
"nnoremap <silent> <leader>r :wa <bar> silent exec "!xcoderun.sh ".getcwd()."/xcode/ ".fnamemodify(getcwd(), ':t').".xcodeproj &" <bar> redraw!<CR>
"nnoremap <silent> <leader>x :wa <bar> silent exec "!xcodeopen.sh ".getcwd()."/xcode/ ".fnamemodify(getcwd(), ':t').".xcodeproj ".line('.')." ".@%." &" <bar> redraw!<CR>
nnoremap <silent> <leader>r :wa <bar> silent exec "!xcoderun.sh ".getcwd()."/xcode/ AudioClassifier.xcodeproj &" <bar> redraw!<CR>
nnoremap <silent> <leader>x :wa <bar> silent exec "!xcodeopen.sh ".getcwd()."/xcode/ AudioClassifier.xcodeproj ".line('.')." ".@%." &" <bar> redraw!<CR>

" dot command works on ranges
xnoremap . :normal .<CR>

" wrapped line movement mappings (adds larger jumps to jumplist)
nnoremap <expr> j v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count > 5 ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

tnoremap <C-A>o <C-\><C-N><C-W><C-W>

" prevent jump after searching word under cursor with # and *, clear with Escape
nnoremap <silent> # :let save_cursor=getcurpos()\|let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>w?<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
nnoremap <silent> * :let save_cursor=getcurpos()\|let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
nnoremap <silent> g# :let save_cursor=getcurpos()\|let @/ = expand('<cword>')\|set hlsearch<CR>w?<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
nnoremap <silent> g* :let save_cursor=getcurpos()\|let @/ = expand('<cword>')\|set hlsearch<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>
nnoremap <silent> <Esc> :noh<CR>

" unimpaired quickfix mappings
nnoremap <silent> <leader>q :cw<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" unimpaired location list mappings
nnoremap <silent> <leader>l :cw<CR> :lw<CR>
nnoremap <silent> [l :lprevious<CR>zmzv
nnoremap <silent> ]l :lnext<CR>zmzv
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" unimpaired buffer mappings
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" accordion expand traversal of folds
nnoremap <silent> z] :<C-u>silent! normal! zc<CR>zjzozz
nnoremap <silent> z[ :<C-u>silent! normal! zc<CR>zkzo[zzz

" resync folds
nnoremap <leader>f :set foldmethod=syntax<CR>

" quickly set foldlevel
nnoremap <leader>1 :set foldnestmax=1<CR>
nnoremap <leader>2 :set foldnestmax=2<CR>
nnoremap <leader>3 :set foldnestmax=3<CR>

" insert closing curly brace
inoremap <expr> {<Enter> <SID>CloseBracket()

" convert c-style prototypes to functions
nnoremap <leader>; :keeppatterns %s/;$/ {\r\r}\r<CR>:noh<CR><C-O>
xnoremap <leader>; :s/;$/ {\r\r}\r<CR>:noh<CR><C-O>

" jump to #includes and add a new include prepolulated with word under cursor
nnoremap <leader>i m`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include <<C-R>1><Esc>hvi><C-G>
nnoremap <leader>I m`"1yiw:keepjumps keeppatterns ?^#include<CR>o#include "<C-R>1.h"<Esc>hvi"<C-G>

" add function prototype for function under cursor
nnoremap <silent> <leader>p yy:keeppatterns ?^#include\><CR>jp:keeppatterns s/\s*{$/;<CR>:silent! keeppatterns s/(\zs\ze);/void<CR>:noh<CR><C-O>
xnoremap <silent> <leader>p y:keeppatterns ?^#include\><CR>jp:keeppatterns s/\s*{$/;<CR>:silent! keeppatterns s/(\zs\ze);/void<CR>:noh<CR><C-O>

" remove trailing whitespace
nnoremap <silent> <leader><Space> :keeppatterns %s/\s\+$//e<CR><C-O>
xnoremap <silent> <leader><Space> :keeppatterns s/\s\+$//e<CR><C-O>

" global substitution on last used search pattern
nnoremap <leader>s :%s///g<Left><Left>
xnoremap <leader>s :s///g<Left><Left>

" restrict search to comment
"nnoremap <leader>c ?\v(//|#).*\zs
nnoremap <leader>c ?//.*\zs
xnoremap <leader>c ?//.*\zs

" convert search pattern to match whole word only
nnoremap <leader>w /\<<C-R>/\><CR><C-O>
"TODO add the inverse

augroup TerminalConfig
    au!
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
tnoremap <C-W><C-W> <C-\><C-N><C-W><C-W>

let g:netrw_is_open=0
function! ToggleNetrw()
    if g:netrw_is_open
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:netrw_is_open=0
    else
        let g:netrw_is_open=1
        silent Lexplore
    endif
endfunction

nnoremap <silent> <Leader>\ :call ToggleNetrw()<CR>
cabbrev cd. <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'lcd %:p:h\|pwd' : 'cd.')<CR>

" grep for word under cursor
nmap <Leader># #:sil! gr! "\b<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>
"nmap <Leader>* #:sil! gr! "\b<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>

" fuzzy command mappings
cabbrev vf <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert sf' : 'vf')<CR>
cabbrev vsf <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert sf' : 'vsf')<CR>
cabbrev ef <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'fin' : 'ef')<CR>

" wrap git grep
function! Ggrep(arg)
    let s:temp=&grepprg
    setlocal grepprg=git\ grep\ --ignore-case\ --no-color\ -n\ $*
    silent execute ':grep '.a:arg
    setlocal grepprg=git\ --no-pager\ submodule\ --quiet\ foreach\ 'git\ grep\ --full-name\ -n\ --ignore-case\ --no-color\ $*\ ;true'
    silent execute ':grepadd '.a:arg
    silent cwin
    redraw!
    setlocal grepprg=s:temp
endfunction

command! -nargs=1 -complete=buffer Gg call Ggrep(<q-args>)|let @/="<args>"|set hls
cabbrev gg <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gg' : 'gg')<CR>

" use Ag/Rg for grep if available
if executable('rg') | set gp=rg\ -S\ --vimgrep\ --no-heading gfm=%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m|
elseif executable('ag') | set gp=ag\ --nogroup\ --nocolor\ --ignore\ build | endif
com! -nargs=+ -complete=file -bar Rg sil! gr! <args>|cw|redr!|let @/="<args>"|set hls
com! -nargs=+ -complete=file -bar Ag sil! gr! <args>|cw|redr!|let @/="<args>"|set hls
cabbrev rg <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Rg' : 'rg')<CR>
cabbrev ag <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Ag' : 'ag')<CR>

" MRU command-line completion
function! s:MRUComplete(ArgLead, CmdLine, CursorPos)
    return filter(map(copy(v:oldfiles), 'fnamemodify(v:val, ":~:.")'), 'v:val =~ a:ArgLead')
endfunction

" browse most recently opened files with :O or :o
command! -nargs=? -complete=customlist,<sid>MRUComplete O if empty("<args>") | :browse oldfiles | else | :e <args> | endif
cabbrev o <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'O' : 'o')<CR>

function! s:CloseBracket()
    let line = getline('.')
    if line =~# '^\s*\(struct\|class\|enum\) '
        return "{\<Enter>};\<Esc>O"
    elseif searchpair('(', '', ')', 'bmn', '', line('.'))
        " Probably inside a function call. Close it off.
        return "{\<Enter>});\<Esc>O"
    else
        return "{\<Enter>}\<Esc>O"
    endif
endfunction

" don't close split when deleting a buffer
command Bd bp\|bd #

