set statusline=%m\ %.70f%=%l,%-3v\ (%02p%%)%a
highlight StatusLineNC cterm=NONE,bold ctermbg=237 ctermfg=245
highlight StatusLine cterm=NONE,bold ctermbg=237 ctermfg=10
highlight ModeMsg cterm=NONE,bold ctermbg=15 ctermfg=8

function! UpdateStatusLineColor(mode)
  if a:mode == 'i'
    " insert
    highlight StatusLine ctermfg=14
    highlight ModeMsg ctermbg=14
  elseif a:mode == 'r'
    " replace
    highlight StatusLine ctermfg=9
    highlight ModeMsg ctermbg=9
  elseif a:mode == 'v'
    " virtual replace
    highlight StatusLine ctermfg=9
    highlight ModeMsg ctermbg=9
  elseif a:mode == 'V'
    " visual
    highlight StatusLine ctermfg=214
    highlight ModeMsg ctermbg=214
  elseif a:mode == 'N'
    " normal
    highlight StatusLine ctermfg=10
    highlight ModeMsg ctermbg=15
  endif
endfunction

augroup statusline_color
  au!
  "autocmd InsertEnter * call UpdateStatusLineColor(v:insertmode)
  "autocmd InsertChange * call UpdateStatusLineColor(v:insertmode)
  autocmd InsertLeave * call UpdateStatusLineColor('N')
  " For exiting visual mode with yank or delete
  autocmd TextYankPost * call UpdateStatusLineColor('N')
augroup END

" Handle visual mode toggles
" AFAICT there's no generic 'exit visual' event, so the n Esc resets the color
vnoremap <silent> <Esc> :call UpdateStatusLineColor('N')<CR><Esc>
nnoremap <silent> <Esc> :call UpdateStatusLineColor('N')<CR><Esc>
nnoremap <silent> a :call UpdateStatusLineColor('i')<CR>a
nnoremap <silent> A :call UpdateStatusLineColor('i')<CR>A
nnoremap <silent> i :call UpdateStatusLineColor('i')<CR>i
nnoremap <silent> I :call UpdateStatusLineColor('i')<CR>I
nnoremap <silent> o :call UpdateStatusLineColor('i')<CR>o
nnoremap <silent> O :call UpdateStatusLineColor('i')<CR>O
nnoremap <silent> R :call UpdateStatusLineColor('r')<CR>R
nnoremap <silent> v :call UpdateStatusLineColor('V')<CR>v
nnoremap <silent> V :call UpdateStatusLineColor('V')<CR>V
nnoremap <silent> <C-v> :call UpdateStatusLineColor('V')<CR><C-v>
