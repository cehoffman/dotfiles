# Typing the variables caused warnings on new subshells
# typeset -TUg LS_COLORS ls_colors
typeset -a ls_colors

# Effects
# 00  Default colour
# 01  Bold
# 04  Underlined
# 05  Flashing text
# 07  Reversetd
# 08  Concealed
# Colours
# 31  Red
# 32  Green
# 33  Orange
# 34  Blue
# 35  Purple
# 36  Cyan
# 37  Grey
# Backgrounds
# 40  Black background
# 41  Red background
# 42  Green background
# 43  Orange background
# 44  Blue background
# 45  Purple background
# 46  Cyan background
# 47  Grey background
# Extra colours
# 90  Dark grey
# 91  Light red
# 92  Light green
# 93  Yellow
# 94  Light blue
# 95  Light purple
# 96  Turquoise
# 97  White
# 100 Dark grey background
# 101 Light red background
# 102 Light green background
# 103 Yellow background
# 104 Light blue background
# 105 Light purple background
# 106 Turquoise background

ls_colors=(
  'no=00' # no color code at all
  'fi=00' # regular file: use no color at all
  'di=33' # directory
  'ln=36'  # symbolic link. (If you set this to 'target' instead of a
           # numerical value, the color is as for the file pointed to.)
# MULTIHARDLINK 00 # regular file with more than one link
  'pi=95' # pipe
  'so=35' # socket
  'do=35' # door
  'bd=93' # block device driver
  'cd=93' # character device driver
  'or=31;05' # symlink to nonexistent file, or non-stat'able file
  'su=37;41' # file that is setuid (u+s)
  'sg=30;43' # file that is setgid (g+s)
# CAPABILITY 30;41 # file with capability
  'tw=30;42' # dir that is sticky and other-writable (+t,o+w)
  'ow=34;42' # dir that is other-writable (o+w) and not sticky
  'st=37;44' # dir with the sticky bit set (+t) and not other-writable
  # This is for files with execute permission:
  'ex=32'

 # archives or compressed (bright red)
  '*.tar=31'
  '*.tgz=31'
  '*.arj=31'
  '*.taz=31'
  '*.lzh=31'
  '*.lzma=31'
  '*.tlz=31'
  '*.txz=31'
  '*.zip=31'
  '*.z=31'
  '*.Z=31'
  '*.dz=31'
  '*.gz=31'
  '*.xz=31'
  '*.bz2=31'
  '*.bz=31'
  '*.tbz=31'
  '*.tbz2=31'
  '*.tz=31'
  '*.deb=31'
  '*.rpm=31'
  '*.jar=31'
  '*.rar=31'
  '*.ace=31'
  '*.zoo=31'
  '*.cpio=31'
  '*.7z=31'
  '*.rz=31'
# image formats
  '*.jpg=35'
  '*.jpeg=35'
  '*.gif=35'
  '*.bmp=35'
  '*.pbm=35'
  '*.pgm=35'
  '*.ppm=35'
  '*.tga=35'
  '*.xbm=35'
  '*.xpm=35'
  '*.tif=35'
  '*.tiff=35'
  '*.png=35'
  '*.svg=35'
  '*.svgz=35'
  '*.mng=35'
  '*.pcx=35'
  '*.mov=35'
  '*.mpg=35'
  '*.mpeg=35'
  '*.m2v=35'
  '*.mkv=35'
  '*.ogm=35'
  '*.mp4=35'
  '*.m4v=35'
  '*.mp4v=35'
  '*.vob=35'
  '*.qt=35'
  '*.nuv=35'
  '*.wmv=35'
  '*.asf=35'
  '*.rm=35'
  '*.rmvb=35'
  '*.flc=35'
  '*.avi=35'
  '*.fli=35'
  '*.flv=35'
  '*.gl=35'
  '*.dl=35'
  '*.xcf=35'
  '*.xwd=35'
  '*.yuv=35'
# http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
  '*.axv=35'
  '*.anx=35'
  '*.ogv=35'
  '*.ogx=35'
# audio formats
  '*.aac=00;36'
  '*.au=00;36'
  '*.flac=00;36'
  '*.mid=00;36'
  '*.midi=00;36'
  '*.mka=00;36'
  '*.mp3=00;36'
  '*.mpc=00;36'
  '*.ogg=00;36'
  '*.ra=00;36'
  '*.wav=00;36'
# http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
  '*.axa=00;36'
  '*.oga=00;36'
  '*.spx=00;36'
  '*.xspf=00;36'
# scripts
  # '*.rb=91'
  # '*.py=00;93'
)

export LS_COLORS=${(j.:.)ls_colors}

# Use the ls colors for completion lists
zstyle ':completion:*:default' list-colors $ls_colors
unset ls_colors

# Colorize ls output
alias ls="ls --color=always -F"
