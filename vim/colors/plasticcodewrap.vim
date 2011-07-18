" vim/colors/test.vim: a new colorscheme by cehoffman
" Written By: Charles E. Campbell, Jr.'s ftplugin/hicolors.vim
" Date: Wed Aug  4 17:52:34 2010

" ---------------------------------------------------------------------
" Standard Initialization:
set bg=dark
hi clear
if exists( "syntax_on")
 syntax reset
endif
let colors_name = 'plasticcodewrap'

" ---------------------------------------------------------------------
" Highlighting Commands:
hi SpecialKey                   term=bold                                        ctermfg=59  ctermbg=16                            guifg=#485056   guibg=#081015
hi NonText                      term=bold                                        ctermfg=238 ctermbg=16                            guifg=#485056   guibg=bg
hi Directory                    term=bold                                        ctermfg=204 ctermbg=16                            guifg=#ff3a83   guibg=bg
hi ErrorMsg                                                                      ctermfg=231 ctermbg=124                           guifg=#f8f8f8   guibg=#a32411
hi IncSearch                                                                     ctermfg=88  ctermbg=254                           guifg=#efe900   guibg=#000000
hi Search                                           cterm=underline,bold,italic, ctermfg=254 ctermbg=88  gui=underline,bold,italic guifg=#efe900   guibg=bg
hi MoreMsg                      term=bold           cterm=bold                   ctermfg=29  ctermbg=16  gui=bold                  guifg=#2e8b57   guibg=bg
hi ModeMsg                      term=bold           cterm=bold                   ctermfg=231 ctermbg=16  gui=bold                  guifg=fg        guibg=bg
hi LineNr                                                                        ctermfg=238 ctermbg=16                            guifg=#82878b   guibg=bg
hi Question                                         cterm=bold                   ctermfg=39  ctermbg=16  gui=bold                  guifg=#00ff00   guibg=bg
hi StatusLine                                       cterm=bold                   ctermfg=230 ctermbg=236                           guifg=#303030   guibg=#ffffd7
hi StatusLineNC                                     cterm=bold                   ctermfg=181 ctermbg=236                           guifg=#303030   guibg=#d7afaf
hi VertSplit                                                                     ctermfg=236 ctermbg=236                           guifg=#303030   guibg=#303030
hi Title                        term=bold           cterm=bold                   ctermfg=231 ctermbg=16  gui=bold                  guifg=#f8f8f8   guibg=bg
hi Visual                       term=reverse                                                 ctermbg=17                                            guibg=#00005f
hi VisualNOS                    term=bold,underline cterm=bold,underline         ctermfg=231 ctermbg=16  gui=bold,underline        guifg=fg        guibg=bg
hi WarningMsg                                                                    ctermfg=124 ctermbg=232                           guifg=#f8f8f8   guibg=#a32411
hi WildMenu                                                                      ctermfg=16  ctermbg=226                           guifg=#000000   guibg=#ffff00
hi Folded                                                                        ctermfg=32  ctermbg=16                            guifg=#1e9ae0   guibg=#0b161d
hi FoldColumn                                                                    ctermfg=238 ctermbg=16                            guifg=#00ffff   guibg=#bebebe

" Diff mode links
hi DiffAdd                                                                       ctermfg=231 ctermbg=22                            guifg=fg        guibg=#004400
hi DiffChange                                                                    ctermfg=231 ctermbg=130 gui=NONE                  guifg=bg        guibg=#d8dc42
hi DiffDelete                                       cterm=bold                   ctermfg=254 ctermbg=88  gui=NONE                  guifg=fg        guibg=#660000
hi DiffText                                         cterm=bold                   ctermfg=231 ctermbg=232 gui=NONE                                  guibg=#660000

" SvnDiff plugin
hi svnDiffAdd                                                                    ctermfg=22  ctermbg=22                            guifg=#004400   guibg=#004400
hi svnDiffChange                                                                 ctermfg=184 ctermbg=184                           guifg=#d8dc42   guibg=#d8dc42
hi svnDiffDelete                                                                 ctermfg=88  ctermbg=88                            guifg=#660000   guibg=#660000

" Diff syntax links
hi diffAdded                                                                     ctermfg=40  ctermbg=16                            guifg=#00cc00
hi diffRemoved                                                                   ctermfg=196 ctermbg=16                            guifg=#ee0000
hi diffNewFile                                                                   ctermfg=240 ctermbg=16                            guifg=#ee0000
hi diffFile                                                                      ctermfg=240 ctermbg=16                            guifg=#00cc00
hi diffLine                                                                      ctermfg=240 ctermbg=16                            guifg=#585858

hi Conceal                                                                       ctermfg=214 ctermbg=16                           guifg=#ffaa00 guibg=#000000

hi CSVColumnEven                                    cterm=none                   ctermfg=231 ctermbg=16  gui=none                 guifg=#e0e0e0 guibg=#000000
hi CSVColumnHeaderEven                              cterm=underline,bold         ctermfg=214 ctermbg=16  gui=underline,bold       guifg=#ffaa00 guibg=#000000
hi CSVColumnOdd                                     cterm=none                   ctermfg=231 ctermbg=16  gui=none                 guifg=#e0e0e0 guibg=#000000
hi CSVColumnHeaderOdd                               cterm=underline,bold         ctermfg=214 ctermbg=16  gui=underline,bold       guifg=#ffaa00 guibg=#000000
hi CSVHiColumn                                      cterm=none                   ctermfg=220 ctermbg=16  gui=none                 guifg=#ffd700 guibg=#000000
hi CSVHiColumnHeader                                cterm=underline,bold         ctermfg=214 ctermbg=16  gui=underline,bold       guifg=#ffaa00 guibg=#000000

" When correcting spellings
hi SpellBad                     term=reverse        cterm=undercurl              ctermfg=196 ctermbg=16  gui=undercurl
hi SpellCap                     term=reverse        cterm=undercurl              ctermfg=21  ctermbg=16  gui=undercurl
hi SpellRare                    term=reverse        cterm=undercurl              ctermfg=201 ctermbg=16  gui=undercurl
hi SpellLocal                   term=underline      cterm=undercurl              ctermfg=51  ctermbg=16  gui=undercurl

" Popup autocompletion menu
hi Pmenu                                                                         ctermfg=236 ctermbg=230                           guifg=#efe900   guibg=#0b161d
hi PmenuSel                                         cterm=bold                   ctermfg=231 ctermbg=66                            guifg=#efe900   guibg=#2b5670
hi PmenuSbar                                                                     ctermfg=241 ctermbg=158                                           guibg=#666666
hi PmenuThumb                                       cterm=reverse                ctermfg=231 ctermbg=16  gui=reverse               guifg=fg        guibg=bg

" Tab bar in console
hi TabLine                      term=underline      cterm=underline              ctermfg=249 ctermbg=16  gui=underline             guifg=fg        guibg=#a9a9a9
hi TabLineSel                   term=bold           cterm=bold,underline         ctermfg=226 ctermbg=16  gui=bold                  guifg=fg        guibg=bg
hi TabLineFill                  term=reverse        cterm=underline              ctermfg=249 ctermbg=16  gui=reverse               guifg=fg        guibg=bg

hi SignColumn                                                                    ctermfg=238 ctermbg=16                            guifg=#82878b   guibg=bg
hi ColorColumn                  term=reverse                                                 ctermbg=232                                           guibg=#0f0f0f
hi CursorColumn                 term=reverse                                     ctermfg=231 ctermbg=234                           guifg=fg        guibg=#081015
hi CursorLine                   term=underline      cterm=NONE                               ctermbg=234                                           guibg=#1c1c1c
hi Cursor                                                                        ctermfg=231 ctermbg=109                           guifg=fg        guibg=#8ba7a7
hi lCursor                                                                       ctermfg=16  ctermbg=231                           guifg=#0b161d   guibg=#f8f8f8
hi MatchParen                   term=reverse        cterm=bold                   ctermfg=214 ctermbg=16  gui=bold                  guifg=#ffaa00   guibg=bg
hi Comment                      term=bold                                        ctermfg=32  ctermbg=16  gui=italic                guifg=#1e9ae0   guibg=bg
hi Constant                     term=underline                                   ctermfg=204 ctermbg=16                            guifg=#ff3a83   guibg=bg
hi Special                                                                       ctermfg=161 ctermbg=16                            guifg=#d7005f   guibg=bg
hi Identifier                                                                    ctermfg=84  ctermbg=16                            guifg=#f6f080   guibg=bg
hi Statement                    term=bold           cterm=bold                   ctermfg=214 ctermbg=16  gui=NONE                  guifg=#ffaa00   guibg=bg
hi PreProc                      term=underline      cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi Type                         term=underline      cterm=bold                   ctermfg=220 ctermbg=16                            guifg=#efe900   guibg=bg
hi Underlined                   term=underline      cterm=underline              ctermfg=231 ctermbg=16                                            guibg=#1c1c1c
hi Ignore                                                                        ctermfg=16  ctermbg=16                            guifg=#0b161d   guibg=bg
hi Error                        term=reverse                                     ctermfg=231 ctermbg=196                           guifg=#ffffff   guibg=#ff0000
hi Todo                                             cterm=bold                   ctermfg=220 ctermbg=16  gui=bold,italic           guifg=#ffd700   guibg=bg
hi String                                                                        ctermfg=77  ctermbg=16                            guifg=#4dcc33
hi Character                                                                     ctermfg=204 ctermbg=16                            guifg=#ff3a83
hi Number                                                                        ctermfg=204 ctermbg=16                            guifg=#ff3a83
hi Boolean                                                                       ctermfg=204 ctermbg=16                            guifg=#ff3a83
hi Float                                                                         ctermfg=204 ctermbg=16                            guifg=#ff3a83
hi Function                                         cterm=bold                   ctermfg=220 ctermbg=16                            guifg=#efe900   guibg=bg
hi Conditional                                      cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi Label                                                                         ctermfg=77  ctermbg=16                            guifg=#55e439   guibg=bg
hi Operator                                         cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi Keyword                                          cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi Define                                           cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi StorageClass                                                                  ctermfg=228 ctermbg=16                            guifg=#f6f080   guibg=bg
hi Tag                                              cterm=bold                   ctermfg=220 ctermbg=16                            guifg=#efe900   guibg=bg
hi Normal                                                                        ctermfg=231 ctermbg=16                            guifg=#e0e0e0   guibg=#000000

" Ruby
hi rubyRegexp                                                                    ctermfg=215 ctermbg=16                            guifg=#ffb454   guibg=bg
hi rubyRegexpDelimiter                                                           ctermfg=215 ctermbg=16                            guifg=#ffb454   guibg=bg
hi rubyControl                                      cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi rubyException                                    cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi rubyClass                                        cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi rubyPseudoVariable                                                            ctermfg=209 ctermbg=16                            guifg=#fb9a4b   guibg=bg
hi rubyOperator                                     cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi rubyConstant                                                                  ctermfg=157 ctermbg=16                            guifg=#9df39f   guibg=bg
hi rubyInstanceVariable                                                          ctermfg=45  ctermbg=16                            guifg=#00bfff   guibg=bg
hi rubyClassVariable                                                             ctermfg=209 ctermbg=16                            guifg=#fb9a4b   guibg=bg
hi rubySymbol                                                                    ctermfg=204 ctermbg=16                            guifg=#ff3a83   guibg=bg
hi rubyEscape                                                                    ctermfg=204 ctermbg=16                            guifg=#ff3a83   guibg=bg
hi rubyInterpolation                                                             ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi rubyFunction                                     cterm=bold                   ctermfg=220 ctermbg=16                            guifg=#efe900   guibg=bg
hi rubyInterpolationDelimiter                                                    ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi rubyStringDelimiter                                                           ctermfg=77  ctermbg=16                            guifg=#55e439   guibg=bg
hi rubyBlockParameter                                                            ctermfg=209 ctermbg=16                            guifg=#fb9a4b   guibg=bg
hi rubyInclude                                      cterm=bold                   ctermfg=214 ctermbg=16                            guifg=#ffaa00   guibg=bg
hi rubyGlobalVariable                                                            ctermfg=209 ctermbg=16                            guifg=#fb9a4b   guibg=bg
hi rubyTestMethod                                                                ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg
hi erubyDelimiter                                                                ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi erubyComment                                                                  ctermfg=32  ctermbg=16  gui=italic                guifg=#1e9ae0   guibg=bg

" Ruby on Rails
hi rubyRailsMethod                                                               ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg
hi rubyRailsUserClass                                                            ctermfg=157 ctermbg=16                            guifg=#9df39f   guibg=bg
hi rubyRailsRenderMethod                                                         ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg
hi rubyRailsARAssociationMethod                                                  ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg
hi rubyRailsARMethod                                                             ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg
hi erubyRailsMethod                                                              ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg

" NetRW file browser
hi netrwTreeBarSpace                                                             ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwSlash                                                                    ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwCopyTgt                                                                  ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwPlain                                                                    ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwSpecial                                                                  ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwTime                                                                     ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwSizeDate                                                                 ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwQuickHelp                                                                ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwSortBy                                                                   ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi netrwSortSeq                                                                  ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg

" HTML
hi htmlTag                                                                       ctermfg=159 ctermbg=16                            guifg=#afffff   guibg=bg
hi htmlEndTag                                                                    ctermfg=159 ctermbg=16                            guifg=#9effff   guibg=bg
hi htmlTagName                                                                   ctermfg=159 ctermbg=16                            guifg=#9effff   guibg=bg
hi htmlArg                                                                       ctermfg=159 ctermbg=16                            guifg=#9effff   guibg=bg
hi htmlSpecialChar                                                               ctermfg=204 ctermbg=16                            guifg=#ff3a83   guibg=bg
hi htmlItalic                                                                                            gui=italic
hi htmlBold                                                                                              gui=bold
hi htmlBoldItalic                                                                                        gui=italic,bold

" XML
hi xmlTagName                                                                    ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi xmlTag                                                                        ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi xmlEndTag                                                                     ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg

" Javascript
hi javaScriptRailsFunction                                                       ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg
hi javaScriptBraces                                                              ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi javaScriptFunction                                                            ctermfg=228 ctermbg=16                            guifg=#f6f080   guibg=bg

" YAML
hi yamlKey                                          cterm=bold                   ctermfg=220 ctermbg=16                            guifg=#efe900   guibg=bg
hi yamlAnchor                                                                    ctermfg=209 ctermbg=16                            guifg=#fb9a4b   guibg=bg
hi yamlAlias                                                                     ctermfg=209 ctermbg=16                            guifg=#fb9a4b   guibg=bg
hi yamlDocumentHeader                                                            ctermfg=77  ctermbg=16                            guifg=#55e439   guibg=bg

" CSS
hi cssClassName                                     cterm=bold                   ctermfg=220 ctermbg=16                            guifg=#efe900   guibg=bg
hi cssBraces                                                                     ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi cssCommonAttr                                                                 ctermfg=174 ctermbg=16                            guifg=#eb939a   guibg=bg
hi cssURL                                                                        ctermfg=209 ctermbg=16                            guifg=#fb9a4b   guibg=bg
hi cssFunctionName                                                               ctermfg=160 ctermbg=16                            guifg=#d40c00   guibg=bg
hi cssColor                                                                      ctermfg=204 ctermbg=16                            guifg=#ff3a83   guibg=bg
hi cssPseudoClassId                                 cterm=bold                   ctermfg=220 ctermbg=16                            guifg=#efe900   guibg=bg
hi netrwCmdNote                                                                  ctermfg=231 ctermbg=16                            guifg=fg        guibg=bg
hi cssValueLength                                                                ctermfg=204 ctermbg=16                            guifg=#ff3a83   guibg=bg

hi hi                                                                            ctermfg=105 ctermbg=68
hi gitconfig                                                                     ctermfg=24  ctermbg=24
hi vim                                                                                       ctermbg=236

" EasyMotion settings for when resourcing file
hi EasyMotionTarget                                                                                                                guifg=#ff0000
hi EasyMotionShade                                                                                                                 guifg=#303030

" ruby << RUBY
"   his = {:name => [], :term => [], :cterm => [], :ctermfg => [], :ctermbg => [], :gui => [], :guifg => [], :guibg => []}
"   maxes = {}
"   linenr = []
"   lines = VIM::Buffer.current.length.times.each do |x|
"     line = VIM::Buffer.current[x + 1]
"     if line =~ /^hi (?!clear)/
"       linenr << x + 1
"       line = line.split

"       his[:name] << line[1]
"       his[:term] << (line.detect { |l| l =~ /^term=/ } || '')
"       his[:cterm] << (line.detect { |l| l =~ /^cterm=/ } || '')
"       his[:ctermfg] << (line.detect { |l| l =~ /^ctermfg=/ } || '')
"       his[:ctermbg] << (line.detect { |l| l =~ /^ctermbg=/ } || '')
"       his[:gui] << (line.detect { |l| l =~ /^gui=/ } || '')
"       his[:guifg] << (line.detect { |l| l =~ /^guifg=/ } || '')
"       his[:guibg] << (line.detect { |l| l =~ /^guibg=/ } || '')
"     end
"   end

"   his.each do |k, v|
"     maxes[k] = his[k].map { |item| item.size }.max
"   end

"   his[:name].length.times do |x|
"     VIM::Buffer.current[linenr[x]] = ['hi', his[:name][x].ljust(maxes[:name]), his[:term][x].ljust(maxes[:term]), his[:cterm][x].ljust(maxes[:cterm]),
"     his[:ctermfg][x].ljust(maxes[:ctermfg]), his[:ctermbg][x].ljust(maxes[:ctermbg]), his[:gui][x].ljust(maxes[:gui]),
"     his[:guifg][x].ljust(maxes[:guifg]), his[:guibg][x].ljust(maxes[:guibg])].join(' ').strip
"   end
" RUBY
