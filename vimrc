call plug#begin('~/.vim/plugged')
""Plug 'valloric/youcompleteme'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
""Plug 'vim-ruby/vim-ruby'
Plug 'shougo/neocomplete.vim'
Plug 'ervandew/supertab'
""Plug 'scrooloose/syntastic'
Plug 'powerline/powerline'
Plug 'artur-shaik/vim-javacomplete2'




Plug 'kien/ctrlp.vim'
Plug 'mhinz/vim-startify'
""Plug 'YankRing.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'plasticboy/vim-markdown'

"Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
"git
"Plug 'tpope/vim-fugitive'
""Plug '/Users/zhuyichen/git/codeForLearn/ijaas/vim'
"js
Plug 'pangloss/vim-javascript'


Plug 'fatih/vim-go'

Plug 'tomasr/molokai'
Plug 'flazz/vim-colorschemes'

"对齐
Plug 'godlygeek/tabular'

"dash集成
Plug 'rizzatti/dash.vim'
call plug#end()


"去掉vi兼容
set nocompatible
"设置语言，英文，避免各种问题，
""lang en_US.utf8
"检查文件类型检查
filetype indent on
"打开语法高亮
syntax on
"不要生成备份文件
set nobackup
set noswapfile
set ruler
"设置行号
set number
"设置相对行号
set relativenumber
"退格键恢复正常
set backspace=2
"如果文件有改变，自动读取
set autoread
"设置tab，长度为4，
set tabstop=4
""set softtabstop=4
set shiftwidth=4
set expandtab
"hlsearch让Vim高亮文件中所有匹配项，incsearch则令Vim在你正打着搜索内容时就高亮下一个匹配项
set hlsearch incsearch
"把所有的数字都当成十进制
set nrformats=
"指定配色方案为256色
set t_Co=256
"高亮当前行列
set cursorline
set cursorcolumn
"配置主题
colorscheme molokai
"配置背景色
set bg=dark
"背景色和终端一致
""hi Normal ctermbg=none
"比如有个"，那没有这个选项会自动补全
set paste
"但是set paste会不让自动补全{，所以
autocmd BufNewFile *.c,*.cpp,*.java,*.rb,*.js,*.py,*.rs,*.go,\.vimrc execute "set nopaste"
autocmd BufReadPost *.c,*.cpp,*.java,*.rb,*.js,*.py,*.rs,*.go,\.vimrc execute "set nopaste"


""set guifont=CamingoCode:h14
"符号自动补全
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap " ""<esc>i

"开头的一些自动设置
autocmd BufNewFile *.c,*.cpp,*.java, execute "call SetAuthorInfo()"
function SetAuthorInfo()
			call append(line(".")-1, "/**" )
			call append(line(".")-1, "\<TAB>File Name: ".expand("%:t"))
			call append(line(".")-1, "\<TAB>Author: zhy")
			call append(line(".")-1, "\<TAB>Created Time: ".strftime("%Y/%m/%d - %H:%M:%S"))
			call append(line(".")-1, "*/")
endfunc
"c语言的一些设置
autocmd BufNewFile *.c execute "call FofC()"
function FofC()
		call append(line(".")-1, "#include <stdio.h>" )
		call append(line(".")-1, "int main(int argc, char *argv[])")
		call append(line(".")-1, "{")
		call append(line("."), "}")
		call append(line("."), "\<TAB>return 0;")
		execute "normal i\<TAB>\<ESC>"
endfunction
"c++的一些设置
autocmd BufNewFile *.cpp execute "call FofCpp()"
function FofCpp()
	call append(line(".")-1, "#include <iostream>" )
	call append(line(".")-1, "using namespace std;" )
	call append(line(".")-1, "int main(int argc, char *argv[])")
	call append(line(".")-1, "{")
	call append(line("."), "}")
	call append(line("."), "\<TAB>return 0;")
	execute "normal i\<TAB>\<ESC>"
endfunc
"java的一些设置
autocmd BufNewFile *.java execute "call FofJava()"
function FofJava()
		call append(line(".")-1, "public class ".expand("%:t:r")."{")
		call append(line(".")-1, "\<TAB>public static void main(String[] args) {")
		call append(line(".")-1, "")
		call append(line(".")-1, "\<TAB>}")
		call append(line(".")-1, "}")
		normal 8gg
endfunction

"go的一些设置
autocmd BufNewFile *.go execute "call FofGo()"
function FofGo()

endfunction
"===============================================
"缩进的对齐线条
autocmd BufNewFile * exe "call Addindentline()"
autocmd BufReadPost * exe "call Addindentline()"
func Addindentline()
	for type in ["c","java","c++","markdown", "javascript", "go"]
		if &filetype == type  
            set listchars=tab:\¦\ ,trail:•,extends:>,precedes:<,nbsp:.
		endif
	endfor
endfunc
"===============================================

"===============================================
"f5运行代码
autocmd BufNewFile * exe "call Runcode()"
autocmd BufReadPost * exe "call Runcode()"
func Runcode()
	if &filetype == 'ruby'
		map <F5> :!ruby %<CR>
	endif
	if &filetype == 'java'
		map <F5> :!javac -cp /Users/zhuyichen/.m2/repository/* %;java %:r <CR>
	endif
	if &filetype == 'python'
		map <F5> :!python %<CR>
	endif
	if &filetype == 'c'
		map <F5> :!gcc %;\./a.out <CR>
	endif
	if &filetype == 'cpp'
		map <F5> :!g++ %;\./a.out <CR>
	endif
	if &filetype == 'javascript'
		map <F5> :!node %<CR>
	endif
	if &filetype == 'rust'
		map <F5> :!rustc %; \./%:r %<CR>
	endif
	if &filetype == 'go'
		map <F5> :!go run %;<CR>
	endif
endfunc
"===============================================
"命令行自动补全时显示选项，
set showcmd
set wildmenu




filetype plugin on 

"设置tabline为打开状态
let g:airline#extensions#tabline#enabled = 1

"==========================================================================================
"自动补全
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"==========================================================================================

"==================================================================
"snippet
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"==================================================================


"================================================
"java_complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)
nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)
"================================================


" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

let g:rubycomplete_classes_in_global = 1

let g:SuperTabDefaultCompletionType = '<C-n>'


"================================================
"syntastic 的推荐配置，目前好像支持c++和python
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_rust_checkers = ['rustc']
"================================================


"================================================

"抄的林恩怜学长的
"花括号的补全，copy来的，很高级，
function CloseBracket()
	if getline('.')[col('.') - 1] == '}'
		return "\<Right>"
	elseif match(getline(line('.') + 1), '}') < 0
		return "}"
	else
		return "\<Esc>j0f}a"
	endif
endf
"自己写的，用来配合上面那个的花括号，
inoremap <CR> <c-r>=AoEiuV_CR()<CR>
function AoEiuV_CR()
	if getline('.')[col('.') - 1] == '}'
		return "\<CR>\<ESC>O"
	else
		return "\<CR>"
	endif
endf

"js补全
let g:vimjs#casesensistive = 1
" Enabled by default. flip the value to make completion matches case insensitive

let g:vimjs#smartcomplete = 1
" Disabled by default. Enabling this will let vim complete matches at any location
" e.g. typing 'ocument' will suggest 'document' if enabled.

let g:vimjs#chromeapis = 0
" Disabled by default. Toggling this will enable completion for a number of Chrome's JavaScript extension APIs


set list 
set listchars=tab:›\ ,trail:•,extends:>,precedes:<,nbsp:.


let g:vim_markdown_folding_disabled = 1
let g:rustfmt_autosave = 1



autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



"================================================
"所有的快捷键都放在这儿

let mapleader = "["
"自己改的一个映射
inoremap <leader>l <Esc>A
"设置切换Buffer快捷键"
noremap <C-b> :bn<CR>

noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :TagbarToggle<CR>
nnoremap <leader>k <C-w>h
nnoremap <leader>l <C-w>l
inoremap <leader>p <Esc>o

nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)
