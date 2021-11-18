function! neoformat#formatters#javascript#enabled() abort
    return ['semistandard', 'standard']
endfunction

function! neoformat#formatters#javascript#standard() abort
	return {'exe': 'standard'}
endfunction

function! neoformat#formatters#javascript#semistandard() abort
	return {'exe': 'semistandard'}
endfunction
