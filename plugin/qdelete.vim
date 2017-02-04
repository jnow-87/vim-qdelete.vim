""""
"" initialisation
""""
"{{{
if exists('g:loaded_qdelete') || &compatible
	finish
endif

let g:loaded_qdelete = 1

""""
"" local functions
""""

" \brief	delete line from cursor till user supplied character
"
" \param	feedkey		key to feed once function has finished
" 						intended to switch modes
function s:del_until(feedkey)
	let m = nr2char(getchar())
	let c = nr2char(getchar())

	exec "normal! d" . m . c

	" feed supplied key
	if a:feedkey != ""
		call feedkeys(a:feedkey)
	endif
endfunction


" \brief	delete lines that contain the given string
"
" \param	s		string to search for
" \param	count	repetition count
function s:del_line(s, count)
	echom a:count
	exec "let @a='/" . a:s . "\<cr>dd'"
	exec "silent! normal!" . a:count . "@a"
endfunction


""""
"" commands
""""
command -range -count -nargs=1 DelLine call s:del_line(<f-args>, <count>)


""""
"" mappings
""""
nnoremap dl :DelLine 
inoremap <silent> <c-d> <right><esc>:call <sid>del_until('i')<cr>
nnoremap <silent> <c-d> :call <sid>del_until('')<cr>
