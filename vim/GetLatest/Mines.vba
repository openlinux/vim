" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/MinesPlugin.vim	[[[1
75
" Mines.vim: emulates a minefield
"   Author:		Charles E. Campbell, Jr.
"   Date:		Dec 20, 2010
"   Version:	18e	ASTRO-ONLY
" Copyright:    Copyright (C) 1999-2010 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like much else that's free,
"               Mines.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
" GetLatestVimScripts: 551 1 :AutoInstall: Mines.vim
" GetLatestVimScripts: 1066 1 cecutil.vim
"
"  There is therefore now no condemnation to those who are in {{{1
"  Christ Jesus, who don't walk according to the flesh, but
"  according to the Spirit. (Rom 8:1 WEB)
"redraw!|call DechoSep()|call inputsave()|call input("Press <cr> to continue")|call inputrestore()
" ---------------------------------------------------------------------
"  Single Loading Only: {{{1
if &cp || exists("g:loaded_Mines")
 finish
endif
let s:keepcpo      = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Mining Variables: {{{1
if !exists("g:mines_timer")
 let g:mines_timer= 1
endif

" ---------------------------------------------------------------------
"  Public Interface: {{{1

if !hasmapto('<Plug>EasyMines')
 nmap <unique> <Leader>mfe	<Plug>EasyMines
endif
nmap <silent> <script> <Plug>EasyMines	:set lz<CR>:call Mines#EasyMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>MedMines')
 nmap <unique> <Leader>mfm	<Plug>MedMines
endif
nmap <silent> <script> <Plug>MedMines	:set lz<CR>:call Mines#MedMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>HardMines')
 nmap <unique> <Leader>mfh	<Plug>HardMines
endif
nmap <silent> <script> <Plug>HardMines	:set lz<CR>:call Mines#HardMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>RestoreMines')
 nmap <unique> <Leader>mfr  <Plug>RestoreMines
endif
nmap <silent> <script> <Plug>RestoreMines	:set lz<CR>:call Mines#DisplayMines(0)<CR>:set nolz<CR>

if !hasmapto('<Plug>ToggleMineTimer')
 nmap <unique> <Leader>mft  <Plug>ToggleMineTimer
endif
nmap <silent> <script> <Plug>ToggleMineTimer	:set lz<CR>:let g:mines_timer= !g:mines_timer<CR>:set nolz<CR>

if !hasmapto('<Plug>SaveStatistics')
 nmap <unique> <Leader>mfc  <Plug>SaveStatistics
endif
nmap <silent> <script> <Plug>SaveStatistics	:set lz<CR>:call Mines#SaveStatistics(0)<CR>:set nolz<CR>

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
autoload/Mines.vim	[[[1
1437
" Mines.vim: emulates a minefield
"   Author:		Charles E. Campbell, Jr.
"   Date:		Mar 08, 2011
"   Version:	18
" Copyright:    Copyright (C) 1999-2010 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like much else that's free,
"               Mines.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
" GetLatestVimScripts: 551 1 :AutoInstall: Mines.vim
" GetLatestVimScripts: 1066 1 cecutil.vim
"
"  There is therefore now no condemnation to those who are in {{{1
"  Christ Jesus, who don't walk according to the flesh, but
"  according to the Spirit. (Rom 8:1 WEB)
"redraw!|call DechoSep()|call inputsave()|call input("Press <cr> to continue")|call inputrestore()
" ---------------------------------------------------------------------
"  Single Loading Only: {{{1
if &cp || exists("g:loaded_Mines")
 finish
endif
let g:loaded_Mines = "v18"
let s:keepcpo      = &cpo
set cpo&vim
"DechoTabOn
"DechoToggle

" ---------------------------------------------------------------------
"  Mining Variables: {{{1
let s:displayname = "-Mines-"
let s:savesession = tempname()
let s:mines_timer   = g:mines_timer
let s:timestart     = 0
let s:timestop      = 0
let s:timesuspended = 0
let s:MFmines       = 0

" =====================================================================
" Functions: {{{1

" ---------------------------------------------------------------------
" Mines#EasyMines: {{{2
"    Requires an 12x12 grid be displayable with 15% mines
fun! Mines#EasyMines()
"  let g:decho_hide= 1  "Decho
"  call Dfunc("Mines#EasyMines()")
  if s:SanityCheck()
"  call Dret("Mines#EasyMines")
   return
  endif
  let s:field = "E"
  call RndmInit()
  call Mines#MineFieldSettings(10,10,15*10*10/100,120)
"  call Dret("Mines#EasyMines")
endfun

" ---------------------------------------------------------------------
" Mines#MedMines: {{{2
"    Requires a 20x20 grid be displayable with 15% mines
fun! Mines#MedMines()
"  let g:decho_hide= 1  "Decho
"  call Dfunc("Mines#MedMines()")
  if s:SanityCheck()
"  call Dret("MedMines")
   return
  endif
  let s:field = "M"
  call RndmInit()
  call Mines#MineFieldSettings(18,18,15*22*22/100,240)
"  call Dret("Mines#MedMines")
endfun

" ---------------------------------------------------------------------
" Mines#HardMines: {{{2{
"    Requies a 50x50 grid be displayable with 18% mines
fun! Mines#HardMines()
"  let g:decho_hide= 1  "Decho
"  call Dfunc("Mines#HardMines()")
  if s:SanityCheck()|return|endif
  let s:field = "H"
  call RndmInit()
  call Mines#MineFieldSettings(48,48,18*48*48/100,480)
"  call Dret("Mines#HardMines")
endfun

" ---------------------------------------------------------------------
"  SanityCheck: {{{2
fun! s:SanityCheck()
  if !exists("*RndmInit")
   rightb split
   enew
   setlocal bt=nofile
   put ='You need Rndm.vim!'
   put =' '
   put ='Rndm.vim is available at'
   put ='http://mysite.verizon.net/astronaut/vim/index.html#RNDM'
   let msg='  (Rndm is what generates pseudo-random variates)'
   put =msg
   return 1
  endif
  return 0
endfun

" ---------------------------------------------------------------------
" Mines#MineFieldSettings: {{{2
"   Can be used to generate a custom-sized display.
"   The grid will be rows x cols big, plus 2 rows and columns for
"   the outline.
"   The third argument specifies how many mines will be placed into
"   the grid.  Arbitrarily I've selected that at least 1/3 of the
"   grid must be clear at the very least.
fun! Mines#MineFieldSettings(rows,cols,mines,timelapse)
"  call Dfunc("Mines#MineFieldSettings(rows=".a:rows.",cols=".a:cols.",mines=".a:mines.",timelapse=".a:timelapse.")")
  let s:MFrows    = a:rows
  let s:MFcols    = a:cols
  let s:MFmines   = a:mines
  let s:MFmaxtime = a:timelapse
  if s:MFmines >= s:MFrows*s:MFcols*2/3
   echoerr "Too many mines selected"
  else
   if s:InitMines()
	setlocal nomod
"    call Dret("Mines#MineFieldSettings")
    return
   endif
  endif
  call s:MFSyntax()
  let s:timestart    = localtime()
  let s:timestop     = 0
  let s:timesuspended= 0
  let s:bombsflagged = 0
  let s:flagsused    = 0
  let s:marked       = 0
  let s:nobombs      = s:MFrows*s:MFcols- s:MFmines
  setlocal nomod
"  call Dret("Mines#MineFieldSettings : timestart=".s:timestart." nobombs=".s:nobombs)
endfun

" ---------------------------------------------------------------------
" InitMines: {{{2
fun! s:InitMines()
"  call Dfunc("InitMines(".s:MFrows."x".s:MFcols." mines=".s:MFmines.")")
  if filereadable("-Mines-")
   redraw!
   echohl WarningMsg | echo "the <-Mines-> file already exists!" | echohl None
   sleep 2
"   call Dret("InitMines")
   return 1
  endif

  setlocal nomod ma
  call Mines#DisplayMines(1)
  call s:ToggleMineTimer(g:mines_timer)

  let s:keep_list   = &list
  let s:keep_et     = &l:et
  let s:keep_gd     = &l:gd
  let s:keep_go     = &l:go
  let s:keep_fo     = &l:fo
  let s:keep_report = &l:report
  let s:keep_spell  = &l:spell
  let s:keep_sts    = 0
  setlocal nolist noet go-=aA fo-=a nogd report=10000 nospell sts=0

  " draw grid
"  call Decho("draw grid")
  let col= 1
  let line=":"
  while col <= s:MFcols
   let line= line . "	"
   let col = col + 1
  endwhile
  let line= line . ":"

  put =line
  keepj s/././g
  keepj norm! 1ggdd
  let row= 1
  while row <= s:MFrows
   put =line
   let row = row + 1
  endwhile
  put =line
  keepj s/././g
  set nomod

  " clear the minefield
"  call Decho("clear minefield")
  let col= 1
  while col <= s:MFcols
   let row= 1
   while row <= s:MFrows
	let s:MF_{row}_{col} = '0'
	let row              = row + 1
   endwhile
	let col = col + 1
  endwhile

  " set mines into minefield
"  call Decho("set mines into minefield")
  let mines= 0
  while mines < s:MFmines
   let row  = Urndm(1,s:MFrows)
   let col  = Urndm(1,s:MFcols)
   if s:MF_{row}_{col} == '0'
    let mines            = mines + 1
    let s:MF_{row}_{col} = '*'
   endif
  endwhile

  " analyze minefield
"  call Decho("analyze minefield: ".s:MFrows."x".s:MFcols)
  let row= 1
  while row <= s:MFrows
   let col= 1
   while col <= s:MFcols
    if " ".s:MF_{row}_{col} != ' *'
     let row1 = <SID>RowLimit(row-1)
     let rowN = <SID>RowLimit(row+1)
     let col1 = <SID>ColLimit(col-1)
     let colN = <SID>ColLimit(col+1)
     let cnt  = 0
     let irow = row1
     while irow <= rowN
      let icol= col1
      while icol <= colN
       if " ".s:MF_{irow}_{icol} == ' *'
        let cnt= cnt + 1
"		call Decho("  (".irow.",".icol.")")
       endif
       let icol= icol + 1
      endwhile
      let irow= irow + 1
     endwhile
     let s:MF_{row}_{col}= cnt
"     call Decho("s:MF_".row."_".col."= ((irow=[".row1.",".rowN."] icol=[".col1.",".colN."])) =".cnt)
    endif
	let col = col + 1
   endwhile
   let row = row + 1
  endwhile
  augroup MFTimerAutocmd
   au!
  augroup END

  if g:mines_timer
   augroup MFTimerAutocmd
    au CursorHold *		call s:TimeLapse()
	au BufLeave -Mines-	call s:MFBufLeave()
   augroup END
  endif
  let s:utkeep= &ut
  set ut=100
  augroup MFTimerAutocmd
   au ColorScheme -Mines- call s:MFSyntax()
  augroup END

  " title and author stuff
  1
  exe "keepj norm! jA           M I N E S"
  exe "keepj norm! jA    by Charles E. Campbell"

  nmap <buffer> 0		:exe 'keepj norm! 0l\n'<cr>
  nmap <buffer> $		:exe 'keepj norm! 0f:h\n'<cr>
  nmap <buffer> G		:exe 'keepj norm! Gk\n'<cr>
  nmap <buffer> g		:exe 'keepj norm! ggj\n'<cr>
  nmap <buffer> c		:call <SID>ChgCorner()<cr>
  set nomod

  " place cursor in upper left-hand corner of minefield
  keepj call cursor(2,2)

"  call Dret("InitMines")
  return 0
endfun

" ---------------------------------------------------------------------
" ChgCorner: {{{2
fun! s:ChgCorner()
"  call Dfunc("ChgCorner()")
  let row = line(".")
  let col = col(".")
  if row < s:MFrows/2
   if col < s:MFcols/2
   	keepj norm! Gk0l
   else
   	keepj norm! 1G0jl
   endif
  else
   if col < s:MFcols/2
   	keepj norm! Gk0f:h
   else
   	keepj norm! 1Gj0f:h
   endif
  endif
"  call Dret("ChgCorner")
endfun

" ---------------------------------------------------------------------
" ColLimit: {{{2
fun! s:ColLimit(col)
"  call Dfunc("ColLimit(col=".a:col.")")
  let col= a:col
  if col <= 0
   let col= 1
  endif
  if col > s:MFcols
   let col= s:MFcols
  endif
"  call Dret("ColLimit : col=".col)
  return col
endfun

" ---------------------------------------------------------------------
" RowLimit: {{{2
fun! s:RowLimit(row)
"  call Dfunc("RowLimit(row=".a:row.")")
  let row= a:row
  if row <= 0
   let row= 1
  endif
  if row > s:MFrows
   let row= s:MFrows
  endif
"  call Dret("RowLimit : row=".row)
  return row
endfun

" ---------------------------------------------------------------------
" DrawMinefield: {{{2
"     This function is responsible for drawing the minefield
"     as the leftmouse is clicked (or an "x" is pressed)
fun! s:DrawMinefield()
"  call Dfunc("DrawMinefield()")
  let col   = col(".")
  let row   = line(".")
  let colm1 = col - 1
  let rowm1 = row - 1
"  call Decho("DrawMinefield: ".row.",".col." <".s:MF_{rowm1}_{colm1}.">")

  "  sanity check: x atop a f should do nothing (must use f atop an f to clear it)
  keepj norm! vy
  if @@ == 'f'
   set nomod
"   call Dret("DrawMinefield")
   return
  endif

  " first test: insure that the mouseclick is inside the playing area
  if 1 <= rowm1 && rowm1 <= s:MFrows && 1 <= colm1 && colm1 <= s:MFcols
   if " ".s:MF_{rowm1}_{colm1} == ' *'
   	" mark the location where the bomb went off
   	let s:MF_{rowm1}_{colm1}= 'X'
    call s:Boom()
   else
    call s:ShowAt(rowm1,colm1)
   endif
  endif
  " check if all the bombs have been flagged???
  if s:MFmines == s:flagsused && s:MFmines == s:bombsflagged && s:marked == s:nobombs
   call s:MF_Happy()
  endif

  if s:mines_timer
   call s:TimeLapse()
  endif
  set nomod
"  call Dret("DrawMinefield")
endfun

" ---------------------------------------------------------------------
" DrawMineflag: {{{2
"    This function is responsible for drawing the minefield
"    flags as the rightmouse is clicked
fun! s:DrawMineflag()
"  call Dfunc("DrawMineflag()")

  " prevents some errors when trying to modify a completed minefield
  if &ma == 0
   set nomod
"   call Dret("Boom")
   return
  endif

  let scol   = col(".")
  let srow   = line(".")
  let fcol = scol - 1
  let frow = srow - 1
  if s:mines_timer
   call s:TimeLapse()
  endif
"  call Decho("scol=".scol." srow=".srow." fcol=".fcol." frow=".frow)

  " sanity check
  if fcol <= 0 || s:MFcols < fcol
   call s:FlagCounter()
   let &ve= vekeep
   set nomod
"   call Dret("DrawMineflag : failed sanity check (fcol=".fcol." s:MFcols=".s:MFcols.")")
   return
  endif

  " sanity check
  if frow <= 0 || s:MFrows < frow
   call s:FlagCounter()
   set nomod
"   call Dret("DrawMineflag : failed sanity check (frow=".frow." s:MFrows=".s:MFrows.")")
   return
  endif

  " flip flagged square to unmarked
  keepj norm! vy
"  call Decho("flip flagged square to unmarked: @@<".@@.">")
  if @@ == 'f'
   exe "keepj norm! r\<tab>"
   let s:flagsused= s:flagsused - 1
"   call Decho("s:flagsused=".s:flagsused." (was ".(s:flagsused+1).")")
"   call Decho("s:MF_".frow."_".fcol."=".s:MF_{frow}_{fcol})
   if ' '.s:MF_{frow}_{fcol} == ' *'
	let s:bombsflagged= s:bombsflagged - 1
"	call Decho("s:bombsflagged=".s:bombsflagged." (was ".(s:bombsflagged+1).")")
   endif
   call s:FlagCounter()
   set nomod
"   call Dret("DrawMineflag")
   return
  endif
  if @@ =~ '\d' || @@ == ' '
   " don't change numbered entries or no-bomb areas
   call s:FlagCounter()
   set nomod
"   call Dret("DrawMineflag : don't change numbered entries or no-bomb areas")
   return
  endif

"  call Decho("DrawMineflag: ".frow.",".fcol." <".s:MF_{frow}_{fcol}.">")
  if 1 <= frow && frow <= s:MFrows && 1 <= fcol && fcol <= s:MFcols
   if " ".s:MF_{frow}_{fcol} == ' *'
    let s:flagsused    = s:flagsused    + 1
    let s:bombsflagged = s:bombsflagged + 1
   else
    let s:flagsused= s:flagsused + 1
   endif
   norm! rf
  endif

  " check if all the bombs have been flagged???
"  call Decho("DrawMineflag: flagsused=".s:flagsused." bombsflagged=".s:bombsflagged." marked=".s:marked)
  if s:MFmines == s:flagsused && s:MFmines == s:bombsflagged && s:marked == s:nobombs
   call s:MF_Happy()
  else
   call s:FlagCounter()
  endif
  set nomod
"  call Dret("DrawMineflag")
endfun

" ---------------------------------------------------------------------
" TimeLapse: {{{2
fun! s:TimeLapse()
  if expand("%") != '-Mines-'
   return
  endif
"  call Dfunc("TimeLapse()")

  let timeused = localtime() - s:timestart - s:timesuspended
  let curline  = line(".")
  let curcol   = col(".")

  if exists("s:mines_timer")
   if timeused > s:MFmaxtime
    call s:Boom()

   elseif g:mines_timer
	let tms= localtime() - s:timestart
	keepj 8
    keepj s/  Time.*$//e
	exe "keepj norm! A  Time used=".timeused.'sec'
	keepj 9
    keepj s/  Time.*$//e
	let timeleft= s:MFmaxtime - timeused
	exe "keepj norm! A  Time left=".timeleft
"    call Decho("tms=".tms." timeused=".timeused." timeleft=".timeleft)
   endif
  endif

  exe "keepj norm! ".curline."G".curcol."\<bar>"
  set nomod
"  call Dret("TimeLapse")
endfun

" ---------------------------------------------------------------------
" s:MFBufLeave: {{{2
fun! s:MFBufLeave()
"  call Dfunc("s:MFBufLeave()")

  if s:mines_timer
   augroup MFTimerAutocmd
	au!
	au BufEnter -Mines- call s:MFBufEnter()
   augroup END
  endif

"  call Dret("s:MFBufLeave")
endfun

" ---------------------------------------------------------------------
" s:MFBufEnter: {{{2
fun! s:MFBufEnter()
"  call Dfunc("s:MFBufEnter()")

  if s:mines_timer
   augroup MFTimerAutocmd
    au!
    au CursorHold *		call s:TimeLapse()
	au BufLeave -Mines-	call s:MFBufLeave()
   augroup END
  endif

"  call Dret("s:MFBufEnter")
endfun

" ---------------------------------------------------------------------
" ToggleMineTimer: {{{2
"    Toggles timing use
"      0: turn off
"      1: turn on
"      2: toggle
fun! s:ToggleMineTimer(mode)
"  call Dfunc("ToggleMineTimer(mode=".a:mode.")")

  if a:mode == 0
   let s:mines_timer= 0
  elseif a:mode == 1
   let s:mines_timer= 1
  else
   let s:mines_timer= !s:mines_timer
  endif

  " clear off time information
  silent! keepj 8,9s/  Time.*$//e

  if s:mines_timer
   " turn timing on
   augroup MFTimerAutocmd
    au!
    au CursorHold *		call s:TimeLapse()
	au BufLeave -Mines-	call s:MFBufLeave()
   augroup END

  else
   " turn timing off
   augroup MFTimerAutocmd
    au!
   augroup END
   augroup! MFTimerAutocmd
  endif

"  call Dret("ToggleMineTimer")
endfun

" ---------------------------------------------------------------------
" Boom: {{{2
fun! s:Boom()
"  call Dfunc("Boom()")

  " delete the -Mines- file if it exists
  if filereadable("-Mines-")
   call delete("-Mines-")
  endif

  " prevents some errors when trying to modify a completed minefield
  if &ma == 0
"  call Dret("Boom")
   return
  endif

  " set virtualedit
  let vekeep= &ve
  set ve=all

  " clean off right-hand side of minefield
  %s/^:.\{-}:\zs.*$//e

  let curline= line(".")
  let curcol = col(".")
  echohl Error
  echomsg "Boom!"
  echohl None
"  call Decho("Boom!")

  call s:ToggleMineTimer(0)

  if s:field == "E"
   keepj 3
  elseif s:field == "M"
   keepj 7
  elseif s:field == "H"
   keepj 10
  endif
  let s:timelapse= localtime() - s:timestart - s:timesuspended
  exe "keepj norm! A  BOOM!"
  exe "keepj norm! jA  Time  Used   : ".s:timelapse."sec"
  exe "keepj norm! jA  Bombs Flagged: ".s:bombsflagged
  exe "keepj norm! jA  Bombs Present: ".s:MFmines
  exe "keepj norm! jA  Flags Used   : ".s:flagsused
  let s:timestart    = 0
  let s:timestop     = 0
  let s:timesuspended= 0
  if exists("s:utkeep")
   let &ut= s:utkeep
  endif
  call s:Winners(0)
  keepj 11
  let row= 1
  norm! gg0jl

  " show true minefield
  while row <= s:MFrows
   let col = 1
   let line= ""
   while col <= s:MFcols

   	" show mistakes with Boomfield# syntax highlighting COMBAK
	let rcchar= getline(row+1)[col]
"	call Decho("MF[".row."][".col."]<".s:MF_{row}_{col}."> getline(".(row+1).")[".col."]<".rcchar.">")
	if rcchar != '\t' && rcchar == 'f' && s:MF_{row}_{col} > 0
	 exe 'syn match Boomfield'.s:MF_{row}_{col}." '\\%".(row+1)."l\\%".(col+1)."c.'"
"	 call Decho('exe syn match Boomfield'.s:MF_{row}_{col}." '\\%".(row+1)."l\\%".(col+1)."c.'")
	endif

	if " ".s:MF_{row}_{col} == " z" || " ".s:MF_{row}_{col} == ' 0'
	 let line= line.' '
	else
	 let line= line.s:MF_{row}_{col}
	endif
	let col = col + 1
   endwhile
"   call Decho("Boom: row=".row." line<".line.">")
   exe 'keepj norm! R'.line
   let row = row + 1
   keepj norm! j0l
  endwhile

  keepj norm! gg0
  exe "keepj norm! ".curline."G".curcol."\<bar>"
  call RndmSave()
  setlocal nolz nomod noma

  " restore virtualedit
  let &ve= vekeep

"  call Dret("Boom")
endfun

" ---------------------------------------------------------------------
" MFSyntax: {{{2
"   Set up syntax highlighting for minefield
fun! s:MFSyntax()
"  call Dfunc("MFSyntax()")

  syn clear
  syn match MinefieldRim	"[.:]"
  syn match MinefieldFlag	"f"
  syn match Minefield0		"[-LR]"
  syn match Minefield1		"1"
  syn match Minefield2		"2"
  syn match Minefield3		"3"
  syn match Minefield4		"4"
  syn match Minefield5		"5"
  syn match Minefield6		"6"
  syn match Minefield7		"7"
  syn match Minefield8		"8"
  syn match MinefieldTab	"	"
  syn match MinefieldSpace	" "
  syn match MinefieldBomb	'[*X]'
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeTime"		end="$"
  syn region MinefieldTime    start="\s\+\zeTime Used"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeBombs"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeFlags"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zeBOOM"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zetotal"		end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zestreak"	end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zelongest"	end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zecurrent"	end="$"
  syn region MinefieldText    matchgroup=MinefieldBg start="\s\+\zebest"		end="$"
  syn region MinefieldMinnie  matchgroup=MinefieldBg start="\s\+\ze[-,/\\)o|]"	end="$" contains=MinefieldWinner keepend
  syn region MinefieldWinner  matchgroup=MinefieldBg start="\s\+\ze\(YOU\|WON\|!!!\)" end="$" keepend
  syn region MinefieldTitle	  matchgroup=MinefieldBg start="\s\+\zeM I N E S\>"	end="$"
  syn region MinefieldTitle	  matchgroup=MinefieldBg start="\s\+\zeby Charles"	end="$"
  syn region MinefieldFlagCnt matchgroup=MinefieldBg start="\s\+\zeFlags Used: " end="$"
  if &bg == "dark"
   hi Minefield0		 ctermfg=black   guifg=black    ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield1		 ctermfg=green   guifg=green    ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield2		 ctermfg=yellow  guifg=yellow   ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield3		 ctermfg=red     guifg=red      ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield4		 ctermfg=cyan    guifg=cyan     ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi Minefield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Minefield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Minefield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Minefield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield0		 ctermfg=black   guifg=black    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield1		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield2		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield3		 ctermfg=red     guifg=red      ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield4		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi Boomfield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi MinefieldTab		 ctermfg=blue    guifg=blue     ctermbg=blue    guibg=blue     term=NONE cterm=NONE gui=NONE
   hi MinefieldRim		 ctermfg=white   guifg=white    ctermbg=white   guibg=white    term=NONE cterm=NONE gui=NONE
   hi MinefieldFlag		 ctermfg=white   guifg=white    ctermbg=magenta guibg=magenta  term=NONE cterm=NONE gui=NONE
   hi MinefieldText		 ctermfg=white   guifg=white    ctermbg=magenta guibg=magenta  term=NONE cterm=NONE gui=NONE
   hi MinefieldSpace	 ctermfg=black   guifg=black    ctermbg=black   guibg=black    term=NONE cterm=NONE gui=NONE
   hi MinefieldMinnie	 ctermfg=white   guifg=white                                   term=NONE cterm=NONE gui=NONE
   hi MinefieldBomb		 ctermfg=white   guifg=white    ctermbg=red     guibg=red      term=NONE cterm=NONE gui=NONE
   hi link MinefieldWinner MinefieldText
  else
   hi Minefield0		 ctermfg=black   guifg=black    ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield1		 ctermfg=green   guifg=green    ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield2		 ctermfg=yellow  guifg=yellow   ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield3		 ctermfg=red     guifg=red      ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield4		 ctermfg=cyan    guifg=cyan     ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi Minefield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Minefield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Minefield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Minefield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield0		 ctermfg=black   guifg=black    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield1		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield2		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield3		 ctermfg=red     guifg=red      ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield4		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield5		 ctermfg=green   guifg=green    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield6		 ctermfg=yellow  guifg=yellow   ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield7		 ctermfg=red     guifg=red	    ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi Boomfield8		 ctermfg=cyan    guifg=cyan     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi MinefieldTab		 ctermfg=blue    guifg=blue     ctermbg=blue    guibg=blue      term=NONE cterm=NONE gui=NONE
   hi MinefieldRim		 ctermfg=magenta guifg=magenta  ctermbg=magenta guibg=magenta   term=NONE cterm=NONE gui=NONE
   hi MinefieldFlag		 ctermfg=white   guifg=white    ctermbg=magenta guibg=magenta   term=NONE cterm=NONE gui=NONE
   hi MinefieldText		 ctermfg=black   guifg=black    ctermbg=cyan    guibg=cyan      term=NONE cterm=NONE gui=NONE
   hi MinefieldSpace	 ctermfg=black   guifg=black    ctermbg=black   guibg=black     term=NONE cterm=NONE gui=NONE
   hi MinefieldMinnie	 ctermfg=black   guifg=black                                    term=NONE cterm=NONE gui=NONE
   hi MinefieldBomb		 ctermfg=white   guifg=white    ctermbg=red     guibg=red       term=NONE cterm=NONE gui=NONE
   hi Cursor			 ctermfg=blue guifg=blue ctermbg=white guibg=white              term=NONE cterm=NONE gui=NONE
   hi link MinefieldWinner MinefieldText
  endif
  hi link MinefieldTitle  PreProc

"  call Dret("MFSyntax")
endfun

" ---------------------------------------------------------------------
" Mines#DisplayMines: {{{2
"    Displays a Minefield and sets up Minefield mappings
fun! Mines#DisplayMines(init)
"  "  call Dfunc("Mines#DisplayMines(init=".a:init.")")

  " Settings
  set ts=1    " set tabstop to 1
  set mouse=n " initialize mouse

  if bufname("%") == s:displayname
   " already have a minefield display, and its showing
   if a:init == 1
    silent! keepj %d
"    call Decho("cleared screen")
   endif
"   call Dret("Mines#DisplayMines")
   return
  endif

  " error message: attempt to restore a game that no longer exists
  if a:init == 0 && !exists("s:minebufnum")
   echomsg "***sorry*** I'm unable to restore your game (s suspends, q quits)"
"   call Dret("Mines#DisplayMines : unable to restore")
   return
  endif

  " save current working session
  call SaveSession(s:savesession)

  " clear screen
  silent! keepj %d
"    call Decho("cleared screen")
  set nomod

  if !exists("s:minebufnum")
   " need to create a new buffer with s:displayname
   exe "e ".s:displayname
   let s:minebufnum    = bufnr("%")
   let s:timestart     = localtime()
   let s:timesuspended = 0
   let s:timestop      = 0
  else
   " minefield buffer is merely hidden, restore it to view
   exe "b ".s:minebufnum
   let srows=s:MFrows+2
   exe "silent! keepj norm! ".srows."\<c-y>"
   let s:timesuspended= s:timesuspended + localtime() - s:timestop
  endif
  silent only!
  set nomod

  " set up interface
  call s:MFSyntax()
  nnoremap <silent> <leftmouse>  <leftmouse>:<c-u>call <SID>DrawMinefield()<CR>
  nnoremap <silent> <rightmouse> <leftmouse>:<c-u>call <SID>DrawMineflag()<CR>
  nmap <silent> x :silent call <SID>DrawMinefield()<CR>
  nmap <silent> q :silent call <SID>StopMines(0)<CR>
  nmap <silent> s :silent call <SID>StopMines(1)<CR>
  nmap <silent> f :silent call <SID>DrawMineflag()<CR>
  nmap <silent> C :set lz<CR>:call Mines#SaveStatistics(0)<CR>:set nolz<CR>
  nmap <silent> E :set lz<CR>:call Mines#EasyMines()<CR>:set nolz<CR>
  nmap <silent> M :set lz<CR>:call Mines#MedMines()<CR>:set nolz<CR>
  nmap <silent> H :set lz<CR>:call Mines#HardMines()<CR>:set nolz<CR>

  call s:ToggleMineTimer(g:mines_timer)
"  call Dret("Mines#DisplayMines")
endfun

" ---------------------------------------------------------------------
" StopMines: {{{2
"         Stops the Mines game; it can either truly quit
"            Mines or merely temporarily suspend Mines.
"            The screen is restored to its pre-Mines condition
"         StopMines(0) -- really quits Mines
"         StopMines(1) -- suspends Mines
fun! s:StopMines(suspend)
"  call Dfunc("StopMines(suspend=".a:suspend.")")

  call s:ToggleMineTimer(0)
  if a:suspend == 0
   " quit Mines
"   call Decho("quitting Mines")

   " restore display based on savesession
"   call Decho("restoring display based on savesession<".s:savesession.">")
   try
    exe "source ".s:savesession
   catch /^Vim\%((\a\+)\)\=:E/
"   	call Decho("intercepted error ".v:errmsg)
   endtry
   call delete(s:savesession)

   set nohidden
   if exists("s:minebufnum") && bufname(s:minebufnum) != ""
"   	call Decho("buffer-wiping ".s:minebufnum)
    exe "bw! ".s:minebufnum
    unlet s:minebufnum
   endif

"   call Decho("restoring options")
   let &l:et       = s:keep_et
   let &l:fo       = s:keep_fo
   let &l:gdefault = s:keep_gdefault
   let &l:gd       = s:keep_gd
   let &l:go       = s:keep_go
   let &l:hidden   = s:keep_hidden
   let &l:list     = s:keep_list
   let &l:mouse    = s:keep_mouse
   let &l:report   = s:keep_report
   let &l:spell    = s:keep_spell
   let &l:sts      = s:keep_sts
   let &l:swf      = s:keep_swf
   let s:swfkeep   = &swf

  else
   " suspend  Mines
"   call Decho("suspending Mines")
   exe "b ".s:keep_bufnum
   " restore display based on savesession
   exe "silent! source ".s:savesession
  endif

  " restore any pre-existing to <Mines.vim> maps
  if !exists("b:netrw_curdir")
   let b:netrw_curdir= getcwd()
  endif
  call RestoreUserMaps("Mines")
  let s:timestop= localtime()

"  call Dret("StopMines")
endfun

" ---------------------------------------------------------------------
" SaveSession: {{{2
"    Save session into given savefile
fun! SaveSession(savefile)
"  call Dfunc("SaveSession(savefile<".a:savefile.">)")
  silent! windo w

  " Save any pre-existing maps that conflict with <Mines.vim>'s maps
  " (uses call RestoreUserMaps("Mines") to restore user maps in s:StopMines() )
  call SaveUserMaps("n","","emhxqsf","Mines")
  call SaveUserMaps("n","","<leftmouse>","Mines")
  call SaveUserMaps("n","","<rightmouse>","Mines")

  " save user settings
  let keep_ssop       = &l:ssop
  let s:keep_hidden   = &l:hidden
  let s:keep_mouse    = &l:mouse
  let s:keep_bufnum   = bufnr("%")
  let s:keep_gdefault = &l:gdefault
  let s:keep_swf      = &l:swf
  let &ssop           = 'winpos,buffers,slash,globals,resize,blank,folds,help,options,winsize'
  setlocal hidden nogd noswf

  " make a session file and save it in the a:savefile (a temporary file)
  exe 'silent! mksession! '.a:savefile
  let &ssop            = keep_ssop

"  call Dret("SaveSession")
endfun

" ---------------------------------------------------------------------
" ShowAt: {{{2
"    This function displays the Minefield at the given row,column
fun! s:ShowAt(row,col)
"  call Dfunc("ShowAt(".a:row.",".a:col."): MF=".s:MF_{a:row}_{a:col})

  if " ".s:MF_{a:row}_{a:col} == ' 0'
   call s:MF_Flood(a:row,a:col)
   call s:MF_Posn(a:row,a:col)
  else
   keepj norm! vy
   if @@ == "\t"
    call s:CheckIfFlagged()
    exe "keepj norm! r".s:MF_{a:row}_{a:col}
   endif
  endif

"  call Dret("ShowAt")
endfun

" ---------------------------------------------------------------------
" CheckIfFlagged: {{{2
"    When marking a square, this function keeps track of
"    how many squares are flagged and how many are marked
fun! s:CheckIfFlagged()
"  call Dfunc("CheckIfFlagged()")

  keepj norm! vy
  if @@ == 'f'
   let s:marked   = s:marked    + 1
   let s:flagsused= s:flagsused - 1
  elseif @@ == "\t"
   let s:marked   = s:marked    + 1
  endif

"  call Dret("CheckIfFlagged : marked=".s:marked." flagged=".s:flagsused)
endfun

" ---------------------------------------------------------------------
" FlagCounter: show count of flags{{{2
fun! s:FlagCounter()
"  call Dfunc("FlagCounter()")
  let vekeep= &ve
  setlocal ve=all

  let curpos    = getpos(".")
  keepj call cursor(5,s:MFcols + 3)
  exe "keepj norm! DA".(printf("    Flags Used: %d",s:flagsused))
  keepj call cursor(6,s:MFcols + 3)
  let s:timelapse= localtime() - s:timestart - s:timesuspended
  exe "keepj norm! DA    Time Used : ".s:timelapse."sec"
  keepj call setpos(".",curpos)
  set nomod

  let &ve= vekeep
"  call Dret("FlagCounter")
endfun

" ---------------------------------------------------------------------
" MF_Flood: {{{2
"    Fills in 0-minefield count area
"      frow,fcol: mine-f-ield row and column
"      col1,col2: index into minefield array from 0..0 (ie. not [1-8])
fun! s:MF_Flood(frow,fcol)
"  call Dfunc("MF_Flood(frow=".a:frow.",fcol=".a:fcol.")")

"  redr!
  if s:MF_Posn(a:frow,a:fcol)
"   call Dret("MF_Flood")
   return
  endif
  setlocal ma
  let colL= s:MF_FillLeft(a:frow,a:fcol)
  let colR= s:MF_FillRight(a:frow,a:fcol+1)
  let colL= (colL > 1)?        colL-1 : 1
  let colR= (colR < s:MFcols)? colR+1 : s:MFcols
  if a:frow > 1
   call s:MF_FillRun(a:frow-1,colL,colR)
  endif
  if a:frow < s:MFrows
   call s:MF_FillRun(a:frow+1,colL,colR)
  endif
"  call Dret("MF_Flood")
endfun

" ---------------------------------------------------------------------
"  MF_FillLeft: {{{2
fun! s:MF_FillLeft(frow,fcol)
"  call Dfunc("MF_FillLeft(frow=".a:frow.",fcol=".a:fcol.")")

  if s:MF_Posn(a:frow,a:fcol)
"   call Dret("MF_FillLeft : fcol=".a:fcol)
   return a:fcol
  endif

  setlocal ma
  let Lcol= a:fcol
  while Lcol >= 1
   if " ".s:MF_{a:frow}_{Lcol} == " 0"
	call s:CheckIfFlagged()
    exe "keepj norm! r h"
    let s:MF_{a:frow}_{Lcol}= 'z'
   elseif " ".s:MF_{a:frow}_{Lcol} != " z"
	call s:CheckIfFlagged()
    exe "keepj norm! r".s:MF_{a:frow}_{Lcol}
"	call Decho("end-of-run left: Lcol=".Lcol."<".s:MF_{a:frow}_{Lcol}.">")
    break
   else
	keepj norm! h
   endif
   let Lcol= Lcol - 1
  endwhile

  let Lcol= (Lcol < 1)? 1 : Lcol + 1

"  redr!	"Decho
"  call Dret("MF_FillLeft : Lcol=".Lcol)
"  let response= confirm("filled left row ".a:frow)	"Decho
  return Lcol
endfun

" ---------------------------------------------------------------------
"  MF_FillRight: {{{2
fun! s:MF_FillRight(frow,fcol)
"  call Dfunc("MF_FillRight(frow=".a:frow.",fcol=".a:fcol.")")

  if s:MF_Posn(a:frow,a:fcol)
"   call Dret("MF_FillRight : fcol=".a:fcol)
   return a:fcol
  endif

  setlocal ma
  let Rcol= a:fcol
  while Rcol <= s:MFcols
   if " ".s:MF_{a:frow}_{Rcol} == " 0"
	call s:CheckIfFlagged()
    exe "keepj norm! r l"
	let s:MF_{a:frow}_{Rcol}= 'z'
   elseif " ".s:MF_{a:frow}_{Rcol} != " z"
	call s:CheckIfFlagged()
    exe "keepj norm! r".s:MF_{a:frow}_{Rcol}
"	call Decho("end-of-run right: Rcol=".Rcol."<".s:MF_{a:frow}_{Rcol}.">")
    break
   else
    keepj norm! l
   endif
   let Rcol= Rcol + 1
  endwhile

  let Rcol= (Rcol > s:MFcols)? s:MFcols : Rcol - 1

"  redr!	"Decho
"  call Dret("MF_FillRight : Rcol=".Rcol)
"  let response= confirm("filled right row ".a:frow)	"Decho
  return Rcol
endfun

" ---------------------------------------------------------------------
"  MF_FillRun: {{{2
fun! s:MF_FillRun(frow,fcolL,fcolR)
"  call Dfunc("MF_FillRun(frow=".a:frow.",fcol[".a:fcolL.",".a:fcolR."])")

  if s:MF_Posn(a:frow,a:fcolL)
"   call Dret("MF_FillRun : bad posn (row ".a:frow.")")
   return
  endif

  " Flood
  call s:MF_Posn(a:frow,a:fcolL)
"  call Decho("flood row=".a:frow." col[".a:fcolL.",".a:fcolR."]")
  let icol= a:fcolL
  while icol <= a:fcolR
   if " ".s:MF_{a:frow}_{icol} == " 0"
	call s:CheckIfFlagged()
	exe "keepj norm! r l"
	let s:MF_{a:frow}_{icol}= 'z'
	call s:MF_Flood(a:frow,icol)
    call s:MF_Posn(a:frow,icol+1)
   elseif " ".s:MF_{a:frow}_{icol} != " z"
	call s:CheckIfFlagged()
	exe "keepj norm! r".s:MF_{a:frow}_{icol}."l"
   else
	keepj norm! l
   endif
   let icol= icol + 1
  endwhile

"  redr!	"Decho
"  call Dret("MF_FillRun : row=".a:frow)
"  let response= confirm("flooded row ".a:frow)  "Decho
endfun

" ---------------------------------------------------------------------
" MF_Posn: {{{2
"    Put cursor into given position on screen
"       srow,scol: -s-creen    row and column
"      Returns  1 : failed sanity check
"               0 : otherwise
fun! s:MF_Posn(frow,fcol)
"  call Dfunc("MF_Posn(frow=".a:frow.",fcol=".a:fcol.")")

  " sanity checks
  if a:frow < 1 || s:MFrows < a:frow
"   call Dret("MF_Posn 1")
   return 1
  endif
  if a:fcol < 1 || s:MFcols < a:fcol
"   call Dret("MF_Posn 1")
   return 1
  endif
  let srow= a:frow + 1
  let scol= a:fcol + 1
  exe "keepj norm! ".srow."G".scol."\<Bar>"

"  call Dret("MF_Posn 0")
  return 0
endfun

" ---------------------------------------------------------------------
" MF_Happy: Minnie does a cartwheel when you win {{{2
fun! s:MF_Happy()
"  call Dfunc("MF_Happy()")

  " delete the -Mines- file if it exists
  if filereadable("-Mines-")
   call delete("-Mines-")
  endif

  " prevents some errors when trying to modify a completed minefield
  if &ma == 0
"  call Dret("Boom")
   return
  endif

  " clean off right-hand side of minefield
  %s/^:.\{-}:\zs.*$//e

  if s:timestart == 0
   " already gave a Happy!
"   call Dret("MF_Happy")
   return
  endif

  " set virtualedit
  let vekeep= &ve
  set ve=all

  call s:ToggleMineTimer(0)
  let s:timelapse = localtime() - s:timestart
  let keep_ch   = &ch
  set ch=5
  set lz
  exe "silent! keepj norm! z-"

  keepj 2
  exe "keepj norm! A   o"
  exe "keepj norm! jA  ,\<bar>`"
  exe "keepj norm! jA  /\\"
  sleep 250m
  redr

  keepj 2
  exe "keepj norm! 0f:lDA      o"
  exe "keepj norm! 0jf:lDA     /\\"
  exe "keepj norm! 0jf:lDA    /\\"
  sleep 250m
  redr

  keepj 2
  exe "keepj norm! 0f:lDA     \\   "
  exe "keepj norm! 0jf:lDA      --o"
  exe "keepj norm! 0jf:lDA     / \\"
  sleep 250m
  redr

  keepj 2
  exe "keepj norm! 0f:lDA        \\ /"
  exe "keepj norm! 0jf:lDA         \<bar>"
  exe "keepj norm! 0jf:lDA         o"
  exe "keepj norm! jA        / \\"
  sleep 250m
  redr

  keepj 2
  exe "keepj norm! 0f:lDA         \\ /"
  exe "keepj norm! 0jf:lDA          /"
  exe "keepj norm! 0jf:lDA         o"
  exe "keepj norm! 0jf:lDA        / \\"
  sleep 250m
  redr

  keepj 2
  exe "keepj norm! 0f:lDA            /"
  exe "keepj norm! j0f:lDA         o-- "
  exe "keepj norm! j0f:lDA        / \\ \\"
  exe "keepj norm! j0f:lD"
  sleep 250m
  redr

  keepj 2
  exe "keepj norm! 0f:lDA             \\o/   YOU"
  exe "keepj norm! j0f:lDA              )    WON"
  exe "keepj norm! j0f:lDA             /\\    !!!"
  redr

  " clear off "Flags Used: ..." field
  keepj call cursor(5,13)
  keepj norm! Dk$
  redr

  exe "keepj norm! jjA  Time  Used   : ".s:timelapse."sec"
  exe "keepj norm! jA  Bombs Flagged: ".s:MFmines

  let s:timestart= 0
  let &ch        = keep_ch
  if exists("s:utkeep")
   let &ut= s:utkeep
  endif
  call s:Winners(1)
  call RndmSave()
  setlocal nolz nomod noma

  " restore virtualedit
  let &ve= vekeep

"  call Dret("MF_Happy")
endfun

" ---------------------------------------------------------------------
" Winners: checks top winners in the $HOME directory {{{2
fun! s:Winners(winner)
"  call Dfunc("Winners(winner=".a:winner.")")

  if $HOME == ""
"   call Dret("Winners : no home directory")
   return
  endif

  " sanity preservation
  call s:StatSanity("E")
  call s:StatSanity("M")
  call s:StatSanity("H")

  " initialize statistics
  if filereadable($HOME."/.vimMines")
   exe "so ".$HOME."/.vimMines"
  else
   call Mines#SaveStatistics(0)
  endif

  call s:UpdateStatistics(a:winner)
  call Mines#SaveStatistics(1)

  " report on statistics
  norm! j
  if g:mines_losecnt{s:field} > 0
   let totgames = g:mines_wincnt{s:field} + g:mines_losecnt{s:field}
   let percent  = (100000*g:mines_wincnt{s:field})/totgames
   let int      = percent/1000
   let frac     = percent%1000
   exe  "keepj norm! j$lA  totals         : [".g:mines_wincnt{s:field}." wins]/[".totgames." games]=".int.'.'.printf("%03d",frac)."%"
  else
   exe  "keepj norm! j$lA  totals         : ".g:mines_wincnt{s:field}." wins, ".g:mines_losecnt{s:field}." losses"
  endif
  if g:mines_curwinstreak{s:field} > 0
   exe "keepj norm! j$lA  current streak : ".g:mines_curwinstreak{s:field}." wins"
  else
   exe "keepj norm! j$lA  current streak : ".g:mines_curlosestreak{s:field}." losses"
  endif
  exe "keepj norm! j$lA  longest streaks: ".g:mines_winstreak{s:field}." wins, ".g:mines_losestreak{s:field}." losses"

  if s:field == "E"
   if g:mines_timeE > 0
    exe "keepj norm! j$lA  best time=".g:mines_timeE."sec (easy)"
   endif
  endif
  if s:field == "M"
   if g:mines_timeM > 0
    exe "keepj norm! j$lA  best time=".g:mines_timeM."sec (medium)"
   endif
  endif
  if s:field == "H"
   if g:mines_timeH > 0
    exe "keepj norm! j$lA  best time=".g:mines_timeH."sec (hard)"
   endif
  endif

"  call Dret("Winners")
endfun

" ---------------------------------------------------------------------
" UpdateStatistics: {{{2
fun! s:UpdateStatistics(winner)
"  call Dfunc("UpdateStatistics(winner<".a:winner.">) s:field<".s:field.">")

  " update statistics
  let g:mines_wincnt{s:field}  = g:mines_wincnt{s:field}  +  a:winner
  let g:mines_losecnt{s:field} = g:mines_losecnt{s:field} + !a:winner
  if a:winner == 1
   let g:mines_curwinstreak{s:field}  = g:mines_curwinstreak{s:field} + 1
   let g:mines_curlosestreak{s:field} = 0
   if g:mines_curwinstreak{s:field} > g:mines_winstreak{s:field}
   	let g:mines_winstreak{s:field}= g:mines_curwinstreak{s:field}
   endif
  else
   let g:mines_curlosestreak{s:field} = g:mines_curlosestreak{s:field} + 1
   let g:mines_curwinstreak{s:field}  = 0
   if g:mines_curlosestreak{s:field} > g:mines_losestreak{s:field}
   	let g:mines_losestreak{s:field}= g:mines_curlosestreak{s:field}
   endif
  endif

  if a:winner == 1
   if g:mines_time{s:field} == 0 || g:mines_time{s:field} > s:timelapse
   	let g:mines_time{s:field}= s:timelapse
   endif
  endif
"  call Dret("UpdateStatistics")
endfun

" ---------------------------------------------------------------------
" StatSanity: make sure statistics variables are initialized to zero {{{2
"             if they don't exist
fun! s:StatSanity(field)
"  call Dfunc("StatSanity(field<".a:field.">)")

   let g:mines_wincnt{a:field}        = 0
   let g:mines_curwinstreak{a:field}  = 0
   let g:mines_curlosestreak{a:field} = 0
   let g:mines_winstreak{a:field}     = 0
   let g:mines_losestreak{a:field}    = 0
   let g:mines_losecnt{a:field}       = 0
   if !exists("g:mines_time{a:field}")
    let g:mines_time{a:field}         = 0
   endif

"  call Dret("StatSanity")
endfun

" ---------------------------------------------------------------------
" Mines#SaveStatistics: {{{2
fun! Mines#SaveStatistics(mode)
"  call Dfunc("Mines#SaveStatistics(mode=".a:mode.")")

  if $HOME == ""
"   call Dret("Mines#SaveStatistics : no $HOME")
   return
  endif

  if a:mode == 0
   let g:mines_wincntE        = 0
   let g:mines_curwinstreakE  = 0
   let g:mines_curlosestreakE = 0
   let g:mines_winstreakE     = 0
   let g:mines_losestreakE    = 0
   let g:mines_losecntE       = 0
   let g:mines_timeE          = 0

   let g:mines_wincntM        = 0
   let g:mines_curwinstreakM  = 0
   let g:mines_curlosestreakM = 0
   let g:mines_winstreakM     = 0
   let g:mines_losestreakM    = 0
   let g:mines_losecntM       = 0
   let g:mines_timeM          = 0

   let g:mines_wincntH        = 0
   let g:mines_curwinstreakH  = 0
   let g:mines_curlosestreakH = 0
   let g:mines_winstreakH     = 0
   let g:mines_losestreakH    = 0
   let g:mines_losecntH       = 0
   let g:mines_timeH          = 0
  endif

  " write statistics to $HOME/.vimMines
  exe "silent! vsp ".$HOME."/.vimMines"
  setlocal bh=wipe
  silent! %d

  put ='let g:mines_wincntE       ='.g:mines_wincntE
  put ='let g:mines_curwinstreakE ='.g:mines_curwinstreakE
  put ='let g:mines_curlosestreakE='.g:mines_curlosestreakE
  put ='let g:mines_winstreakE    ='.g:mines_winstreakE
  put ='let g:mines_losestreakE   ='.g:mines_losestreakE
  put ='let g:mines_losecntE      ='.g:mines_losecntE
  put ='let g:mines_timeE         ='.g:mines_timeE

  put ='let g:mines_wincntM       ='.g:mines_wincntM
  put ='let g:mines_curwinstreakM ='.g:mines_curwinstreakM
  put ='let g:mines_curlosestreakM='.g:mines_curlosestreakM
  put ='let g:mines_winstreakM    ='.g:mines_winstreakM
  put ='let g:mines_losestreakM   ='.g:mines_losestreakM
  put ='let g:mines_losecntM      ='.g:mines_losecntM
  put ='let g:mines_timeM         ='.g:mines_timeM

  put ='let g:mines_wincntH       ='.g:mines_wincntH
  put ='let g:mines_curwinstreakH ='.g:mines_curwinstreakH
  put ='let g:mines_curlosestreakH='.g:mines_curlosestreakH
  put ='let g:mines_winstreakH    ='.g:mines_winstreakH
  put ='let g:mines_losestreakH   ='.g:mines_losestreakH
  put ='let g:mines_losecntH      ='.g:mines_losecntH
  put ='let g:mines_timeH         ='.g:mines_timeH

  silent! w!
  silent! q!

"  call Dret("Mines#SaveStatistics")
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
plugin/Rndm.vim	[[[1
199
" Rndm:
"  Author:  Charles E. Campbell, Jr.
"  Date:    Aug 12, 2008
"  Version: 4f	ASTRO-ONLY
"
"  Discussion:  algorithm developed at MIT
"
"           <Rndm.vim> uses three pseudo-random seed variables
"              g:rndm_m1 g:rndm_m2 g:rndm_m3
"           Each should be on the interval [0, 100,000,000)
"
" RndmInit(s1,s2,s3): takes three arguments to set the three seeds (optional)
" Rndm()            : generates a pseudo-random variate on [0,100000000)
" Urndm(a,b)        : generates a uniformly distributed pseudo-random variate
"                     on the interval [a,b]
" Dice(qty,sides)   : emulates a variate from sum of "qty" user-specified
"                     dice, each of which can take on values [1,sides]
" SetDeck(N)        : returns a pseudo-random "deck" of integers from 1..N
"                     (actually, a list of pseudo-randomly distributed integers)
"
"Col 2:8: Be careful that you don't let anyone rob you through his philosophy
"         and vain deceit, after the tradition of men, after the elements of
"         the world, and not after Christ.

" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("loaded_Rndm")
 finish
endif
let g:loaded_Rndm = "v4f"
let s:keepcpo     = &cpo
set cpo&vim

" ---------------------------------------------------------------------
" Randomization Variables: {{{1
" with a little extra randomized start from localtime()
let g:rndm_m1 = 32007779 + (localtime()%100 - 50)
let g:rndm_m2 = 23717810 + (localtime()/86400)%100
let g:rndm_m3 = 52636370 + (localtime()/3600)%100

" ---------------------------------------------------------------------
" RndmInit: allow user to initialize pseudo-random number generator seeds {{{1
fun! RndmInit(...)
"  call Dfunc("RndmInit() a:0=".a:0)

  if a:0 >= 3
   " set seed to specified values
   let g:rndm_m1 = a:1
   let g:rndm_m2 = a:2
   let g:rndm_m3 = a:3
"   call Decho("set seeds to [".g:rndm_m1.",".g:rndm_m2.",".g:rndm_m3."]")

  elseif filereadable($HOME."/.seed")
   " initialize the pseudo-random seeds by reading the .seed file
   " when doing this, one should also save seeds at the end-of-script
   " by calling RndmSave().
   let keeplz= &lz
   let eikeep= &ei
   set lz ei=all

   1split
   exe "silent! e ".expand("$HOME")."/.seed"
   let curbuf= bufnr("%")
"   call Decho("curbuf=".curbuf." fname<".expand("%").">")
   silent! s/ /\r/g
   exe "let g:rndm_m1=".getline(1)
   exe "let g:rndm_m2=".getline(2)
   exe "let g:rndm_m3=".getline(3)
"   call Decho("set seeds to [".g:rndm_m1.",".g:rndm_m2.",".g:rndm_m3."]")
   silent! q!
   if bufexists(curbuf)
    exe curbuf."bw!"
   endif

   let &lz= keeplz
   let &ei= eikeep
  endif
"  call Dret("RndmInit")
endfun

" ---------------------------------------------------------------------
" RndmSave: this function saves the current pseudu-random number seeds {{{2
fun! RndmSave()
"  call Dfunc("RndmSave()")
  if expand("$HOME") != "" && exists("g:rndm_m1") && exists("g:rndm_m2") && exists("g:rndm_m3")
   let keeplz= &lz
   let eikeep= &ei
   set lz ei=all

   1split
   enew
   call setline(1,"".g:rndm_m1." ".g:rndm_m2." ".g:rndm_m3)
   exe "w! ".expand("$HOME")."/.seed"
   let curbuf= bufnr(".")
   silent! q!
   if curbuf > 0
    exe "silent! ".curbuf."bw!"
   endif

   let &lz= keeplz
   let &ei= eikeep
  endif
"  call Dret("RndmSave")
endfun

" ---------------------------------------------------------------------
" Rndm: generate pseudo-random variate on [0,100000000) {{{1
fun! Rndm()
  let m4= g:rndm_m1 + g:rndm_m2 + g:rndm_m3
  if( g:rndm_m2 < 50000000 )
    let m4= m4 + 1357
  endif
  if( m4 >= 100000000 )
    let m4= m4 - 100000000
    if( m4 >= 100000000 )
      let m4= m4 - 100000000
    endif
  endif
  let g:rndm_m1 = g:rndm_m2
  let g:rndm_m2 = g:rndm_m3
  let g:rndm_m3 = m4
  return g:rndm_m3
endfun

" ---------------------------------------------------------------------
" Urndm: generate uniformly-distributed pseudo-random variate on [a,b] {{{1
fun! Urndm(a,b)

  " sanity checks
  if a:b < a:a
   return 0
  endif
  if a:b == a:a
   return a:a
  endif

  " Using modulus: rnd%(b-a+1) + a  loses high-bit information
  " and makes for a poor random variate.  Following code uses
  " rejection technique to adjust maximum interval range to
  " a multiple of (b-a+1)
  let amb       = a:b - a:a + 1
  let maxintrvl = 100000000 - ( 100000000 % amb)
  let isz       = maxintrvl / amb

  let rnd= Rndm()
  while rnd > maxintrvl
   let rnd= Rndm()
  endw

  return a:a + rnd/isz
endfun

" ---------------------------------------------------------------------
" Dice: assumes one is rolling a qty of dice with "sides" sides. {{{1
"       Example - to roll 5 four-sided dice, call Dice(5,4)
fun! Dice(qty,sides)
  let roll= 0

  let sum= 0
  while roll < a:qty
   let sum = sum + Urndm(1,a:sides)
   let roll= roll + 1
  endw

  return sum
endfun

" ---------------------------------------------------------------------
" SetDeck: this function returns a "deck" of integers from 1-N (actually, a list) {{{1
fun! SetDeck(N)
"  call Dfunc("SetDeck(N=".a:N.")")
  let deck = []
  let n    = 1
  " generate a sequential list of integers
  while n <= a:N
   let deck= add(deck,n)
   let n       = n + 1
  endwhile
  " generate a random deck using swaps
  let n= a:N-1
  while n > 0
   let p= Urndm(0,a:N-1)
   if n != p
	let swap    = deck[n]
	let deck[n] = deck[p]
	let deck[p] = swap
   endif
   let n= n - 1
  endwhile
"  call Dret("SetDeck")
  return deck
endfun

" ---------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  Modelines: {{{1
"  vim: fdm=marker
doc/Mines.txt	[[[1
206
*Mines.txt*	The Mines Game 				Mar 08, 2011

Author:  Charles E. Campbell, Jr.  <NdrOchip@ScampbellPfamily.AbizM>
	  (remove NOSPAM from the email address first)
Copyright: (c) 2004-2010 by Charles E. Campbell, Jr.	*mines-copyright*
           The VIM LICENSE applies to Mines.vim and Mines.txt
           (see |copyright|) except use "Mines" instead of "Vim"
	   No warranty, express or implied.  Use At-Your-Own-Risk.

=============================================================================
1. Mines:						*mines*

Mines is a Vim plugin, but you may source it in on demand if you wish.
You'll need <Mines.vim> and <Rndm.vim> - the latter file is available
as "Rndm" at the following website:

    http://mysite.verizon.net/astronaut/vim/index.html#VimFuncs


STARTING

    Games:						*mines-start*
        \mfc : clear statistics (when a game is not showing)
        \mfe : play an easy mines game
        \mfm : play a  medium-difficulty mines game
        \mfh : play a  high-difficulty mines game
        \mfr : restore a game

Note that using the \mf_ maps will save the files showing in all windows and
save your session.  Although I've used the backslash in the maps as shown here,
actually they use <Leader> so you may customize your maps as usual (see
|mapleader| for more about <Leader>).


USE AT YOUR OWN RISK

Mines.vim is a use-at-your-own-risk game.  However, an effort has been made
to preserve your files.  The game does a "windo w" and uses mksession to both
save your working files that are showing in your windows and to preserve your
window layout for subsequent restoration.


OBJECTIVE

The objective of the game is to flag all mines and to reveal all safe
squares.  As soon as you click a <leftmouse> or x, the square under the cursor
is revealed with either a count of the number of bombs around it or as a BOOM!
Of course, to use a mouse means your vim must support using the mouse.  Gvim
usually does; console vim may or may not depending on your supporting
terminal (see |'mouse'|).

Statistics are stored in <$HOME/.vimMines>.  You need to have a $HOME
environment variable set up properly for statistics to be kept.

If you win, Minnie will do a cartwheel for you!


GAME INTERFACE

On many terminals, all you need to do is to click with the left mouse (to see
what's there, or maybe to go BOOM!) or to click with the rightmouse to flag
what you think is a mine.

     -Play-						*mines-play*
        x  move the cursor around the field;
           pressing x is just like pressing a
           <leftmouse> -- find out what's
           hidden!
        f  just like the <rightmouse>, flag what's under the cursor as a mine
        0  goes to leftmost  position inside minefield
        $  goes to rightmost position inside minefield
        gg goes to uppermost position inside minefield
        G  goes to bttommost position inside minefield



     -Control-						*mines-control*
        C   clear statistics (only while a game is showing)
        s   suspend the game, restore the display
            and session  (\mfr will subsequently
            restore the game)

        q   quit the game, restore the display

     -New Games-					*mines-newgame*
        E   starts up a new easy game
            (only while an old game is showing)

        M   starts up a new medium game
            (only while an old game is showing)

        H   starts up a new hard game
            (only while an old game is showing)


=============================================================================
3. Hints:						*mines-hints*

My own win rate with Mines is about 30%, so don't expect a sure fire
way-to-win!  However, here are some hints.  If you don't want to see them,
close your eyes!

	1-9 qty of bombs in vicinity
	#   any number
	o   any number or blank (no bomb) space
	?   unknown
	f   flag the space
	x   find out what's in the space

	 Pattern         Can Safely Do         Pattern         Can Safely Do
         ooooo             ooooo
         oo3oo             oo3oo             	oooo              oooo
	                    fff              	111o              111o
                                             	                    x

	+-----             +-----
	|ooo               |ooo              	oooo              oooo
	|22o..             |22o..            	122o              122o
	|??                |ffx              	                    f


	 ooooo            ooooo
	 #121#            #121#
                           fxf


=============================================================================
2. History:						*mines-history* {{{1

   18 : 04/27/10   * the "norm" associated with flipping a flagged square back
		     to normal has been changed to "norm!".  No other plain
		     "norm"s are in Mines.vim.
	08/12/10   * Mines now saves&sets&restores options using local
		     variants, and noswf is used during Mines.
	12/20/10   * Implemented autoload'ing for Mines so that it takes
		     little time during startup
	03/07/11   * Found a bug where pressing "f" wouldn't restore a square
		     to "unknown" when it should (solution: needed to safe the
		     |'et'| setting)
	03/08/11   * Released to vim.sf.net
   17 : 04/08/08   * pressing "x" when atop an "f" now is a no-op; one must
		     use an "f" to clear an "f".
	11/29/08   * attempting to modify a completed minefield no longer
		     produces not-modifiable error messages.
	05/20/09   * cecutil bug fix
	07/30/09   * fixed a bug where part of the minefield would disappear
		     when virtualedit was off (I usually use :set ve=all).
   16 : 01/24/07   * on wins, percentage won now shown to 3 decimal places
		   * works with Rndm.vim to save seeds in $HOME/.seed to
		     improve pseudo-random nature of games
   15 : 06/28/06   * now includes cecutil.vim as part of its distribution
		   * when game is over, if -Mines- exists, it will be deleted
		   * "Flags Used" field was misplaced for Medium and Hard
		     games; fixed.
		   * a "redr!" for debugging was inadvertently left in,
		     causing flickering floods.  Fixed.
	08/10/06   * included "Time Used" field during play
	12/28/06   * at end-of-game, when one hits a mine, mistakenly flagged
		     squares are shown with truth with blue background
   14 : 06/26/06   * added "Flags Used" field while playing
	06/16/06   * pressing "c" changes corner
		   * pressing 0  goes to leftmost  position inside minefield
		   * pressing $  goes to rightmost position inside minefield
		   * pressing gg goes to uppermost position inside minefield
		   * pressing G  goes to bttommost position inside minefield
	05/16/06   * medium is now 15% mines, hard is 18% mines
		   * medium now uses an 18x18 grid
   13 : 01/06/06 : * the percentage wins is now shown to tenths
	12/28/05   * now uses cecutil to save/restore user maps
   12 : 05/23/05   * Mines will issue a message that Rndm is missing
		     (and where to get it) when Rndm is missing
	01/05/06   * Mines' win message now includes percentage of wins
   11 : 08/02/04 : * an X will now mark the bomb that went off
		   * bugfix: an "f" on a previously determined site
		     (whether numbered or blank) will now have no effect
		   * flipped the cterm=NONE and fg/bg specs about; some
		     machines were showing all bold which equated to one
		     color.
   10 : 07/28/04 : * updatetime now 200ms, affects time-left display when
		     g:mines_timer is true.  Restored after game finished.
		   * longest winning/losing streaks now computed&displayed
		   * statistics now kept separately for each field size
		   * now includes a title
		   * CursorHold used to fix highlighting after a
		     colorscheme change
    9 : 06/28/04 : * Mines now handles light as well as dark backgrounds
    8 : 06/15/04 : * improved look of Minnie at the end
		   * total/streak win/loss statistics
    7 : 12/08/03 : changed a norm to norm! to avoid <c-y> mapping
    6 : 10/16/03 : includes help
    5 : 05/08/03 : adjusted Med/Hard to be 20% mines
    4 : 02/03/03 : \mft toggles g:mines_timer
		   colons lined up for Happy()
		   multiple x hits after a Minnie repeated Minnie - fixed
		   saves/restores gdefault (turns it to nogd during game)
    3 : 02/03/03 : map restoration was done too early, now fixed
		   \mfr didn't always set ts to 1; fixed
		   included E M H maps for easily starting new games
		   escape() now used on s:restoremap prior to execution
		   g:mines_timer  (by default enabled) if true applies
		   time-limit
    2 : 01/31/03 : now intercepts attempts to restore a quit game
		   quit games' s:minebufnum is now unlet

=============================================================================
vim:tw=78:ts=8:ft=help:fdm=marker
plugin/cecutil.vim	[[[1
536
" cecutil.vim : save/restore window position
"               save/restore mark position
"               save/restore selected user maps
"  Author:	Charles E. Campbell, Jr.
"  Version:	18h	ASTRO-ONLY
"  Date:	Apr 05, 2010
"
"  Saving Restoring Destroying Marks: {{{1
"       call SaveMark(markname)       let savemark= SaveMark(markname)
"       call RestoreMark(markname)    call RestoreMark(savemark)
"       call DestroyMark(markname)
"       commands: SM RM DM
"
"  Saving Restoring Destroying Window Position: {{{1
"       call SaveWinPosn()        let winposn= SaveWinPosn()
"       call RestoreWinPosn()     call RestoreWinPosn(winposn)
"		\swp : save current window/buffer's position
"		\rwp : restore current window/buffer's previous position
"       commands: SWP RWP
"
"  Saving And Restoring User Maps: {{{1
"       call SaveUserMaps(mapmode,maplead,mapchx,suffix)
"       call RestoreUserMaps(suffix)
"
" GetLatestVimScripts: 1066 1 :AutoInstall: cecutil.vim
"
" You believe that God is one. You do well. The demons also {{{1
" believe, and shudder. But do you want to know, vain man, that
" faith apart from works is dead?  (James 2:19,20 WEB)
"redraw!|call inputsave()|call input("Press <cr> to continue")|call inputrestore()

" ---------------------------------------------------------------------
" Load Once: {{{1
if &cp || exists("g:loaded_cecutil")
 finish
endif
let g:loaded_cecutil = "v18h"
let s:keepcpo        = &cpo
set cpo&vim
"DechoRemOn

" =======================
"  Public Interface: {{{1
" =======================

" ---------------------------------------------------------------------
"  Map Interface: {{{2
if !hasmapto('<Plug>SaveWinPosn')
 map <unique> <Leader>swp <Plug>SaveWinPosn
endif
if !hasmapto('<Plug>RestoreWinPosn')
 map <unique> <Leader>rwp <Plug>RestoreWinPosn
endif
nmap <silent> <Plug>SaveWinPosn		:call SaveWinPosn()<CR>
nmap <silent> <Plug>RestoreWinPosn	:call RestoreWinPosn()<CR>

" ---------------------------------------------------------------------
" Command Interface: {{{2
com! -bar -nargs=0 SWP	call SaveWinPosn()
com! -bar -nargs=? RWP	call RestoreWinPosn(<args>)
com! -bar -nargs=1 SM	call SaveMark(<q-args>)
com! -bar -nargs=1 RM	call RestoreMark(<q-args>)
com! -bar -nargs=1 DM	call DestroyMark(<q-args>)

com! -bar -nargs=1 WLR	call s:WinLineRestore(<q-args>)

if v:version < 630
 let s:modifier= "sil! "
else
 let s:modifier= "sil! keepj "
endif

" ===============
" Functions: {{{1
" ===============

" ---------------------------------------------------------------------
" SaveWinPosn: {{{2
"    let winposn= SaveWinPosn()  will save window position in winposn variable
"    call SaveWinPosn()          will save window position in b:cecutil_winposn{b:cecutil_iwinposn}
"    let winposn= SaveWinPosn(0) will *only* save window position in winposn variable (no stacking done)
fun! SaveWinPosn(...)
"  echomsg "Decho: SaveWinPosn() a:0=".a:0
  if line("$") == 1 && getline(1) == ""
"   echomsg "Decho: SaveWinPosn : empty buffer"
   return ""
  endif
  let so_keep   = &l:so
  let siso_keep = &siso
  let ss_keep   = &l:ss
  setlocal so=0 siso=0 ss=0

  let swline = line(".")                           " save-window line in file
  let swcol  = col(".")                            " save-window column in file
  if swcol >= col("$")
   let swcol= swcol + virtcol(".") - virtcol("$")  " adjust for virtual edit (cursor past end-of-line)
  endif
  let swwline   = winline() - 1                    " save-window window line
  let swwcol    = virtcol(".") - wincol()          " save-window window column
  let savedposn = ""
"  echomsg "Decho: sw[".swline.",".swcol."] sww[".swwline.",".swwcol."]"
  let savedposn = "call GoWinbufnr(".winbufnr(0).")"
  let savedposn = savedposn."|".s:modifier.swline
  let savedposn = savedposn."|".s:modifier."norm! 0z\<cr>"
  if swwline > 0
   let savedposn= savedposn.":".s:modifier."call s:WinLineRestore(".(swwline+1).")\<cr>"
  endif
  if swwcol > 0
   let savedposn= savedposn.":".s:modifier."norm! 0".swwcol."zl\<cr>"
  endif
  let savedposn = savedposn.":".s:modifier."call cursor(".swline.",".swcol.")\<cr>"

  " save window position in
  " b:cecutil_winposn_{iwinposn} (stack)
  " only when SaveWinPosn() is used
  if a:0 == 0
   if !exists("b:cecutil_iwinposn")
	let b:cecutil_iwinposn= 1
   else
	let b:cecutil_iwinposn= b:cecutil_iwinposn + 1
   endif
"   echomsg "Decho: saving posn to SWP stack"
   let b:cecutil_winposn{b:cecutil_iwinposn}= savedposn
  endif

  let &l:so = so_keep
  let &siso = siso_keep
  let &l:ss = ss_keep

"  if exists("b:cecutil_iwinposn")                                                                  " Decho
"   echomsg "Decho: b:cecutil_winpos{".b:cecutil_iwinposn."}[".b:cecutil_winposn{b:cecutil_iwinposn}."]"
"  else                                                                                             " Decho
"   echomsg "Decho: b:cecutil_iwinposn doesn't exist"
"  endif                                                                                            " Decho
"  echomsg "Decho: SaveWinPosn [".savedposn."]"
  return savedposn
endfun

" ---------------------------------------------------------------------
" RestoreWinPosn: {{{2
"      call RestoreWinPosn()
"      call RestoreWinPosn(winposn)
fun! RestoreWinPosn(...)
"  echomsg "Decho: RestoreWinPosn() a:0=".a:0
"  echomsg "Decho: getline(1)<".getline(1).">"
"  echomsg "Decho: line(.)=".line(".")
  if line("$") == 1 && getline(1) == ""
"   echomsg "Decho: RestoreWinPosn : empty buffer"
   return ""
  endif
  let so_keep   = &l:so
  let siso_keep = &l:siso
  let ss_keep   = &l:ss
  setlocal so=0 siso=0 ss=0

  if a:0 == 0 || a:1 == ""
   " use saved window position in b:cecutil_winposn{b:cecutil_iwinposn} if it exists
   if exists("b:cecutil_iwinposn") && exists("b:cecutil_winposn{b:cecutil_iwinposn}")
"    echomsg "Decho: using stack b:cecutil_winposn{".b:cecutil_iwinposn."}<".b:cecutil_winposn{b:cecutil_iwinposn}.">"
	try
	 exe s:modifier.b:cecutil_winposn{b:cecutil_iwinposn}
	catch /^Vim\%((\a\+)\)\=:E749/
	 " ignore empty buffer error messages
	endtry
	" normally drop top-of-stack by one
	" but while new top-of-stack doesn't exist
	" drop top-of-stack index by one again
	if b:cecutil_iwinposn >= 1
	 unlet b:cecutil_winposn{b:cecutil_iwinposn}
	 let b:cecutil_iwinposn= b:cecutil_iwinposn - 1
	 while b:cecutil_iwinposn >= 1 && !exists("b:cecutil_winposn{b:cecutil_iwinposn}")
	  let b:cecutil_iwinposn= b:cecutil_iwinposn - 1
	 endwhile
	 if b:cecutil_iwinposn < 1
	  unlet b:cecutil_iwinposn
	 endif
	endif
   else
	echohl WarningMsg
	echomsg "***warning*** need to SaveWinPosn first!"
	echohl None
   endif

  else	 " handle input argument
"   echomsg "Decho: using input a:1<".a:1.">"
   " use window position passed to this function
   exe a:1
   " remove a:1 pattern from b:cecutil_winposn{b:cecutil_iwinposn} stack
   if exists("b:cecutil_iwinposn")
	let jwinposn= b:cecutil_iwinposn
	while jwinposn >= 1                     " search for a:1 in iwinposn..1
	 if exists("b:cecutil_winposn{jwinposn}")    " if it exists
	  if a:1 == b:cecutil_winposn{jwinposn}      " and the pattern matches
	   unlet b:cecutil_winposn{jwinposn}            " unlet it
	   if jwinposn == b:cecutil_iwinposn            " if at top-of-stack
		let b:cecutil_iwinposn= b:cecutil_iwinposn - 1      " drop stacktop by one
	   endif
	  endif
	 endif
	 let jwinposn= jwinposn - 1
	endwhile
   endif
  endif

  " Seems to be something odd: vertical motions after RWP
  " cause jump to first column.  The following fixes that.
  " Note: was using wincol()>1, but with signs, a cursor
  " at column 1 yields wincol()==3.  Beeping ensued.
  let vekeep= &ve
  set ve=all
  if virtcol('.') > 1
   exe s:modifier."norm! hl"
  elseif virtcol(".") < virtcol("$")
   exe s:modifier."norm! lh"
  endif
  let &ve= vekeep

  let &l:so   = so_keep
  let &l:siso = siso_keep
  let &l:ss   = ss_keep

"  echomsg "Decho: RestoreWinPosn"
endfun

" ---------------------------------------------------------------------
" s:WinLineRestore: {{{2
fun! s:WinLineRestore(swwline)
"  echomsg "Decho: s:WinLineRestore(swwline=".a:swwline.")"
  while winline() < a:swwline
   let curwinline= winline()
   exe s:modifier."norm! \<c-y>"
   if curwinline == winline()
	break
   endif
  endwhile
"  echomsg "Decho: s:WinLineRestore"
endfun

" ---------------------------------------------------------------------
" GoWinbufnr: go to window holding given buffer (by number) {{{2
"   Prefers current window; if its buffer number doesn't match,
"   then will try from topleft to bottom right
fun! GoWinbufnr(bufnum)
"  call Dfunc("GoWinbufnr(".a:bufnum.")")
  if winbufnr(0) == a:bufnum
"   call Dret("GoWinbufnr : winbufnr(0)==a:bufnum")
   return
  endif
  winc t
  let first=1
  while winbufnr(0) != a:bufnum && (first || winnr() != 1)
  	winc w
	let first= 0
   endwhile
"  call Dret("GoWinbufnr")
endfun

" ---------------------------------------------------------------------
" SaveMark: sets up a string saving a mark position. {{{2
"           For example, SaveMark("a")
"           Also sets up a global variable, g:savemark_{markname}
fun! SaveMark(markname)
"  call Dfunc("SaveMark(markname<".a:markname.">)")
  let markname= a:markname
  if strpart(markname,0,1) !~ '\a'
   let markname= strpart(markname,1,1)
  endif
"  call Decho("markname=".markname)

  let lzkeep  = &lz
  set lz

  if 1 <= line("'".markname) && line("'".markname) <= line("$")
   let winposn               = SaveWinPosn(0)
   exe s:modifier."norm! `".markname
   let savemark              = SaveWinPosn(0)
   let g:savemark_{markname} = savemark
   let savemark              = markname.savemark
   call RestoreWinPosn(winposn)
  else
   let g:savemark_{markname} = ""
   let savemark              = ""
  endif

  let &lz= lzkeep

"  call Dret("SaveMark : savemark<".savemark.">")
  return savemark
endfun

" ---------------------------------------------------------------------
" RestoreMark: {{{2
"   call RestoreMark("a")  -or- call RestoreMark(savemark)
fun! RestoreMark(markname)
"  call Dfunc("RestoreMark(markname<".a:markname.">)")

  if strlen(a:markname) <= 0
"   call Dret("RestoreMark : no such mark")
   return
  endif
  let markname= strpart(a:markname,0,1)
  if markname !~ '\a'
   " handles 'a -> a styles
   let markname= strpart(a:markname,1,1)
  endif
"  call Decho("markname=".markname." strlen(a:markname)=".strlen(a:markname))

  let lzkeep  = &lz
  set lz
  let winposn = SaveWinPosn(0)

  if strlen(a:markname) <= 2
   if exists("g:savemark_{markname}") && strlen(g:savemark_{markname}) != 0
	" use global variable g:savemark_{markname}
"	call Decho("use savemark list")
	call RestoreWinPosn(g:savemark_{markname})
	exe "norm! m".markname
   endif
  else
   " markname is a savemark command (string)
"	call Decho("use savemark command")
   let markcmd= strpart(a:markname,1)
   call RestoreWinPosn(markcmd)
   exe "norm! m".markname
  endif

  call RestoreWinPosn(winposn)
  let &lz       = lzkeep

"  call Dret("RestoreMark")
endfun

" ---------------------------------------------------------------------
" DestroyMark: {{{2
"   call DestroyMark("a")  -- destroys mark
fun! DestroyMark(markname)
"  call Dfunc("DestroyMark(markname<".a:markname.">)")

  " save options and set to standard values
  let reportkeep= &report
  let lzkeep    = &lz
  set lz report=10000

  let markname= strpart(a:markname,0,1)
  if markname !~ '\a'
   " handles 'a -> a styles
   let markname= strpart(a:markname,1,1)
  endif
"  call Decho("markname=".markname)

  let curmod  = &mod
  let winposn = SaveWinPosn(0)
  1
  let lineone = getline(".")
  exe "k".markname
  d
  put! =lineone
  let &mod    = curmod
  call RestoreWinPosn(winposn)

  " restore options to user settings
  let &report = reportkeep
  let &lz     = lzkeep

"  call Dret("DestroyMark")
endfun

" ---------------------------------------------------------------------
" QArgSplitter: to avoid \ processing by <f-args>, <q-args> is needed. {{{2
" However, <q-args> doesn't split at all, so this one returns a list
" with splits at all whitespace (only!), plus a leading length-of-list.
" The resulting list:  qarglist[0] corresponds to a:0
"                      qarglist[i] corresponds to a:{i}
fun! QArgSplitter(qarg)
"  call Dfunc("QArgSplitter(qarg<".a:qarg.">)")
  let qarglist    = split(a:qarg)
  let qarglistlen = len(qarglist)
  let qarglist    = insert(qarglist,qarglistlen)
"  call Dret("QArgSplitter ".string(qarglist))
  return qarglist
endfun

" ---------------------------------------------------------------------
" ListWinPosn: {{{2
"fun! ListWinPosn()                                                        " Decho 
"  if !exists("b:cecutil_iwinposn") || b:cecutil_iwinposn == 0             " Decho 
"   call Decho("nothing on SWP stack")                                     " Decho
"  else                                                                    " Decho
"   let jwinposn= b:cecutil_iwinposn                                       " Decho 
"   while jwinposn >= 1                                                    " Decho 
"    if exists("b:cecutil_winposn{jwinposn}")                              " Decho 
"     call Decho("winposn{".jwinposn."}<".b:cecutil_winposn{jwinposn}.">") " Decho 
"    else                                                                  " Decho 
"     call Decho("winposn{".jwinposn."} -- doesn't exist")                 " Decho 
"    endif                                                                 " Decho 
"    let jwinposn= jwinposn - 1                                            " Decho 
"   endwhile                                                               " Decho 
"  endif                                                                   " Decho
"endfun                                                                    " Decho 
"com! -nargs=0 LWP	call ListWinPosn()                                    " Decho 

" ---------------------------------------------------------------------
" SaveUserMaps: this function sets up a script-variable (s:restoremap) {{{2
"          which can be used to restore user maps later with
"          call RestoreUserMaps()
"
"          mapmode - see :help maparg for details (n v o i c l "")
"                    ex. "n" = Normal
"                    The letters "b" and "u" are optional prefixes;
"                    The "u" means that the map will also be unmapped
"                    The "b" means that the map has a <buffer> qualifier
"                    ex. "un"  = Normal + unmapping
"                    ex. "bn"  = Normal + <buffer>
"                    ex. "bun" = Normal + <buffer> + unmapping
"                    ex. "ubn" = Normal + <buffer> + unmapping
"          maplead - see mapchx
"          mapchx  - "<something>" handled as a single map item.
"                    ex. "<left>"
"                  - "string" a string of single letters which are actually
"                    multiple two-letter maps (using the maplead:
"                    maplead . each_character_in_string)
"                    ex. maplead="\" and mapchx="abc" saves user mappings for
"                        \a, \b, and \c
"                    Of course, if maplead is "", then for mapchx="abc",
"                    mappings for a, b, and c are saved.
"                  - :something  handled as a single map item, w/o the ":"
"                    ex.  mapchx= ":abc" will save a mapping for "abc"
"          suffix  - a string unique to your plugin
"                    ex.  suffix= "DrawIt"
fun! SaveUserMaps(mapmode,maplead,mapchx,suffix)
"  call Dfunc("SaveUserMaps(mapmode<".a:mapmode."> maplead<".a:maplead."> mapchx<".a:mapchx."> suffix<".a:suffix.">)")

  if !exists("s:restoremap_{a:suffix}")
   " initialize restoremap_suffix to null string
   let s:restoremap_{a:suffix}= ""
  endif

  " set up dounmap: if 1, then save and unmap  (a:mapmode leads with a "u")
  "                 if 0, save only
  let mapmode  = a:mapmode
  let dounmap  = 0
  let dobuffer = ""
  while mapmode =~ '^[bu]'
   if     mapmode =~ '^u'
    let dounmap = 1
    let mapmode = strpart(a:mapmode,1)
   elseif mapmode =~ '^b'
    let dobuffer = "<buffer> "
    let mapmode  = strpart(a:mapmode,1)
   endif
  endwhile
"  call Decho("dounmap=".dounmap."  dobuffer<".dobuffer.">")
 
  " save single map :...something...
  if strpart(a:mapchx,0,1) == ':'
"   call Decho("save single map :...something...")
   let amap= strpart(a:mapchx,1)
   if amap == "|" || amap == "\<c-v>"
    let amap= "\<c-v>".amap
   endif
   let amap                    = a:maplead.amap
   let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|:silent! ".mapmode."unmap ".dobuffer.amap
   if maparg(amap,mapmode) != ""
    let maprhs                  = substitute(maparg(amap,mapmode),'|','<bar>','ge')
	let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|:".mapmode."map ".dobuffer.amap." ".maprhs
   endif
   if dounmap
	exe "silent! ".mapmode."unmap ".dobuffer.amap
   endif
 
  " save single map <something>
  elseif strpart(a:mapchx,0,1) == '<'
"   call Decho("save single map <something>")
   let amap       = a:mapchx
   if amap == "|" || amap == "\<c-v>"
    let amap= "\<c-v>".amap
"	call Decho("amap[[".amap."]]")
   endif
   let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|silent! ".mapmode."unmap ".dobuffer.amap
   if maparg(a:mapchx,mapmode) != ""
    let maprhs                  = substitute(maparg(amap,mapmode),'|','<bar>','ge')
	let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|".mapmode."map ".dobuffer.amap." ".maprhs
   endif
   if dounmap
	exe "silent! ".mapmode."unmap ".dobuffer.amap
   endif
 
  " save multiple maps
  else
"   call Decho("save multiple maps")
   let i= 1
   while i <= strlen(a:mapchx)
    let amap= a:maplead.strpart(a:mapchx,i-1,1)
	if amap == "|" || amap == "\<c-v>"
	 let amap= "\<c-v>".amap
	endif
	let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|silent! ".mapmode."unmap ".dobuffer.amap
    if maparg(amap,mapmode) != ""
     let maprhs                  = substitute(maparg(amap,mapmode),'|','<bar>','ge')
	 let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|".mapmode."map ".dobuffer.amap." ".maprhs
    endif
	if dounmap
	 exe "silent! ".mapmode."unmap ".dobuffer.amap
	endif
    let i= i + 1
   endwhile
  endif
"  call Dret("SaveUserMaps : restoremap_".a:suffix.": ".s:restoremap_{a:suffix})
endfun

" ---------------------------------------------------------------------
" RestoreUserMaps: {{{2
"   Used to restore user maps saved by SaveUserMaps()
fun! RestoreUserMaps(suffix)
"  call Dfunc("RestoreUserMaps(suffix<".a:suffix.">)")
  if exists("s:restoremap_{a:suffix}")
   let s:restoremap_{a:suffix}= substitute(s:restoremap_{a:suffix},'|\s*$','','e')
   if s:restoremap_{a:suffix} != ""
"   	call Decho("exe ".s:restoremap_{a:suffix})
    exe "silent! ".s:restoremap_{a:suffix}
   endif
   unlet s:restoremap_{a:suffix}
  endif
"  call Dret("RestoreUserMaps")
endfun

" ==============
"  Restore: {{{1
" ==============
let &cpo= s:keepcpo
unlet s:keepcpo

" ================
"  Modelines: {{{1
" ================
" vim: ts=4 fdm=marker
