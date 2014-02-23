" vim: set ts=2 sw=2 et sts=2
" Author: Joe Dornisch's

" Usually good stuff is done in the example file
source $VIMRUNTIME/vimrc_example.vim

if has ("vms")
  set nobackup "vms already keeeps backup files
else
  set backup
endif

execute pathogen#infect()

filetype plugin indent on

" --------------------------------------------------------------------------- "
" Settings
set history=150
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set laststatus=2    " keeps the status line up
set winminheight=0  " allows windows to be shrunk to just the status line
set winminwidth=0
set eadirection=hor " when equalizing (on splits) only keep the vertical even

" store backup files but try not to clutter up the directory in use
set backupdir=~/.vimbackupdir,.
" Don't resort to standard VI
set nocompatible

set expandtab

" Use the Wild menu for selections with <C-N>.  Use expansion and list for the
" tab.
set wildmenu
set wildchar=<C-N>

" kill the annyoning bell
set vb t_vb="

" When you want to see hidden characters, use the following
" set list
"set listchars=trail:...:tab:...:eol:...

" Preserve the column
set nostartofline

" Show as much of the last line as possible (when lines are very long)
set display=lastline

" Ignore whitespace when diffing
set diffopt=iwhite,filler

set clipboard=unnamed

if (version >= 700)
  " show a cool cursor line
  if (version >= 701)
    set cursorline
  endif
  " Allow virtual editing in Visual block mode, insert mode
  " Also allow the cursor to move one past the end of the line.
  set virtualedit=block

  " Displaying the tabs in the popup takes too long and ruins recordings. So
  " first limit the number of files completed to the current buffer, other
  " windows and included files (the included files completion may have to go
  " too...
  set complete=.,w,i
  " restrict the size of the popup to 6 entries
  set pumheight=6
endif

" TAGS
" set tags here...
set tags=./tags,tags,Z:\jad292\workspace\mytags

" Annoying red words that shouldn't be
let java_allow_cpp_keywords=1
let html_wrong_comments=1 " use the typical <!-- ... --> html comment

" --------------------------------------------------------------------------- "
" Autocommands
" First set default indentation
set ts=2 sw=2 et

" For all text files set 'textwidth' to 78 characters
autocmd FileType text setlocal textwidth=78
" Qt Make file - looks like Makefile
autocmd BufRead,BufNewFile *.pro setfiletype=make
" Qt GUI designer files are in XML
autocmd BufRead,BufNewFile *.ui setfiletype=xml

let g:SaveUndoLevels = &undolevels
let g:BufSizeThreshold = 10000000
if has("autocmd")
  " Store preferred undo levels
  au VimEnter * let g:SaveUndoLevels = &undolevels
  " Don't use a swap file for big files
  au BufReadPre * if getfsize(expand("%")) >= g:BufSizeThreshold | setlocal noswapfile | endif
  " Upon entering a buffer, set or restore the number of undo levels
  au BufEnter * if getfsize(expand("%")) < g:BufSizeThreshold | let &undolevels=g:SaveUndoLevels | hi Cursor term=reverse ctermbg=black guibg=black | else | set undolevels=-1 | hi Cursor term=underline ctermbg=red guibg=red | endif
endif

augroup ALL
  autocmd! ALL
  autocmd BufRead,BufEnter,BufNewFile * lcd %:p:h
  autocmd BufUnload * call WriteBackupFile()
augroup END

augroup Web
  autocmd! Web
  "autocmd BufRead,BufEnter,BufNewFile *.jsp set ts=2 sw=2 si fo+=ro
  autocmd BufRead,BufEnter,BufNewFile *.jsp set si fo+=ro
  "autocmd BufRead,BufEnter,BufNewFile *.jsp syntax sync minlines=2000
  autocmd BufRead,BufEnter,BufNewFile *.jsp syntax sync fromstart
  autocmd BufRead,BufEnter,BufNewFile *.html syntax sync minlines=2000
  autocmd BufRead,BufEnter,BufNewFile *.js call SetJavascriptStyle()
  "autocmd BufRead,BufEnter,BufNewFile *.jsp set indentkeys=o,O,<[^%]>>,{,}
augroup END

augroup Java
  autocmd! Java
  autocmd BufRead,BufEnter,BufNewFile *.java call SetJavaStyle()
  autocmd BufRead,BufEnter,BufNewFile *.java set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
  autocmd BufRead,BufEnter,BufNewFile *.jsp set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
  autocmd BufRead,BufEnter,BufNewFile *.java set makeprg=ant
  autocmd BufRead,BufEnter,BufNewFile *.jsp set makeprg=ant
augroup END

augroup Xml
  autocmd! Xml
  autocmd BufRead,BufEnter,BufNewFile *.xml call SetXmlStyle()
augroup END

augroup Sql
  autocmd BufRead,BufEnter,BufNewFile *.sql lcd %:p:h
augroup END

" clojure junk
"
"  Parentheses colours using Solarized
let g:rbpt_colorpairs = [
      \ [ '13', '#6c71c4'],
      \ [ '5',  '#d33682'],
      \ [ '1',  '#dc322f'],
      \ [ '9',  '#cb4b16'],
      \ [ '3',  '#b58900'],
      \ [ '2',  '#859900'],
      \ [ '6',  '#2aa198'],
      \ [ '4',  '#268bd2'],
      \ ]

" Enable rainbow parentheses for all buffers
augroup rainbow_parentheses
  au!
  au VimEnter * RainbowParenthesesActivate
  au BufEnter * RainbowParenthesesLoadRound
  au BufEnter * RainbowParenthesesLoadSquare
  au BufEnter * RainbowParenthesesLoadBraces
augroup END


" --------------------------------------------------------------------------- "
" Abbreviations
iab teh the
iab lenght length
iab thorw throw
iab recieve receive
iab recieving receiving
iab recieved received
iab recieves receives
iab copyied copied
iab defualt default
iab fucntion function

cab Amak make
cab Amek make
cab AMek make
cab amke make
cab Amke make
cab Make make
cab MAke make

cab ml make -f Z:\jad292\workspace\LIONFEED\build.xml
cab mg make -f Z:\jad292\workspace\gekml\build.xml

cab Ts ts
cab Tag tag
cab Res res

cab Tabnext tabnext
cab Tabn    tabnext
cab Tabprev tabprev
cab Tabp    tabprev

cab bcd Bcd
cab blcd Blcd
cab Cd cd
cab Lcd lcd
cab Vsp vsp
cab Grep grep
cab gerp grep
cab rj tj
cab Wq wq
cab W w
cab E e
cab qw wq
cab Qa qa
cab Sp sp

" Good for Search/Replace
cab ww \(\w\+\)
cab SS \(\S\+\)

cab conly Conly
cab vres vert res

cab bottomright botright

" --------------------------------------------------------------------------- "
" Maps

map + :res +1<CR>
map - :res -1<CR>

" Get rid of legacy Vi based Y - yank to end of line instead of whole line
map Y y$

" _p - turns on or off paste
map _p :set paste!<CR>:set paste?<CR>

" _s - switch what is before and after the equal sign, everything has to be on
" one line for this to work, and it has to be one statement. Only 1 '=' sign
" can be on the line and it must be surrounded by spaces.
map _s f;i = <Esc>^vt=hdf;P^h3x

" ,p - Rediculous map to make getters and setters in Java
map ,p 0wcwpublic<Esc>ea <C-N><Esc>biget<Esc>l~hea() {<Esc>yyp0wwdw$bP$xa) {<Esc>0wwivoid <Esc>wrsf)4xothis.<C-P><C-P> = <C-P>;<CR>}<CR><Esc>4k$Bhs<CR>return <Esc>o}<CR><Esc>5j0

" _f - fold the buffer about the braces {,}
map _f :syn region myFold start="{" end="}" transparent fold<CR>:syn sync fromstart<CR> :set foldmethod=syntax<CR>

" _b/_t - move to the bottom or top window in a column respectively
map _b <C-W>99j
map _t <C-W>99k

" set list - view list characters (uses the listchars setting)
map _l :set list!<CR>:set list?<CR>

" _v - source this file
map _v :source ~/.vimrc<CR>

" _m move a trailling comment block to the previous line
map _m 0/\s*\/<CR>DO <Esc>hhp$xx0:noh<CR>

" Vertically split open a new window
map _n :vsp<CR><C-W><C-N><C-W>j:q<CR>

" _u/U - lower or uppercase a 'word'
map _u vawu<Esc>
map _U vawU<Esc>

" _T - 'tail' the file
map _T :e<CR>G:sleep 2<CR>_T

" ,i - change the case sensitive search setting
map ,i :set ic!<CR>:set ic?<CR>

" ,v - Vertically split open the tag
map ,v <C-W><C-V><C-]>

" Clean everything up
noremap <C-L> :noh<CR><C-L>

" _M - Use the map in a mouse capable console
nmap _M :call SetMouseOnOff()<CR>

" _E - Turn on or off Virtual Editing
nmap _E :call SwitchVirtualEdit()<CR>


" Visual Maps
" X - search for occurances of the visually highlighted text
" <C-F> opens the command window
vmap X y/<C-R>"<CR>

" <C-X> - search for next occurance of the visually highlighted text - bounded
" by word boundaries
vmap <C-X> y/\<<C-R>"\><CR>
" Just a supplement to o and O in visual mode allowing you instantly switch to
" the other side of the same side of the column
vmap <C-O> oO

" Insertion Maps
" Insertion mode completion on tags
inoremap <C-]> <C-X><C-]>
inoremap <C-F> <C-X><C-F>

" Omni completion
imap <C-O> <C-X><C-O>

" Add to the search pattern
map <F5> /<Up>\\|<C-R><C-W><CR>
map <F6> /<Up>\\|\<<C-R><C-W>\><CR>
map <S-F5> ?<Up>\\|<C-R><C-W><CR>
map <S-F6> ?<Up>\\|\<<C-R><C-W>\><CR>

" Command Line Maps
cnoremap <C-Tab> <C-L><C-D>
cnoremap <Tab> <C-L><C-D>

" Assist in command mode naviation
cnoremap <C-B> <S-Left>

if ($HOSTTYPE == "intel-mac")
  hi CursorLine ctermbg=lightyellow cterm=bold
endif


" --------------------------------------------------------------------------- "
"  Functions

function! WriteBackupFile()
  try
    let fullfilename = bufname("%")
    if (isdirectory(fullfilename))
      return
    endif
    let filename = substitute(fullfilename, "^.*\/", "", "")
    let listit = filename . "*"
    let filelist = globpath("~/.vimbackupdir", listit)
    let num = 0
    let num2 = 0
    for f in split(filelist)
      let num2 = substitute(f, "^.*" . filename . "\\(\\d\\+\\)$", "\\1", "")
      if (match(num2, "^\\d\\+$") == 0)
        if (eval(num2) > eval(num))
          let num = num2
        endif
      endif
    endfor
    let num = num + 1
    let fl = readfile(fullfilename, "b")
    let name = "~/.vimbackupdir/" . filename . num
    call writefile(fl, expand(name), "b")
  catch /.*/
  endtry
endfunction

" Checks to see if the current window is the only window in the current column.
function! IsOnlyWindowInColumn()
  let s:n = winnr()
  :wincmd j
  if s:n != winnr()
    :wincmd k
    return 0
  endif
  :wincmd k
  if s:n != winnr()
    :wincmd j
    return 0
  endif
  return 1
endfunction

" Sets the current window to be the only window in the current column
function! OnlyInColumn()
  if IsOnlyWindowInColumn()
    return
  endif
  :1wincmd x
  :99wincmd k
  try
    while !IsOnlyWindowInColumn()
      :wincmd j
      :close
      :wincmd k
    endwhile
  catch /.*/
  endtry
endfunction

" Turns the mouse on or off
function! SetMouseOnOff()
  if &mouse != 'a'
    set mouse=a
  else
    set mouse=
  endif
  set mouse?
endfunction

" Turns Virtual Edito on orff
function! SwitchVirtualEdit()
  if &virtualedit != 'all'
    set virtualedit=all
  else
    if (version > 700)
      set virtualedit=block,insert
    else
      set virtualedit=
    endif
  endif
  set virtualedit?
endfunction

" Sets the indentation/carriage return style for the current java file
function! SetJavaStyle()
  set et
  if (version >= 600)
    lcd %:p:h

    "set cino+=(0 fo+=ro
    set fo+=ro

    if (version >601)
      try
        call FindAndSetIndent()
      catch /.*/
        set ts=4 sw=4
      endtry
    else
      call FindAndSetIndent()
    endif
  else
    set cin ts=2 sw=2 cino=j1 fo=cqlro
  endif
endfunction

function! SetXmlStyle()
  set noet
  if (version > 600)
    if (version >601)
      try
        call FindAndSetXmlIndent()
      catch /.*/
        set ts=4 sw=4
      endtry
    else
      call FindAndSetXmlIndent()
    endif
  else
    set ts=4 sw=4
  endif
endfunction

function! SetJavascriptStyle()
  set et
  if (version >= 600)
    lcd %:p:h

    "set cino+=(0 fo+=ro
    set fo+=ro

    if (version > 601)
      try
        call FindAndSetJavascriptIndent()
      catch /.*/
        set ts=4 sw=4
      endtry
    else
      call FindAndSetJavascriptIndent()
    endif
  else
    set cin ts=2 sw=2
  endif
endfunction

function! FindAndSetJavascriptIndent()
  let startline = line(".")
  let startcursor = col(".")
  exe "normal H"
  let highline = line(".")
  exe "normal gg"
  /^ \+\(var\|for\|if\|this\|while\|function\)
  let myindent = indent(".")
  let mybufnr = winbufnr(winnr())
  call setbufvar(mybufnr, "&ts", myindent)
  call setbufvar(mybufnr, "&sw", myindent)
  "exe "normal /" . <Up><up>
  call histdel("search", -1)
  let @/ = histget("search", -1)
  exe "normal " . highline . "ggzt"
  exe "normal " . startline . "gg" . startcursor . "|"
endfunction

function! FindAndSetIndent()
  let startline = line(".")
  let startcursor = col(".")
  exe "normal H"
  let highline = line(".")
  exe "normal gg"

  " Don't worry about lesser versions for now...
  let error_caught=0

  try
    /^ \+\(public\|private\|protected\|void\s\+[^(]\+(\)
    " ))) - just to clear up the bad syntax
    " testing color
  catch /E486/
    let error_caught=1
    set et ts=4 sw=4
  endtry

  if (!error_caught)
    let myindent = indent(".")
    let mybufnr = winbufnr(winnr())
    call setbufvar(mybufnr, "&ts", myindent)
    call setbufvar(mybufnr, "&sw", myindent)
  endif

  call histdel("search", -1)
  let @/ = histget("search", -1)
  exe "normal " . highline . "ggzt"
  call cursor(startline, startcursor)
endfunction

function! FindAndSetXmlIndent()
  let startline = line(".")
  let startcursor = col(".")
  exe "normal H"
  let highline = line(".")

  /^ \+<
  let myindent = indent(".")
  let mybufnr = winbufnr(winnr())
  call setbufvar(mybufnr, "&ts", myindent)
  call setbufvar(mybufnr, "&sw", myindent)
  "exe "normal /" . <Up><Up>
  exe "normal gg"

  call histdel("search", -1)
  let @/ = histget("search", -1)
  exe "normal " . highline . "ggzt"
  exe "normal " . startline . "gg" . startcursor . "|"
endfunction

function! SetJavaErrorStyle()
  set et
  if (version >= 600)
    if (version > 601)
      try
        lcd %:p:h
      catch /.*/
      endtry
    endif

    set ts=2 sw=2 cino+=(0 fo+=ro
    " %A   - start of multiline message
    " %f   - filename
    " :    - matches the colon
    " %l   - line number
    " l:   - matches the colon
    " '\ ' - matches a space
    " %m   - the actual error message
    " %C   - continuation of multiline message
    " symbol - matches symbol
    " %m   - match the following character
    " %-Z  - do not include this end of a multiline message
    " %p   - pointer line (detailing where line occurs)
    " ^    - follows the pointer line
    " %-C  - do not include any such continuation of multiline error
    " %.% - starting with white space
    " the comma is used to seperate line matches
    setlocal efm=%A%f:%l:\ %m,%Csymbol%m,%-Z%p^,%-C%.%#
  else
    set cin ts=2 sw=2 cino=j1,(0 fo=cqlro
  endif
endfunction

" Saves the current version of the file in my '~/.vimbackupdir' directory.
function! SaveVersion()
  if (b:changedtick != 0)
    let my_chanedtick = b:changedtick
  endif
endfunction

" Reformat the code under the cursor, with a visual highlight, this function
" will be repeated for all the highlighted lines.
function! ReFormat()
  set fo=tcq
  exe "normal Ji\<CR>\<Esc>"
endfunction

" Reformat the currently highlighted code - with current tab settings
map _r :call Reformat()<CR>

" --------------------------------------------------------------------------- "
" Commands
com! Bcd cd %:p:h
com! Blcd lcd %:p:h

" Conly - Make the current window the only window in the current column.
com! Conly :call OnlyInColumn()

" Write the only file - useful during vimdiff
com! Wo normal <C-W><C-W>:w!<CR>
cab wo Wo

com! Eall windo e!

com! Cgekml make -f Z:\jad292\workspace\gekml\build.xml clean all
com! Clionfeed make -f Z:\jad292\workspace\LIONFEED\build.xml clean all
com! Gekml make -f Z:\jad292\workspace\gekml\build.xml jspc dist
com! AGekml make -f Z:\jad292\workspace\gekml\build.xml all
com! Lionfeed make -f Z:\jad292\workspace\LIONFEED\build.xml all
"cab gekml Gekml
cab lionfeed Lionfeed
cab cgekml Cgekml
cab clionfeed Clionfeed


" --------------------------------------------------------------------------- "
" Highlights
"if (strlen($DISPLAY) == 0)
"  colorscheme shine
"  highlight CursorLine cterm=reverse
"endif

" Special highlights - useful for editing log files - may need to change the
" highlight types...
highlight link F2  Comment
highlight link F3  Statement
highlight link F4  DiffChange
highlight link F9  Type
highlight link F10 Special
highlight link F11 DiffAdd
highlight link F12 DiffDelete

" The following maps allow you to dynamically add your own coloring in files
" (particularly useful in log files). Hit one of the function keys to give a
" word a color.  Use <F7>  to clear the settings.
map <F2>  :syn match F2 "\<<C-R><C-W>\>" "<BS><CR>
map <F3>  :syn match F3 "\<<C-R><C-W>\>" "<BS><CR>
map <F4>  :syn match F4 "\<<C-R><C-W>\>" "<BS><CR>
map <F9>  :syn match F9 "\<<C-R><C-W>\>" "<BS><CR>
map <F10> :syn match F10 "\<<C-R><C-W>\>" "<BS><CR>
map <F11> :syn match F11 "\<<C-R><C-W>\>" "<BS><CR>
map <F12> :syn match F12 "\<<C-R><C-W>\>" "<BS><CR>
" Also make this possible visually
vmap <F2>  y:<C-W>:syn match F2 "<C-R>""<CR>
vmap <F3>  y:<C-W>:syn match F3 "<C-R>""<CR>
vmap <F4>  y:<C-W>:syn match F4 "<C-R>""<CR>
vmap <F10> y:<C-W>:syn match F10 "<C-R>""<CR>
vmap <F11> y:<C-W>:syn match F11 "<C-R>""<CR>
vmap <F12> y:<C-W>:syn match F12 "<C-R>""<CR>

" map <F7> :syntax clear F2 F3 F4 F5 F9 F10 F11 F12<CR>:syntax on<CR>
map <F7> :syntax clear F2 F3 F4 F9 F10 F11 F12<CR>:noh<CR>

" Vim hints
" foo\(baar\)\@! - any "foo" not followed by "bar"
" foo\(bar\)\@= - "foo" in "foobar"
" \(foo\)\@<!bar - any "bar" that's not in "foobar"
" \(foo\)\@<=bar - any "bar" that's preceded by foo
"
" a.\{-}p\@! - "a", "ap", "app", etc. not followed by a "p"
" \(an\_s\+\)\@<=file - "file" after "an" and white space or an end-of-line
" /\(^.\{79\}\)\@<=.*$ - match from the 80th character to the end of the line
" \(\/\/.*\)\@\<!in - "in" which is not after "//"
"
" :s/\w\+/\u\0/g        modifies "bla bla"  to "Bla Bla"
" Using /l in a regex also matches a lower case character

