SETTINGS_DIR="$HOME/.jupyter/lab/user-settings/@jupyterlab"
mkdir -p "$SETTINGS_DIR"
cp -rf user-settings/* "$SETTINGS_DIR"
