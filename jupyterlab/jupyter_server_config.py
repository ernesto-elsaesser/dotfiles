import os
import ssl

home_dir = os.environ["HOME"]
checkpoint_dir = os.path.join(home_dir, ".jupyter", "check")
os.makedirs(checkpoint_dir, exist_ok=True)

c.ServerApp.ip = "*"
c.ServerApp.root_dir = home_dir
c.ServerApp.certfile = "/etc/ssl/certs/server.crt"
c.ServerApp.keyfile = "/etc/ssl/private/server.key"
c.ServerApp.ssl_options = {
    "ssl_version": ssl.PROTOCOL_TLSv1_2
}
c.ServerApp.open_browser = False

c.PasswordIdentityProvider.password_required = True
c.PasswordIdentityProvider.hashed_password = "..."

c.FileContentsManager.allow_hidden = True
c.FileContentsManager.delete_to_trash = False
c.FileContentsManager.always_delete_dir = True

c.FileCheckpoints.checkpoint_dir = checkpoint_dir
