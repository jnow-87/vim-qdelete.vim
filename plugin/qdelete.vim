if exists('g:loaded_qdelete') || &compatible
	finish
endif

let g:loaded_qdelete = 1

" get own script ID
nmap <c-f11><c-f12><c-f13> <sid>
let s:sid = "<SNR>" . maparg("<c-f11><c-f12><c-f13>", "n", 0, 1).sid . "_"
nunmap <c-f11><c-f12><c-f13>


""""
"" global variables
""""
"{{{
let g:qdelete_map_delete_line = get(g:, "qdelete_map_delete_line", "dl")
let g:qdelete_map_delete_init = get(g:, "qdelete_map_delete_init", "<c-d>")
"}}}

""""
"" local functions
""""
"{{{
" \brief	delete line from cursor till user supplied character
"
" \param	feedkey		key to feed once function has finished
" 						intended to switch modes
function s:del_until(feedkey)
	echo "f: forward, t: till, i: inner, a: outer"

	let m = nr2char(getchar())
	let c = nr2char(getchar())

	exec "normal! d" . m . c

	" feed supplied key
	if a:feedkey != ""
		call feedkeys(a:feedkey)
	endif
endfunction
"}}}

"{{{
" \brief	delete lines that contain the given string
"
" \param	s		string to search for
" \param	count	repetition count
function s:del_line(s, count)
	echom a:count
	exec "let @a='/" . a:s . "\<cr>dd'"
	exec "silent! normal!" . a:count . "@a"
endfunction
"}}}

""""
"" commands
""""
"{{{
command -range -count -nargs=1 DelLine call s:del_line(<f-args>, <count>)
"}}}

""""
"" mappings
""""
"{{{
call util#map#n(g:qdelete_map_delete_line, ":DelLine ", "nosilent")
call util#map#i(g:qdelete_map_delete_init, ":call " . s:sid . "del_until('i')<cr>", "noinsert nosilent")
call util#map#n(g:qdelete_map_delete_init, ":call " . s:sid . "del_until('')<cr>", "nosilent")
"}}}
