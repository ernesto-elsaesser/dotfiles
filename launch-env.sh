ENV_DIR="$HOME/dotfiles/$1-env"
[ "$SHELL" = '/bin/zsh' ] && ZDOTDIR="$ENV_DIR" F=$2 zsh
[ "$SHELL" = '/bin/bash' ] && F=$2 bash --rcfile "$ENV_DIR/.bashrc"
