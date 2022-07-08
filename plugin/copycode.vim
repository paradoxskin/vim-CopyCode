" Vim plugin for copy code
" LAST CHANGE : 2022.7.8
" License : This file is placed in the public domain.

if exists("g:loaded_copy")
  finish
endif

let g:loaded_copy=1
let s:dii={}
let s:address = expand('<sfile>:p:h:h')
let s:islinux='/'

function s:Init()
  if has('win32') || has('win64')
    let s:islinux='\'
  endif
  let s:list=readfile(s:address . s:islinux .".config")
  for item in s:list
    let s:tmp=split(item,':')
	for key in split(s:tmp[1],',')
	  let s:dii[key]=s:tmp[0]
	endfor
  endfor
endfunction

function Copycode(name)
  try
    let s:filename=s:dii[a:name]
  catch /E716:/
    echo '[X] key not found'
	return
  catch
    echo '[X] error'
  endtry
  let s:path=s:address . s:islinux . 'codes' . s:islinux . s:filename
  norm jmjk
  exec 'read '. s:path
endfunction


call s:Init()

if !exists(":Coco")
  command -nargs=1 Coco call Copycode(<q-args>)
endif
