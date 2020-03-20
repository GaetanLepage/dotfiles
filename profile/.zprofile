# Profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# Default programs:
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"
export STATUSBAR="polybar"

# ~/ Clean-up:
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
#export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
#export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
#export LESSHISTFILE="-"
#export WGETRC="$HOME/.config/wget/wgetrc"
#export INPUTRC="$HOME/.config/inputrc"
export ZDOTDIR="$HOME"
#export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

mpd >/dev/null 2>&1 &

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx

# Set french keyboard layout
setxkbmap -layout fr

# Switch escape and caps if tty and no passwd required:
setxkbmap -option caps:swapescape