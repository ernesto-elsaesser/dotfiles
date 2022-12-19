import os
import ssl

home_dir = os.environ["HOME"]

c.ServerApp.password = "..."
c.ServerApp.password_required = True
c.ServerApp.ip = "*"
c.ServerApp.notebook_dir = home_dir
c.ServerApp.open_browser = False

c.NotebookApp.certfile = "/etc/ssl/certs/server.crt"
c.NotebookApp.keyfile = "/etc/ssl/private/server.key"
c.NotebookApp.ssl_options = {
    "ssl_version": ssl.PROTOCOL_TLSv1_2
}

c.ContentsManager.allow_hidden = True

checkpoint_dir = os.path.join(home_dir, ".jupyter", "check")
os.makedirs(checkpoint_dir, exist_ok=True)
c.FileCheckpoints.checkpoint_dir = checkpoint_dir
