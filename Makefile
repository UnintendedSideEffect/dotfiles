.POSIX:

.DEFAULT:
	home

BACKUP_DIR = $(HOME)/backup
USE_NIX_PLUGINS = --option extra-builtins-file $(PWD)/nix-plugins/pass.nix

home: user/home.nix
	nix-shell --run "home-manager $(USE_NIX_PLUGINS) -f $? switch"

switch: machine/laptop/configuration.nix
	nixos-rebuild -I nixos-config=$? switch

#TODO backup will be always run, or not overriden even when file changed
# should only copy files, which have changed.
backup: $(HOME)/.ssh $(HOME)/.gnupg $(HOME)/.mozilla \
		$(HOME)/.local/share/password-store \
		$(PWD) # this nix-config directory
	mkdir -p $(BACKUP_DIR)
	cp -r $? $(BACKUP_DIR)

collect-garbage:
	nix-collect-garbage --delete-old
