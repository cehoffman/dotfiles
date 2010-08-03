" This scheme was created by CSApproxSnapshot
" on Tue, 03 Aug 2010

hi clear
if exists("syntax_on")
    syntax reset
endif

if v:version < 700
    let g:colors_name = expand("<sfile>:t:r")
    command! -nargs=+ CSAHi exe "hi" substitute(substitute(<q-args>, "undercurl", "underline", "g"), "guisp\\S\\+", "", "g")
else
    let g:colors_name = expand("<sfile>:t:r")
    command! -nargs=+ CSAHi exe "hi" <q-args>
endif

function! s:old_kde()
  " Konsole only used its own palette up til KDE 4.2.0
  if executable('kde4-config') && system('kde4-config --kde-version') =~ '^4.[10].'
    return 1
  elseif executable('kde-config') && system('kde-config --version') =~# 'KDE: 3.'
    return 1
  else
    return 0
  endif
endfunction

if 0
elseif has("gui_running") || (&t_Co == 256 && (&term ==# "xterm" || &term =~# "^screen") && exists("g:CSApprox_konsole") && g:CSApprox_konsole) || (&term =~? "^konsole" && s:old_kde())
    CSAHi Normal term=NONE cterm=NONE ctermbg=23 ctermfg=195 gui=NONE guibg=#102235 guifg=#e3f3fa
    CSAHi htmlArg term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi htmlSpecialChar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTreeBarSpace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptRailsFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSlash term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi erubyComment term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyPseudoVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyOperator term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=153 gui=underline guibg=bg guifg=#8ac6f2
    CSAHi Ignore term=NONE cterm=NONE ctermbg=23 ctermfg=60 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Error term=reverse cterm=NONE ctermbg=196 ctermfg=231 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi Todo term=NONE cterm=bold ctermbg=23 ctermfg=157 gui=bold guibg=#102235 guifg=#aded80
    CSAHi String term=NONE cterm=NONE ctermbg=bg ctermfg=149 gui=italic guibg=bg guifg=#89e14b
    CSAHi Number term=NONE cterm=NONE ctermbg=bg ctermfg=153 gui=NONE guibg=bg guifg=#96defa
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=147 gui=NONE guibg=bg guifg=#af81f4
    CSAHi erubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=#00ffff
    CSAHi NonText term=bold cterm=NONE ctermbg=23 ctermfg=60 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=#00ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=196 ctermfg=231 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=bold ctermbg=147 ctermfg=189 gui=bold guibg=#af81f4 guifg=#e2daef
    CSAHi Search term=reverse cterm=NONE ctermbg=147 ctermfg=189 gui=NONE guibg=#af81f4 guifg=#e2daef
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=72 gui=bold guibg=bg guifg=#2e8b57
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi LineNr term=underline cterm=NONE ctermbg=23 ctermfg=60 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi cssValueLength term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyAccess term=NONE cterm=NONE ctermbg=23 ctermfg=210 gui=italic guibg=#102235 guifg=#ef7760
    CSAHi rubyClassVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi hamlId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubySymbol term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCmdNote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyControl term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyException term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsUserClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARAssociationMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCopyTgt term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=60 ctermfg=195 gui=NONE guibg=#1e415e guifg=#dfeff6
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=67 ctermfg=195 gui=NONE guibg=#2d7889 guifg=#dfeff6
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=250 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi TabLine term=underline cterm=NONE ctermbg=253 ctermfg=240 gui=NONE guibg=#dddddd guifg=#555555
    CSAHi TabLineSel term=bold cterm=NONE ctermbg=249 ctermfg=233 gui=NONE guibg=#b0b0b0 guifg=#101010
    CSAHi TabLineFill term=reverse cterm=NONE ctermbg=253 ctermfg=195 gui=NONE guibg=#dddddd guifg=#e3f3fa
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=231 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=24 ctermfg=fg gui=NONE guibg=#18374f guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=109 ctermfg=fg gui=NONE guibg=#55a096 guifg=fg
    CSAHi rubyRegexpDelimiter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi MyTagListFileName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyBlockParameter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInclude term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyGlobalVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortBy term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortSeq term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=153 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi rubyRegexp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=46 gui=bold guibg=bg guifg=#00ff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=17 ctermfg=229 gui=NONE guibg=#0a1721 guifg=#ffec99
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=17 ctermfg=60 gui=NONE guibg=#0a1721 guifg=#233f59
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=17 ctermfg=17 gui=NONE guibg=#0a1721 guifg=#0a1721
    CSAHi Title term=bold cterm=NONE ctermbg=23 ctermfg=210 gui=NONE guibg=#102235 guifg=#ef7760
    CSAHi Visual term=reverse cterm=NONE ctermbg=66 ctermfg=195 gui=NONE guibg=#24557a guifg=#dfeff6
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=196 gui=NONE guibg=bg guifg=#ff0000
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi Folded term=NONE cterm=NONE ctermbg=60 ctermfg=117 gui=NONE guibg=#1a3951 guifg=#68cee8
    CSAHi hamlClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi treeFlag term=NONE cterm=NONE ctermbg=23 ctermfg=67 gui=NONE guibg=#102235 guifg=#3e71a1
    CSAHi rubyEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInterpolation term=NONE cterm=NONE ctermbg=23 ctermfg=187 gui=NONE guibg=#102235 guifg=#b9e19d
    CSAHi cssBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsRenderMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSpecial term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTime term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSizeDate term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwQuickHelp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssClassName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cIf0 term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyConstant term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=195 ctermfg=23 gui=NONE guibg=#e3f3fa guifg=#102235
    CSAHi MatchParen term=reverse cterm=bold ctermbg=23 ctermfg=201 gui=bold guibg=#102235 guifg=#ff00ff
    CSAHi Comment term=bold cterm=NONE ctermbg=23 ctermfg=67 gui=italic guibg=#102235 guifg=#3e71a1
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=153 gui=NONE guibg=bg guifg=#96defa
    CSAHi Special term=bold cterm=NONE ctermbg=bg ctermfg=195 gui=NONE guibg=bg guifg=#dfeff6
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=153 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=117 gui=NONE guibg=bg guifg=#68cee8
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=210 gui=NONE guibg=bg guifg=#ef7760
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=75 gui=NONE guibg=bg guifg=#41b2ea
    CSAHi rubyInstanceVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlKey term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAnchor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAlias term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlDocumentHeader term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssURL term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssFunctionName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssColor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssPseudoClassId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwPlain term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssCommonAttr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=60 ctermfg=60 gui=NONE guibg=#1a3951 guifg=#1e415e
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=19 ctermfg=fg gui=NONE guibg=#00008b guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=127 ctermfg=fg gui=NONE guibg=#8b008b guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=37 ctermfg=21 gui=bold guibg=#008b8b guifg=#0000ff
    CSAHi DiffText term=reverse cterm=bold ctermbg=196 ctermfg=fg gui=bold guibg=#ff0000 guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=196 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=21 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=201 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=51 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
elseif has("gui_running") || (&t_Co == 256 && (&term ==# "xterm" || &term =~# "^screen") && exists("g:CSApprox_eterm") && g:CSApprox_eterm) || &term =~? "^eterm"
    CSAHi Normal term=NONE cterm=NONE ctermbg=23 ctermfg=231 gui=NONE guibg=#102235 guifg=#e3f3fa
    CSAHi htmlArg term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi htmlSpecialChar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTreeBarSpace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptRailsFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSlash term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi erubyComment term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyPseudoVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyOperator term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=159 gui=underline guibg=bg guifg=#8ac6f2
    CSAHi Ignore term=NONE cterm=NONE ctermbg=23 ctermfg=60 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Error term=reverse cterm=NONE ctermbg=196 ctermfg=255 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi Todo term=NONE cterm=bold ctermbg=23 ctermfg=193 gui=bold guibg=#102235 guifg=#aded80
    CSAHi String term=NONE cterm=NONE ctermbg=bg ctermfg=156 gui=italic guibg=bg guifg=#89e14b
    CSAHi Number term=NONE cterm=NONE ctermbg=bg ctermfg=195 gui=NONE guibg=bg guifg=#96defa
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=183 gui=NONE guibg=bg guifg=#af81f4
    CSAHi erubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=#00ffff
    CSAHi NonText term=bold cterm=NONE ctermbg=23 ctermfg=60 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=#00ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=196 ctermfg=255 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=bold ctermbg=183 ctermfg=231 gui=bold guibg=#af81f4 guifg=#e2daef
    CSAHi Search term=reverse cterm=NONE ctermbg=183 ctermfg=231 gui=NONE guibg=#af81f4 guifg=#e2daef
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=72 gui=bold guibg=bg guifg=#2e8b57
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi LineNr term=underline cterm=NONE ctermbg=23 ctermfg=60 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi cssValueLength term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyAccess term=NONE cterm=NONE ctermbg=23 ctermfg=216 gui=italic guibg=#102235 guifg=#ef7760
    CSAHi rubyClassVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi hamlId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubySymbol term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCmdNote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyControl term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyException term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsUserClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARAssociationMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCopyTgt term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=66 ctermfg=231 gui=NONE guibg=#1e415e guifg=#dfeff6
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=73 ctermfg=231 gui=NONE guibg=#2d7889 guifg=#dfeff6
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=250 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi TabLine term=underline cterm=NONE ctermbg=253 ctermfg=102 gui=NONE guibg=#dddddd guifg=#555555
    CSAHi TabLineSel term=bold cterm=NONE ctermbg=249 ctermfg=233 gui=NONE guibg=#b0b0b0 guifg=#101010
    CSAHi TabLineFill term=reverse cterm=NONE ctermbg=253 ctermfg=231 gui=NONE guibg=#dddddd guifg=#e3f3fa
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=255 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=60 ctermfg=fg gui=NONE guibg=#18374f guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=116 ctermfg=fg gui=NONE guibg=#55a096 guifg=fg
    CSAHi rubyRegexpDelimiter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi MyTagListFileName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyBlockParameter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInclude term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyGlobalVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortBy term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortSeq term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=159 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi rubyRegexp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=46 gui=bold guibg=bg guifg=#00ff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=23 ctermfg=230 gui=NONE guibg=#0a1721 guifg=#ffec99
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=23 ctermfg=60 gui=NONE guibg=#0a1721 guifg=#233f59
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=23 ctermfg=23 gui=NONE guibg=#0a1721 guifg=#0a1721
    CSAHi Title term=bold cterm=NONE ctermbg=23 ctermfg=216 gui=NONE guibg=#102235 guifg=#ef7760
    CSAHi Visual term=reverse cterm=NONE ctermbg=67 ctermfg=231 gui=NONE guibg=#24557a guifg=#dfeff6
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=196 gui=NONE guibg=bg guifg=#ff0000
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi Folded term=NONE cterm=NONE ctermbg=60 ctermfg=123 gui=NONE guibg=#1a3951 guifg=#68cee8
    CSAHi hamlClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi treeFlag term=NONE cterm=NONE ctermbg=23 ctermfg=74 gui=NONE guibg=#102235 guifg=#3e71a1
    CSAHi rubyEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInterpolation term=NONE cterm=NONE ctermbg=23 ctermfg=194 gui=NONE guibg=#102235 guifg=#b9e19d
    CSAHi cssBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsRenderMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSpecial term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTime term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSizeDate term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwQuickHelp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssClassName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cIf0 term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyConstant term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=231 ctermfg=23 gui=NONE guibg=#e3f3fa guifg=#102235
    CSAHi MatchParen term=reverse cterm=bold ctermbg=23 ctermfg=201 gui=bold guibg=#102235 guifg=#ff00ff
    CSAHi Comment term=bold cterm=NONE ctermbg=23 ctermfg=74 gui=italic guibg=#102235 guifg=#3e71a1
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=195 gui=NONE guibg=bg guifg=#96defa
    CSAHi Special term=bold cterm=NONE ctermbg=bg ctermfg=231 gui=NONE guibg=bg guifg=#dfeff6
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=159 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=123 gui=NONE guibg=bg guifg=#68cee8
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=216 gui=NONE guibg=bg guifg=#ef7760
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=117 gui=NONE guibg=bg guifg=#41b2ea
    CSAHi rubyInstanceVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlKey term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAnchor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAlias term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlDocumentHeader term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssURL term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssFunctionName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssColor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssPseudoClassId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwPlain term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssCommonAttr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=60 ctermfg=66 gui=NONE guibg=#1a3951 guifg=#1e415e
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=19 ctermfg=fg gui=NONE guibg=#00008b guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=127 ctermfg=fg gui=NONE guibg=#8b008b guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=37 ctermfg=21 gui=bold guibg=#008b8b guifg=#0000ff
    CSAHi DiffText term=reverse cterm=bold ctermbg=196 ctermfg=fg gui=bold guibg=#ff0000 guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=196 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=21 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=201 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=51 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
elseif has("gui_running") || &t_Co == 256
    CSAHi Normal term=NONE cterm=NONE ctermbg=17 ctermfg=195 gui=NONE guibg=#102235 guifg=#e3f3fa
    CSAHi htmlArg term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi htmlSpecialChar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTreeBarSpace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptRailsFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSlash term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi erubyComment term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyPseudoVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyOperator term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=117 gui=underline guibg=bg guifg=#8ac6f2
    CSAHi Ignore term=NONE cterm=NONE ctermbg=17 ctermfg=23 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Error term=reverse cterm=NONE ctermbg=196 ctermfg=231 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi Todo term=NONE cterm=bold ctermbg=17 ctermfg=156 gui=bold guibg=#102235 guifg=#aded80
    CSAHi String term=NONE cterm=NONE ctermbg=bg ctermfg=113 gui=italic guibg=bg guifg=#89e14b
    CSAHi Number term=NONE cterm=NONE ctermbg=bg ctermfg=117 gui=NONE guibg=bg guifg=#96defa
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=141 gui=NONE guibg=bg guifg=#af81f4
    CSAHi erubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=#00ffff
    CSAHi NonText term=bold cterm=NONE ctermbg=17 ctermfg=23 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=#00ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=196 ctermfg=231 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=bold ctermbg=141 ctermfg=189 gui=bold guibg=#af81f4 guifg=#e2daef
    CSAHi Search term=reverse cterm=NONE ctermbg=141 ctermfg=189 gui=NONE guibg=#af81f4 guifg=#e2daef
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=29 gui=bold guibg=bg guifg=#2e8b57
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi LineNr term=underline cterm=NONE ctermbg=17 ctermfg=23 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi cssValueLength term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyAccess term=NONE cterm=NONE ctermbg=17 ctermfg=209 gui=italic guibg=#102235 guifg=#ef7760
    CSAHi rubyClassVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi hamlId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubySymbol term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCmdNote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyControl term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyException term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsUserClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARAssociationMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCopyTgt term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=23 ctermfg=195 gui=NONE guibg=#1e415e guifg=#dfeff6
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=30 ctermfg=195 gui=NONE guibg=#2d7889 guifg=#dfeff6
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=250 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi TabLine term=underline cterm=NONE ctermbg=253 ctermfg=240 gui=NONE guibg=#dddddd guifg=#555555
    CSAHi TabLineSel term=bold cterm=NONE ctermbg=145 ctermfg=233 gui=NONE guibg=#b0b0b0 guifg=#101010
    CSAHi TabLineFill term=reverse cterm=NONE ctermbg=253 ctermfg=195 gui=NONE guibg=#dddddd guifg=#e3f3fa
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=231 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=23 ctermfg=fg gui=NONE guibg=#18374f guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=72 ctermfg=fg gui=NONE guibg=#55a096 guifg=fg
    CSAHi rubyRegexpDelimiter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi MyTagListFileName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyBlockParameter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInclude term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyGlobalVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortBy term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortSeq term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=117 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi rubyRegexp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=46 gui=bold guibg=bg guifg=#00ff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=16 ctermfg=228 gui=NONE guibg=#0a1721 guifg=#ffec99
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=16 ctermfg=23 gui=NONE guibg=#0a1721 guifg=#233f59
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=16 ctermfg=16 gui=NONE guibg=#0a1721 guifg=#0a1721
    CSAHi Title term=bold cterm=NONE ctermbg=17 ctermfg=209 gui=NONE guibg=#102235 guifg=#ef7760
    CSAHi Visual term=reverse cterm=NONE ctermbg=24 ctermfg=195 gui=NONE guibg=#24557a guifg=#dfeff6
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=196 gui=NONE guibg=bg guifg=#ff0000
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi Folded term=NONE cterm=NONE ctermbg=23 ctermfg=80 gui=NONE guibg=#1a3951 guifg=#68cee8
    CSAHi hamlClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi treeFlag term=NONE cterm=NONE ctermbg=17 ctermfg=61 gui=NONE guibg=#102235 guifg=#3e71a1
    CSAHi rubyEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInterpolation term=NONE cterm=NONE ctermbg=17 ctermfg=151 gui=NONE guibg=#102235 guifg=#b9e19d
    CSAHi cssBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsRenderMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSpecial term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTime term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSizeDate term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwQuickHelp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssClassName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cIf0 term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyConstant term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=195 ctermfg=17 gui=NONE guibg=#e3f3fa guifg=#102235
    CSAHi MatchParen term=reverse cterm=bold ctermbg=17 ctermfg=201 gui=bold guibg=#102235 guifg=#ff00ff
    CSAHi Comment term=bold cterm=NONE ctermbg=17 ctermfg=61 gui=italic guibg=#102235 guifg=#3e71a1
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=117 gui=NONE guibg=bg guifg=#96defa
    CSAHi Special term=bold cterm=NONE ctermbg=bg ctermfg=195 gui=NONE guibg=bg guifg=#dfeff6
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=117 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=80 gui=NONE guibg=bg guifg=#68cee8
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=209 gui=NONE guibg=bg guifg=#ef7760
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=74 gui=NONE guibg=bg guifg=#41b2ea
    CSAHi rubyInstanceVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlKey term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAnchor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAlias term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlDocumentHeader term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssURL term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssFunctionName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssColor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssPseudoClassId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwPlain term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssCommonAttr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=23 ctermfg=23 gui=NONE guibg=#1a3951 guifg=#1e415e
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=18 ctermfg=fg gui=NONE guibg=#00008b guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=90 ctermfg=fg gui=NONE guibg=#8b008b guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=30 ctermfg=21 gui=bold guibg=#008b8b guifg=#0000ff
    CSAHi DiffText term=reverse cterm=bold ctermbg=196 ctermfg=fg gui=bold guibg=#ff0000 guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=196 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=21 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=201 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=51 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
elseif has("gui_running") || &t_Co == 88
    CSAHi Normal term=NONE cterm=NONE ctermbg=16 ctermfg=63 gui=NONE guibg=#102235 guifg=#e3f3fa
    CSAHi htmlArg term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi htmlSpecialChar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTreeBarSpace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptRailsFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSlash term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi erubyComment term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyPseudoVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyOperator term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=43 gui=underline guibg=bg guifg=#8ac6f2
    CSAHi Ignore term=NONE cterm=NONE ctermbg=16 ctermfg=17 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Error term=reverse cterm=NONE ctermbg=64 ctermfg=79 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi Todo term=NONE cterm=bold ctermbg=16 ctermfg=61 gui=bold guibg=#102235 guifg=#aded80
    CSAHi String term=NONE cterm=NONE ctermbg=bg ctermfg=41 gui=italic guibg=bg guifg=#89e14b
    CSAHi Number term=NONE cterm=NONE ctermbg=bg ctermfg=43 gui=NONE guibg=bg guifg=#96defa
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=55 gui=NONE guibg=bg guifg=#af81f4
    CSAHi erubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=31 gui=NONE guibg=bg guifg=#00ffff
    CSAHi NonText term=bold cterm=NONE ctermbg=16 ctermfg=17 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=31 gui=NONE guibg=bg guifg=#00ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=64 ctermfg=79 gui=NONE guibg=#ff0000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=bold ctermbg=55 ctermfg=59 gui=bold guibg=#af81f4 guifg=#e2daef
    CSAHi Search term=reverse cterm=NONE ctermbg=55 ctermfg=59 gui=NONE guibg=#af81f4 guifg=#e2daef
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=21 gui=bold guibg=bg guifg=#2e8b57
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi LineNr term=underline cterm=NONE ctermbg=16 ctermfg=17 gui=NONE guibg=#102235 guifg=#233f59
    CSAHi cssValueLength term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyAccess term=NONE cterm=NONE ctermbg=16 ctermfg=69 gui=italic guibg=#102235 guifg=#ef7760
    CSAHi rubyClassVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi hamlId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubySymbol term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCmdNote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyControl term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyException term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsUserClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARAssociationMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsARMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwCopyTgt term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=17 ctermfg=63 gui=NONE guibg=#1e415e guifg=#dfeff6
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=21 ctermfg=63 gui=NONE guibg=#2d7889 guifg=#dfeff6
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=85 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi TabLine term=underline cterm=NONE ctermbg=87 ctermfg=81 gui=NONE guibg=#dddddd guifg=#555555
    CSAHi TabLineSel term=bold cterm=NONE ctermbg=85 ctermfg=16 gui=NONE guibg=#b0b0b0 guifg=#101010
    CSAHi TabLineFill term=reverse cterm=NONE ctermbg=87 ctermfg=63 gui=NONE guibg=#dddddd guifg=#e3f3fa
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=79 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=17 ctermfg=fg gui=NONE guibg=#18374f guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=37 ctermfg=fg gui=NONE guibg=#55a096 guifg=fg
    CSAHi rubyRegexpDelimiter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi MyTagListFileName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyBlockParameter term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInclude term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyGlobalVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortBy term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSortSeq term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=43 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi rubyRegexp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=28 gui=bold guibg=bg guifg=#00ff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=16 ctermfg=77 gui=NONE guibg=#0a1721 guifg=#ffec99
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=16 ctermfg=17 gui=NONE guibg=#0a1721 guifg=#233f59
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=16 ctermfg=16 gui=NONE guibg=#0a1721 guifg=#0a1721
    CSAHi Title term=bold cterm=NONE ctermbg=16 ctermfg=69 gui=NONE guibg=#102235 guifg=#ef7760
    CSAHi Visual term=reverse cterm=NONE ctermbg=21 ctermfg=63 gui=NONE guibg=#24557a guifg=#dfeff6
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=64 gui=NONE guibg=bg guifg=#ff0000
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=76 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi Folded term=NONE cterm=NONE ctermbg=17 ctermfg=43 gui=NONE guibg=#1a3951 guifg=#68cee8
    CSAHi hamlClass term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi treeFlag term=NONE cterm=NONE ctermbg=16 ctermfg=21 gui=NONE guibg=#102235 guifg=#3e71a1
    CSAHi rubyEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyInterpolation term=NONE cterm=NONE ctermbg=16 ctermfg=57 gui=NONE guibg=#102235 guifg=#b9e19d
    CSAHi cssBraces term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyRailsRenderMethod term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSpecial term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwTime term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwSizeDate term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwQuickHelp term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssClassName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cIf0 term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi rubyConstant term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=63 ctermfg=16 gui=NONE guibg=#e3f3fa guifg=#102235
    CSAHi MatchParen term=reverse cterm=bold ctermbg=16 ctermfg=67 gui=bold guibg=#102235 guifg=#ff00ff
    CSAHi Comment term=bold cterm=NONE ctermbg=16 ctermfg=21 gui=italic guibg=#102235 guifg=#3e71a1
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=43 gui=NONE guibg=bg guifg=#96defa
    CSAHi Special term=bold cterm=NONE ctermbg=bg ctermfg=63 gui=NONE guibg=bg guifg=#dfeff6
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=43 gui=NONE guibg=bg guifg=#8ac6f2
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=43 gui=NONE guibg=bg guifg=#68cee8
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=69 gui=NONE guibg=bg guifg=#ef7760
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=27 gui=NONE guibg=bg guifg=#41b2ea
    CSAHi rubyInstanceVariable term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi javaScriptFunction term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlKey term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAnchor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlAlias term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi yamlDocumentHeader term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssURL term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssFunctionName term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssColor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssPseudoClassId term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi netrwPlain term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cssCommonAttr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=17 ctermfg=17 gui=NONE guibg=#1a3951 guifg=#1e415e
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=17 ctermfg=fg gui=NONE guibg=#00008b guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=33 ctermfg=fg gui=NONE guibg=#8b008b guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=21 ctermfg=19 gui=bold guibg=#008b8b guifg=#0000ff
    CSAHi DiffText term=reverse cterm=bold ctermbg=64 ctermfg=fg gui=bold guibg=#ff0000 guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=85 ctermfg=31 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=64 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=19 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=67 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=31 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
endif

if 1
    delcommand CSAHi
endif
