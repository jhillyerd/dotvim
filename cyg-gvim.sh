# Edit the HOME= line below to map to your desired "home" for Vim,
# if you don't want the Windows default.

(
  for f in "$@"; do 
    case $f in
      -*) echo $f;;
      *) cygpath -w "$f";;
    esac
  done) | xargs -d "\n" \
/usr/bin/env -i \
    HOME="$HOME" \
    OS="$OS" \
    Path="`cygpath -pw "$PATH"`" \
    PATHEXT="$PATHEXT" \
    ALLUSERSPROFILE="$ALLUSERSPROFILE" \
    USERPROFILE="$USERPROFILE" \
    LOCALAPPDATA="$LOCALAPPDATA" \
    COMSPEC="$COMSPEC" \
    SYSTEMROOT="$SYSTEMROOT" \
    "/cygdrive/c/Windows/gvim.bat" $ARGS
