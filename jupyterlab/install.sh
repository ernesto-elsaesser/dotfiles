EXTDIR="$CONDA_PREFIX/share/jupyter/labextensions/vimrc/"
cp shortcuts.json ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings
[ "$1" = "ext" ] && mkdir -p $EXTDIR && cp -r prebuilt/* $EXTDIR
