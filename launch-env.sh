ENV_DIR="$HOME/dotfiles/$1-env"
[ "$SHELL" = '/bin/zsh' ] && ZDOTDIR="$ENV_DIR" zsh
[ "$SHELL" = '/bin/bash' ] && bash --rcfile "$ENV_DIR/.bashrc"
