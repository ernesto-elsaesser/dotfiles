#  jupyter lab --ContentsManager.allow_hidden=True --FileCheckpoints.checkpoint_dir=~/.jupyter/check
EXTDIR="$CONDA_PREFIX/share/jupyter/labextensions/vimrc/"
cp shortcuts.json ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings
mkdir -p $EXTDIR && cp -r prebuilt/* $EXTDIR
