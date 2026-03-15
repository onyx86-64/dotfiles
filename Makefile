# Backup

rs-backup:
	./scripts/rsync.sh

# Restore
# TODO

# Sync stow

ssync:
	stow -D . && stow . && hyprctl reload
