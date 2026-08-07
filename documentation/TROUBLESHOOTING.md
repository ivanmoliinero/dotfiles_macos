# TROUBLESHOOTING GUIDES
## Nix is not correctly started
In MacOS Nix needs to mount a volume in order to access directly through the path /nix. Otherwise no directory could be created there (read-only filesystem for Apple reasons, I want to analyze this with more detail more however).

In order to work, it needs 2 additional services to be working:
- org.nixos.darwin-store: Restores encrypted MacOS volume and mounts it into /nix.
- org.nixos.nix-daemon: The Nix daemon itself.

The volume encryption can be a little bit cumbersome to detect when using it for the first time. The commands to make it work are the following:
```bash
sudo launchctl load /Library/LaunchDaemons/org.nixos.darwin-store	# disk decrypt
sudo launchctl start system/org.nixos.darwin-store 			# if not started yet
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon 	# nix
sudo launchctl start system/org.nixos.nix-daemon

# Print info about service status
sudo launchctl print system/org.nixos.darwin-store
sudo launchctl print system/org.nixos.nix-daemon
```
