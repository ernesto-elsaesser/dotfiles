import os
import ssl

home_dir = os.environ["HOME"]

# set password in json config file: ServerApp.password
c.ServerApp.password_required = True
c.ServerApp.ip = "*"
c.ServerApp.root_dir = home_dir
#c.ServerApp.notebook_dir = home_dir - deprecated
c.ServerApp.certfile = "/etc/ssl/certs/server.crt"
c.ServerApp.keyfile = "/etc/ssl/private/server.key"
c.ServerApp.ssl_options = {
    "ssl_version": ssl.PROTOCOL_TLSv1_2
}

c.NotebookApp.open_browser = False

c.ContentsManager.allow_hidden = True

checkpoint_dir = os.path.join(home_dir, ".jupyter", "check")
os.makedirs(checkpoint_dir, exist_ok=True)
c.FileCheckpoints.checkpoint_dir = checkpoint_dir