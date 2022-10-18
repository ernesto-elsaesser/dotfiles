#  jupyter lab --ContentsManager.allow_hidden=True --FileCheckpoints.checkpoint_dir=~/.jupyter/check

SETTINGS_DIR="$HOME/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension"
[ -d $SETTINGS_DIR ] || mkdir $SETTINGS_DIR
cp shortcuts.json "$SETTINGS_DIR/shortcuts.jupyterlab-settings"

#EXT_DIR="$CONDA_PREFIX/share/jupyter/labextensions/vimrc/"
#mkdir -p $EXT_DIR && cp -r extension/* $EXT_DIR
