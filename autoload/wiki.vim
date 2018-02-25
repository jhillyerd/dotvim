" wiki.vim: personal wiki functions
if exists('g:loaded_wiki')
  finish
endif
let g:loaded_wiki = 1

" Create a new journal entry, or open existing one
function! wiki#journal()
  let fpath = expand(g:wiki_home) . strftime('/journal/%Y/%m')
  if !isdirectory(fpath)
    call mkdir(fpath, 'p')
  endif
  let fpath = fpath . strftime('/%Y-%m-%d.md')
  execute 'edit ' . fnameescape(fpath)
  if line('$') == 1 && getline(1) == ''
    call append(0, ['#', '', strftime('%A, %B %d, %Y'), ''])
    normal gg
  endif
endfunction
