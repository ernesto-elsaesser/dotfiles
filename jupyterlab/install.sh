EXTDIR=~/anaconda3/share/jupyter/labextensions/vimrc/
cp shortcuts.json ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings
[ "$1" = "ext" ] && mkdir $EXTDIR && cp -r prebuilt/* $EXTDIR
