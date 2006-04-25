" Vim syntax file
" Language:     FlexWiki, http://www.flexwiki.com/
" Maintainer:   George V. Reilly  <george@reilly.org>
" Home:         http://www.georgevreilly.com/vim/flexwiki/
" Author:       George V. Reilly
" Filenames:    *.wiki
" Last Change: Tue Apr 25 10:00 PM 2006 P
" Version:      0.2

" Note: The horrible regexps were reverse-engineered from
" FlexWikiCore\EngineSource\Formatter.cs, with help from the Regex Analyzer
" in The Regulator, http://regulator.sourceforge.net/  .NET uses Perl-style
" regexes, which use a different syntax than Vim (fewer \s).
" The primary test case is FlexWiki\FormattingRules.wiki

" Quit if syntax file is already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" A WikiWord (unqualifiedWikiName)
syntax match  fwWord          /\%(_\?\([A-Z]\{2,}[a-z0-9]\+[A-Za-z0-9]*\)\|\([A-Z][a-z0-9]\+[A-Za-z0-9]*[A-Z]\+[A-Za-z0-9]*\)\)/
" A [bracketed wiki word]
syntax match  fwWord          /\[[[:alnum:]\s]\+\]/

" text: "this is a link (optional tooltip)":http://www.microsoft.com
" TODO: check URL syntax against RFC
syntax match fwLink           `\("[^"(]\+\((\([^)]\+\))\)\?":\)\?\(https\?\|ftp\|gopher\|telnet\|file\|notes\|ms-help\):\(\(\(//\)\|\(\\\\\)\)\+[A-Za-z0-9:#@%/;$~_?+-=.&\-\\\\]*\)`

" text: *strong* 
syntax match fwBold           /\(^\|\W\)\zs\*\([^ ].\{-}\)\*/
" '''bold'''
syntax match fwBold           /'''\([^'].\{-}\)'''/

" text: _emphasis_
syntax match fwItalic         /\(^\|\W\)\zs_\([^ ].\{-}\)_/
" ''italic''
syntax match fwItalic         /''\([^'].\{-}\)''/

" ``deemphasis``
syntax match fwDeEmphasis     /``\([^`].\{-}\)``/

" text: @code@ 
syntax match fwCode           /\(^\|\s\|(\|\[\)\zs@\([^@]\+\)@/

"   text: -deleted text- 
syntax match fwDelText        /\(^\|\s\+\)\zs-\([^ <a ]\|[^ <img ]\|[^ -].*\)-/

"   text: +inserted text+ 
syntax match fwInsText        /\(^\|\W\)\zs+\([^ ].\{-}\)+/

"   text: ^superscript^ 
syntax match fwSuperScript    /\(^\|\W\)\zs^\([^ ].\{-}\)^/

"   text: ~subscript~ 
syntax match fwSubScript      /\(^\|\W\)\zs\~\([^ ].\{-}\)\~/

"   text: ??citation?? 
syntax match fwCitation       /\(^\|\W\)\zs??\([^ ].\{-}\)??/

" Emoticons: must come after the Textilisms, as later rules take precedence
" over earlier ones. This match is an approximation for the ~70 distinct
" patterns that FlexWiki knows.
syntax match fwEmoticons      /\((.)\|:[()|$@]\|:-[DOPS()\]|$@]\|;)\|:'(\)/

" Aggregate all the regular text highlighting into fwText
syntax cluster fwText contains=fwItalic,fwBold,fwCode,fwDeEmphasis,fwDelText,fwInsText,fwSuperScript,fwSubScript,fwCitation,fwLink,fwWord,fwEmoticons

" single-line WikiPropertys
syntax match fwSingleLineProperty /^:\?[A-Z_][_a-zA-Z0-9]\+:/

" TODO: multi-line WikiPropertys

" Header levels, 1-6
syntax match fwH1             /^!.*$/
syntax match fwH2             /^!!.*$/
syntax match fwH3             /^!!!.*$/
syntax match fwH4             /^!!!!.*$/
syntax match fwH5             /^!!!!!.*$/
syntax match fwH6             /^!!!!!!.*$/

" <hr>, horizontal rule
syntax match fwHR             /^----.*$/

" Formatting can be turned off by ""enclosing it in pairs of double quotes""
syntax match fwEscape         /"".\{-}""/

" Tables. Each line starts and ends with '||'; each cell is separated by '||'
syntax match fwTable          /||/

" Bulleted list items start with one or tabs, followed by whitespace, then '*'
" Numeric  list items start with one or tabs, followed by whitespace, then '1.'
" Eight spaces at the beginning of the line is equivalent to the leading tab.
syntax match fwList           /^\(\t\| \{8}\)\s*\(\*\|1\.\).*$/   contains=@fwText

" Treat all other lines that start with spaces as PRE-formatted text.
syntax match fwPre            /^[ \t]\+[^ \t*1].*$/


" Link FlexWiki syntax items to colors
hi def link fwH1                    Title
hi def link fwH2                    fwH1
hi def link fwH3                    fwH2
hi def link fwH4                    fwH3
hi def link fwH5                    fwH4
hi def link fwH6                    fwH5
hi def link fwHR                    fwH6
    
hi def fwBold                       term=bold cterm=bold gui=bold
hi def fwItalic                     term=italic cterm=italic gui=italic

hi def link fwCode                  Statement
hi def link fwWord                  Underlined

hi def link fwEscape                Todo
hi def link fwPre                   PreProc
hi def link fwLink                  Underlined
hi def link fwList                  Type
hi def link fwTable                 Type
hi def link fwEmoticons             Constant
hi def link fwDelText               Comment
hi def link fwDeEmphasis            Comment
hi def link fwInsText               Constant
hi def link fwSuperScript           Constant
hi def link fwSubScript             Constant
hi def link fwCitation              Constant

hi def link fwSingleLineProperty    Identifier

let b:current_syntax="FlexWiki"

" vim:tw=0:ts=4
