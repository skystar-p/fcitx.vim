scriptencoding utf-8
" fcitx.vim	remember fcitx's input state for each buffer
" Author:       lilydjwg
" Version:	2.0a
" URL:		https://www.vim.org/scripts/script.php?script_id=3764
" ---------------------------------------------------------------------
" Load Once:
if &cp || exists("g:loaded_fcitx") || (!exists('$DISPLAY') && !exists('$WAYLAND_DISPLAY'))
  finish
endif
let s:keepcpo = &cpo
set cpo&vim

function s:setup_cmd()
  function Fcitx2en()
    let inputstatus = trim(system(g:fcitx5_remote))
    if inputstatus == '2'
      let b:inputtoggle = 1
      call system(g:fcitx5_remote . ' -c')
    endif
  endfunction

  let g:loaded_fcitx = 1
endfunction

" If g:fcitx5_remote is set (to the path to `fcitx5-remote`), use it to toggle IME state.
if exists("g:fcitx5_remote")
  call s:setup_cmd()
else
  " error
  echoerr 'fcitx.vim: fcitx5_remote is required. Please set g:fcitx5_remote to the path to `fcitx5-remote`.'
  finish
endif

" Register autocmd if successfully loaded.
if exists("g:loaded_fcitx")
  if exists('##InsertLeavePre')
    au InsertLeavePre * if reg_executing() == "" | call Fcitx2en() | endif
  else
    au InsertLeave * if reg_executing() == "" | call Fcitx2en() | endif
  endif
endif

" ---------------------------------------------------------------------
"  Restoration And Modelines:
let &cpo=s:keepcpo
unlet s:keepcpo

" vim: sw=2 :
