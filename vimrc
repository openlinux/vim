syntax enable
syntax on
colorscheme desertEx
"colorscheme darkblue
set encoding=utf-8
"set encoding=zh_CN.utf8

set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
"set encoding=prc


set nocp
filetype plugin indent on
"set nu
"set completeopt=longest,menu
set completeopt=menuone,menu,longest ",preview

"let Tlist_Auto_Open =1
let Tlist_WinWidth =20
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"let Tlist_Use_Right_Window =1
nmap tl :Tlist<cr>

set tags =tags
"set autochdir

" Tags for linux-kernel.
set tags +=/home/bamboo/work/ok2440/Kernel/linux-2.6/tags
set tags +=/home/bamboo/work/hi3511/Kernel/linux-2.6.14/tags

" Tags for include files.
"set tags +=/usr/include/tags


" Tags for DVR
set tags +=/home/bamboo/work/ok2440/MyProgram/DVR/tags


" Tags for u-boot
set tags +=/home/bamboo/work/ok2440/BootLoader/u-boot/tags
"set tags +=/home/bamboo/work/hi3511/u-boot-1.1.4/tags

" Tags for the drv.
set tags +=/home/bamboo/work/Drv/drv-hi3511/tags

"let loaded_winmanager = 1
let g:persistentBehaviour = 0
let g:winManagerWidth = 10
let g:winManagerWindowLayout = "FileExplorer|TagList"
let g:defaultExplorer = 0
nmap wm :WMToggle<cr>
"nmap <c-w><c-b> :BottomExplorerWindow<cr>
"nmap <c-w><c-f> :FirstExplorerWindow<cr>


let g:miniBufExp1MapCTabSwitchBufs = 1
let g:miniBufExp1MapWindowNavVim = 1
let g:miniBufExp1MapWindowNavArrows = 1


"-- omnicppcomplete setting --
"set completeopt=menu,menuone
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and includedfiles
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype  in popup window
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_DisplayMode=1
"let OmniCpp_DefaultNamespaces=["std"]


"Here auto complete the ( { [ 
"inoremap ( ()<LEFT>
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
" "inoremap " ""<LEFT> 


"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
"autocmd FileType java set omnifunc=javacomplete#Complete


"let g:SuperTabRetainCompletionType = 2
"let g:SuperTabDefaultCompletionType = " <C-X><C-U>"

let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
	          \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

if has("mouse")
	set mouse=a
endif

if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	" add any database in current directory
	 if filereadable("cscope.out")
	 cs add cscope.out
 	endif
	 set csverb
	 set cscopetag
	 set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
endif
"keymap for cscope
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>


let g:acp_enableAtStartup = 0 
let g:neocomplcache_enable_at_startup = 0
let g:NeoComplCache_DisableAutoComplete = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_max_list=20
let g:neocomplcache_enable_ignore_case=1


"set ballooneval  nobeval
"set balloondelay=100
"set balloonexpr=BalloonDeclaration()
"set bdlay=100
"set beval   nobeval
"set bexpr=BalloonDeclaration()

"set for echofunc
let g:EchoFuncKeyNext='<Esc>+'
let g:EchoFuncKeyPrev='<Esc>-'
"let g:EchoFuncMaxBalloonDeclarations=6
"let g:EchoFuncShowOnStatus=1
let g:EchoFuncAutoStartBalloonDeclaration=1

"set laststatus=2
"set statusline=%F%m%r%h%w\%=[L:\%l\ C:\%c\ A:\%b\ H:\x%B\ P:\%p%%]
"set statusline=%{EchoFuncGetStatusLine()}

"map keys for taglists

nmap <S-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" map for lookup the defintion below the cursor.
"这里为lookup插件定义了几个快捷键  
nmap <F3> :cn<cr>
nmap <F4> :cp<cr>
nmap <F8> :cw<cr>



""""""""""""""""""""""""""""""
" lookupfile setting
" """"""""""""""""""""""""""""""
 let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
 let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
 let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
 let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
 let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
 if filereadable("./filename_tags")                "设置tag文件的名字
 let g:LookupFile_TagExpr = '"./filename_tags"'
 endif
" "映射LookupFile为,lk
 nmap  lk :LookupFile<cr>
 "映射LUBufs为,ll
 nmap  ll :LUBufs<cr>
 "映射LUWalk为,lw
 nmap  lw :LUWalk<cr>

"NERD_commenter.vim 注释插件。在光标行按ctrl + h 再按一次是
"取消，cm是多行注释

let NERDShutUp = 1


map fg : Dox<cr>
let g:DoxygenToolkit_authorName="Wu DaoGuang"
let g:DoxygenToolkit_licenseTag="GPL/GPL2\<enter>"
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@brief \t"
let g:DoxygenToolkit_paramTag_pre = "@param \t"
let g:DoxygenToolkit_returnTag = "@return \t"
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_maxFunctionProtoLines = 30
let g:DoxygenToolkit_blockHeader="--------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------"


map <F6> <Plug>ShowFunc
map!<F6> <Plug>ShowFunc

"let balloon_syntax = 1

let Grep_Default_Options = '-i'
let Grep_Default_Filelist = '*.c *.cpp *.asm, *.h *Makefile'
"nnoremap <silent> <F12> Rgrep<CR>
nnoremap <silent> <F7> :Rgrep<CR>

"打开vim运行 :GetLatestVimScripts

