" Vim plugin for copy code
" LAST CHANGE : 2022.7.7
" License : This file is placed in the public domain.

if exists("g:loaded_copy")
  finish
endif

let g:loaded_copy=1
let s:dii={}
let s:address = expand('<sfile>:p:h:h')
"echo s:address

function s:Init()
  let s:list=readfile(s:address . "/.config")
  for item in s:list
    let s:tmp=split(item,':')
	for key in split(s:tmp[1],',')
	  let s:dii[key]=s:tmp[0]
	endfor
  endfor
endfunction

function Copycode(name)
  "echo '[I] ' . a:name
  " find the value
  try
    let s:filename=s:dii[a:name]
  catch /E716:/
    echo '[X] key not found'
	return
  catch
    echo '[X] error'
  endtry
  "echo '[O] filename: 's:filename
  let s:path=s:address . '/codes/' . s:filename
  "read s:address . '/codes/' . s:filename
  echo s:path
  exec 'read '. s:path
  "read s:path
  "echo '[O] done'
endfunction


call s:Init()

if !exists(":Coco")
  command -nargs=1 Coco call Copycode(<q-args>)
endif
