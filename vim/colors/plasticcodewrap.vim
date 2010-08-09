" vim/colors/test.vim: a new colorscheme by cehoffman
" Written By: Charles E. Campbell, Jr.'s ftplugin/hicolors.vim
" Date: Wed Aug  4 17:52:34 2010

" ---------------------------------------------------------------------
" Standard Initialization:
set bg=light
hi clear
if exists( "syntax_on")
 syntax reset
endif
let g:colors_name="vim/colors/test"

" ---------------------------------------------------------------------
" Highlighting Commands:
hi SpecialKey                   term=bold           ctermfg=59           ctermbg=16      guifg=#485056   guibg=#081015
hi NonText                      term=bold           ctermfg=238          ctermbg=16      guifg=#485056   guibg=#081015
hi Directory                    term=bold           ctermfg=204          ctermbg=16      guifg=#ff3a83   guibg=bg
hi ErrorMsg                     ctermfg=231         ctermbg=124          guifg=#f8f8f8   guibg=#a32411
hi IncSearch                    cterm=NONE          ctermfg=195          ctermbg=235     guifg=fg        guibg=#5a422c
hi Search                       cterm=NONE          ctermfg=231          ctermbg=236     guifg=fg        guibg=#5a422c
hi MoreMsg                      term=bold           cterm=bold           ctermfg=29      ctermbg=16      gui=bold           guifg=#2e8b57 guibg=bg
hi ModeMsg                      term=bold           cterm=bold           ctermfg=231     ctermbg=16      gui=bold           guifg=fg      guibg=bg
hi LineNr                       ctermfg=238         ctermbg=16           guifg=#82878b   guibg=#0b161d
hi Question                     cterm=bold          ctermfg=39           ctermbg=16      gui=bold        guifg=#00ff00      guibg=bg
hi StatusLine                   cterm=bold          ctermfg=230          ctermbg=236     gui=bold        guifg=#f8f8f8      guibg=#384147
hi StatusLineNC                 cterm=bold          ctermfg=181          ctermbg=236     guifg=#f8f8f8   guibg=#384147
hi VertSplit                    ctermfg=236         ctermbg=236          guifg=#384147   guibg=#384147
hi Title                        term=bold           cterm=bold           ctermfg=231     ctermbg=16      gui=bold           guifg=#f8f8f8 guibg=bg
hi Visual                       term=reverse        ctermfg=231          ctermbg=66      guifg=fg        guibg=#687b83
hi VisualNOS                    term=bold,underline cterm=bold,underline ctermfg=231     ctermbg=16      gui=bold,underline guifg=fg      guibg=bg
hi WarningMsg                   ctermfg=124         ctermbg=232          guifg=#f8f8f8   guibg=#a32411
hi WildMenu                     ctermfg=16          ctermbg=226          guifg=#000000   guibg=#ffff00
hi Folded                       ctermfg=32          ctermbg=16           guifg=#1e9ae0   guibg=#0b161d
hi FoldColumn                   ctermfg=51          ctermbg=250          guifg=#00ffff   guibg=#bebebe
hi DiffAdd                      ctermfg=231         ctermbg=22           guifg=fg        guibg=#00008b
hi DiffChange                   ctermfg=231         ctermbg=130          guifg=fg        guibg=#8b008b
hi DiffDelete                   cterm=bold          ctermfg=254          ctermbg=88      gui=bold        guifg=#0000ff      guibg=#008b8b
hi DiffText                     cterm=bold          ctermfg=231          ctermbg=232     gui=bold        guifg=fg           guibg=#ff0000
hi SignColumn                   ctermfg=51          ctermbg=250          guifg=#00ffff   guibg=#bebebe
hi Conceal                      ctermfg=7           ctermbg=242          guifg=LightGrey guibg=DarkGrey
hi SpellBad                     term=reverse        cterm=undercurl      ctermfg=196     ctermbg=16      gui=undercurl      guifg=fg      guibg=bg      guisp=#ff0000
hi SpellCap                     term=reverse        cterm=undercurl      ctermfg=21      ctermbg=16      gui=undercurl      guifg=fg      guibg=bg      guisp=#0000ff
hi SpellRare                    term=reverse        cterm=undercurl      ctermfg=201     ctermbg=16      gui=undercurl      guifg=fg      guibg=bg      guisp=#ff00ff
hi SpellLocal                   term=underline      cterm=undercurl      ctermfg=51      ctermbg=16      gui=undercurl      guifg=fg      guibg=bg      guisp=#00ffff
hi Pmenu                        ctermfg=236         ctermbg=230          guifg=#efe900   guibg=bg
hi PmenuSel                     cterm=bold          ctermfg=231          ctermbg=66      guifg=fg        guibg=#687b83
hi PmenuSbar                    ctermfg=241         ctermbg=158          guifg=fg        guibg=#bebebe
hi PmenuThumb                   cterm=reverse       ctermfg=231          ctermbg=16      gui=reverse     guifg=fg           guibg=bg
hi TabLine                      term=underline      cterm=underline      ctermfg=249     ctermbg=16      gui=underline      guifg=fg      guibg=#a9a9a9
hi TabLineSel                   term=bold           cterm=bold,underline ctermfg=226     ctermbg=16      gui=bold           guifg=fg      guibg=bg
hi TabLineFill                  term=reverse        cterm=underline      ctermfg=249     ctermbg=16      gui=reverse        guifg=fg      guibg=bg
hi CursorColumn                 term=reverse        ctermfg=231          ctermbg=234     guifg=fg        guibg=#081015
hi CursorLine                   term=underline      cterm=NONE           ctermbg=234     guibg=#081015
hi ColorColumn                  term=reverse        ctermbg=232          guibg=LightRed
hi MatchParen                   term=reverse        cterm=bold           ctermfg=214     ctermbg=16      gui=bold           guifg=#ffaa00 guibg=bg
hi Comment                      term=bold           ctermfg=32           ctermbg=16      gui=italic      guifg=#1e9ae0      guibg=bg
hi Constant                     term=underline      ctermfg=204          ctermbg=16      guifg=#ff3a83   guibg=bg
hi Special                      term=bold           ctermfg=231          ctermbg=16      guifg=#f8f8f8   guibg=bg
hi Identifier                   ctermfg=84          ctermbg=16           guifg=#f6f080   guibg=bg
hi Statement                    term=bold           cterm=bold           ctermfg=214     ctermbg=16      gui=bold           guifg=#ffaa00 guibg=bg
hi PreProc                      term=underline      cterm=bold           ctermfg=214     ctermbg=16      gui=bold           guifg=#ffaa00 guibg=bg
hi Type                         term=underline      cterm=bold           ctermfg=220     ctermbg=16      gui=bold           guifg=#efe900 guibg=bg
hi Underlined                   term=underline      cterm=underline      ctermfg=231     ctermbg=16      gui=underline      guifg=fg      guibg=bg
hi Ignore                       ctermfg=16          ctermbg=16           guifg=#0b161d   guibg=bg
hi Error                        term=reverse        ctermfg=231          ctermbg=196     guifg=#ffffff   guibg=#ff0000
hi Todo                         cterm=bold          ctermfg=220          ctermbg=16      gui=bold,italic guifg=#1e9ae0      guibg=bg
hi String                       ctermfg=77          ctermbg=16           guifg=#55e439   guibg=bg
hi Character                    ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi Number                       ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi Boolean                      ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi Float                        ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi Function                     cterm=bold          ctermfg=220          ctermbg=16      gui=bold        guifg=#efe900      guibg=bg
hi Conditional                  cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi Label                        ctermfg=77          ctermbg=16           guifg=#55e439   guibg=bg
hi Operator                     cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi Keyword                      cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi Define                       cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi StorageClass                 ctermfg=228         ctermbg=16           guifg=#f6f080   guibg=bg
hi Tag                          cterm=bold          ctermfg=220          ctermbg=16      gui=bold        guifg=#efe900      guibg=bg
hi Normal                       ctermfg=231         ctermbg=16           guifg=#f8f8f8   guibg=#0b161d
hi rubyRegexp                   ctermfg=215         ctermbg=16           guifg=#ffb454   guibg=bg
hi rubyRegexpDelimiter          ctermfg=215         ctermbg=16           guifg=#ffb454   guibg=bg
hi rubyControl                  cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi rubyException                cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi rubyRailsUserClass           ctermfg=157         ctermbg=16           guifg=#9df39f   guibg=bg
hi rubyRailsARAssociationMethod ctermfg=160         ctermbg=16           guifg=#d40c00   guibg=bg
hi rubyRailsARMethod            ctermfg=160         ctermbg=16           guifg=#d40c00   guibg=bg
hi netrwCopyTgt                 ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi rubyRailsMethod              ctermfg=160         ctermbg=16           guifg=#d40c00   guibg=bg
hi erubyDelimiter               ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi netrwPlain                   ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi cssCommonAttr                ctermfg=174         ctermbg=16           guifg=#eb939a   guibg=bg
hi netrwSpecial                 ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi netrwTime                    ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi netrwSizeDate                ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi netrwQuickHelp               ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi cssClassName                 cterm=bold          ctermfg=220          ctermbg=16      gui=bold        guifg=#efe900      guibg=bg
hi cIf0                         ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi rubyConstant                 ctermfg=157         ctermbg=16           guifg=#9df39f   guibg=bg
hi rubyInstanceVariable         ctermfg=45          ctermbg=16           guifg=#fb9a4b   guibg=bg
hi rubyClassVariable            ctermfg=209         ctermbg=16           guifg=#fb9a4b   guibg=bg
hi rubySymbol                   ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi rubyEscape                   ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi rubyInterpolation            ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi cssBraces                    ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi Cursor                       ctermfg=231         ctermbg=109          guifg=fg        guibg=#8ba7a7
hi rubyRailsRenderMethod        ctermfg=160         ctermbg=16           guifg=#d40c00   guibg=bg
hi xmlTagName                   ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi erubyComment                 ctermfg=32          ctermbg=16           gui=italic      guifg=#1e9ae0   guibg=bg
hi erubyRailsMethod             ctermfg=160         ctermbg=16           guifg=#d40c00   guibg=bg
hi htmlTag                      ctermfg=159         ctermbg=16           guifg=#9effff   guibg=bg
hi htmlEndTag                   ctermfg=159         ctermbg=16           guifg=#9effff   guibg=bg
hi htmlTagName                  ctermfg=159         ctermbg=16           guifg=#9effff   guibg=bg
hi htmlArg                      ctermfg=159         ctermbg=16           guifg=#9effff   guibg=bg
hi htmlSpecialChar              ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi netrwTreeBarSpace            ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi javaScriptRailsFunction      ctermfg=160         ctermbg=16           guifg=#d40c00   guibg=bg
hi javaScriptBraces             ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi netrwSlash                   ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi xmlEndTag                    ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi rubyClass                    cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi rubyPseudoVariable           ctermfg=209         ctermbg=16           guifg=#fb9a4b   guibg=bg
hi rubyOperator                 cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi MyTagListFileName            ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi rubyFunction                 cterm=bold          ctermfg=220          ctermbg=16      gui=bold        guifg=#efe900      guibg=bg
hi rubyInterpolationDelimiter   ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi rubyStringDelimiter          ctermfg=77          ctermbg=16           guifg=#55e439   guibg=bg
hi rubyBlockParameter           ctermfg=209         ctermbg=16           guifg=#fb9a4b   guibg=bg
hi rubyInclude                  cterm=bold          ctermfg=214          ctermbg=16      gui=bold        guifg=#ffaa00      guibg=bg
hi rubyGlobalVariable           ctermfg=209         ctermbg=16           guifg=#fb9a4b   guibg=bg
hi netrwSortBy                  ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi netrwSortSeq                 ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi xmlTag                       ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi javaScriptFunction           ctermfg=228         ctermbg=16           guifg=#f6f080   guibg=bg
hi lCursor                      ctermfg=16          ctermbg=231          guifg=#0b161d   guibg=#f8f8f8
hi yamlKey                      cterm=bold          ctermfg=220          ctermbg=16      gui=bold        guifg=#efe900      guibg=bg
hi yamlAnchor                   ctermfg=209         ctermbg=16           guifg=#fb9a4b   guibg=bg
hi yamlAlias                    ctermfg=209         ctermbg=16           guifg=#fb9a4b   guibg=bg
hi yamlDocumentHeader           ctermfg=77          ctermbg=16           guifg=#55e439   guibg=bg
hi cssURL                       ctermfg=209         ctermbg=16           guifg=#fb9a4b   guibg=bg
hi cssFunctionName              ctermfg=160         ctermbg=16           guifg=#d40c00   guibg=bg
hi cssColor                     ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi cssPseudoClassId             cterm=bold          ctermfg=220          ctermbg=16      gui=bold        guifg=#efe900      guibg=bg
hi netrwCmdNote                 ctermfg=231         ctermbg=16           guifg=fg        guibg=bg
hi cssValueLength               ctermfg=204         ctermbg=16           guifg=#ff3a83   guibg=bg
hi hi                           ctermfg=105         ctermbg=68
hi gitconfig                    ctermfg=24          ctermbg=24
hi vim                          ctermbg=236
