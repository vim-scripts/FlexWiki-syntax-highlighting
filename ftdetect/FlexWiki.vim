" Vim filetype-detect file
" Language:     FlexWiki, http://www.flexwiki.com/
" Maintainer:   George V. Reilly  <george@reilly.org>
" Home:         http://www.georgevreilly.com/vim/flexwiki/
" Author:       George V. Reilly
" Filenames:    *.wiki
" Last Change: Tue Apr 25 10:00 PM 2006 P
" Version:      0.2

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1  " Don't load another plugin for this buffer

augroup filetypedetect
    au! BufRead,BufNewFile *.wiki silent call <SID>FlexWikiNewBuffer()
augroup END
    
function! s:FlexWikiNewBuffer()
    " Associate *.wiki with FlexWiki syntax highlighting
    setlocal filetype=FlexWiki
    " Allow lines of unlimited length. Don't want automatic linebreaks,
    " as they indicate start of a new paragraph in FlexWiki.
    setlocal textwidth=0
    " Wrap long lines, rather than using horizontal scrolling.
    setlocal wrap
    " Wrap at a character in 'breakat' rather than at last char on screen
    setlocal linebreak
    " Don't transform <TAB> characters into spaces
    setlocal noexpandtab
    " 4-char tabstops, per flexwiki.el
    setlocal tabstop=4
    " Save *.wiki files in UTF-8
    setlocal fileencoding=utf-8
    " Add the UTF-8 Byte Order Mark to the beginning of the file
    setlocal bomb
    " Save <EOL>s as \n, not \r\n
    setlocal fileformat=unix

    " Move up and down by display lines, to account for screen wrapping
    " of very long lines
    nmap <buffer> <Up>   gk
    nmap <buffer> k      gk
    vmap <buffer> <Up>   gk
    vmap <buffer> k      gk

    nmap <buffer> <Down> gj
    nmap <buffer> j      gj
    vmap <buffer> <Down> gj
    vmap <buffer> j      gj

    " for earlier versions - for when 'wrap' is set
    imap <buffer> <S-Down>   <C-o>gj
    imap <buffer> <S-Up>     <C-o>gk
    if v:version >= 700
        imap <buffer> <Down>   <C-o>gj
        imap <buffer> <Up>     <C-o>gk
    endif 
endfunction
