## *Kim's Personal Nix(OS) configs

Makes use of [Home Manager](https://github.com/rycee/home-manager) to manage
(some) dotfiles

Also works under [Nix-Darwin](https://github.com/LnL7/nix-darwin)

Maybe useful to others?  There are shenanigans in `configuration.nix`, and some
of the `default.nix` files -- primarily when dealing with imports, and platform
specifics

It also includes some slightly unconventional Nix syntax adjustments to hack in
fenced syntax highlighting within strings

### Installing
```
# optionally set/export HOST to select a default host file
curl https://gitlab.com/zick.kim/nixos/nixos-config/raw/master/install.sh | sh
```

### Layout
- `channels/` - Pinned channels
- `config/` - Package configurations
  - `config/home-manager` - [Home Manager](https://github.com/rycee/home-manager) configurations
- `hosts/` - Host specific configurations
- `modules/` - Custom  modules
- `overlays/` - Package overlays
- `profiles/` - Configuration profiles

### Debugging
Run `nix repl '<nixpkgs/nixos>'`, configuration results are under `config.*`,
reload with `:r`

Or use `nixos-option` to determine the current and default values for an option,
and view the option's description

Alternatively use `nix repl '<darwin>'`, or `darwin-option` if using nix-darwin

### Syncing
Assuming you have a separate local repository, and want to sync all refs in
order to push them

```
git checkout --detach
git fetch local '+refs/heads/*:refs/heads/*'
git push origin --all
git checkout master
```

### Fenced syntax highlighting

The selection of fenced languages is over at [config/neovim.nix](config/neovim.nix)

![Tmux syntax highlighting in Vim](screenshots/tmux.png)
