" .vimrc
" ------
" it is compatible with vim 7.4

"""" multibyte setting
set encoding=utf-8
scriptencoding utf-8
set ambiwidth=double

"""" indentation
set tabstop=4
set shiftwidth=0
set autoindent

"""" makes whitespaces visible
set list
set listchars=tab:\|\ ,trail:_,nbsp:%,extends:>,precedes:<
set backspace=start,eol,indent

"""" highlighting current postion
set cursorline
set cursorcolumn
highlight CursorLine cterm=NONE ctermbg=white
highlight CursorColumn cterm=NONE ctermbg=white

"""" misc
set number
set ruler
set pastetoggle=<Leader>p


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup _
	autocmd!

	autocmd InsertLeave * set nopaste " reset
	autocmd BufWritePost $MYVIMRC source $MYVIMRC " autoreload vimrc
	" autocmd filetype help wincmd L " opens in the right-hand
	autocmd filetype help nnoremap <buffer> q <C-w>c " closes by 1 key
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <Silent><Leader>c :set cursorline! cursorcolumn!<CR> 
nnoremap <Silent><Leader>b :call Switch()<CR>


"""""""" -------- user defined tightly-coupled process --------

"""" switches arrow keys enable/disable
let s:is_strict = 0
function! Switch()
	if s:is_strict
		let s:is_strict = 0
		iunmap <Right>
		iunmap <Up>
		iunmap <Down>
		if has('nvim')
			iunmap <Left>
			iunmap <BS>
		endif
		nunmap <Right>
		nunmap <Left>
		nunmap <Up>
		nunmap <Down>
		nunmap <BS>
		nunmap <CR>
	else
		let s:is_strict = 1
		inoremap <Right> <Nop>
		inoremap <Up> <Nop>
		inoremap <Down> <Nop>
		if has('nvim')
			" inserts unexpected string (c.f. https://github.com/vim-jp/issues/issues/663)
			inoremap <Left> <Nop>
			inoremap <BS> <Nop>
		endif
		nnoremap <Right> <Nop>
		nnoremap <Left> <Nop>
		nnoremap <Up> <Nop>
		nnoremap <Down> <Nop>
		nnoremap <BS> <Nop>
		nnoremap <CR> <Nop>
	endif
endfunction

"""""""" -------- vim plugins --------
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'

if has('vim_starting')
	execute "set runtimepath+=" . s:neobundle_root
endif

"""" initialization
call neobundle#begin(s:bundle_root)
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"""" plugins
NeoBundle 'sudo.vim'
" NeoBundle 'altercation/vim-colors-solarized'
" NeoBundle 'vim-jp/vimdoc-ja'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
