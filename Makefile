# Backup

rs-backup:
	./rsync.sh

# Restore
# TODO

# Sync stow

ssync:
	stow -D . && stow .  # is symlink removal necessary?
