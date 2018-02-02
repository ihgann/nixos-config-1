## Personal NixOS configs

This uses [Home Manager](https://github.com/rycee/home-manager) to manage
dotfiles

### Usage
Symlink host file from `hosts/<hostname>.nix` to `configuration.nix`

### Layout
- `cfgs/` - Package configurations
- `hosts/` - Host specific configurations
- `options/` - Option files for custom packages
- `pkgs/` - Custom packages
- `presets/` - General shared configurations
