# msys-gvim.sh
# description: Launches an instance of GVim (standard Windows build) from
# within an msys-bash shell.  Posix paths will be mapped to Windows paths.
# You must opt for the command line .bat files when installing Gvim.
#
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
    "/c/Windows/gvim.bat" $ARGS
