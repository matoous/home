<div align="center">

# @home

</div>

My dotfiles and workstation setup managed with [mise](https://mise.jdx.dev/dotfiles.html).

## New Mac

Install Apple's command line tools with `xcode-select --install`, then download, review, and run the setup script.

```sh
curl -fsSLo /tmp/home-setup.sh https://raw.githubusercontent.com/matoous/home/main/setup.sh
bash /tmp/home-setup.sh
```

The script installs standalone `mise` if needed, clones the public repo over HTTPS, and runs bootstrap. Bootstrap installs native packages and desktop apps, links dotfiles, installs development tools, and updates Fish plugins. GitHub sign-in, SSH keys, and device preferences can be configured separately.

With mise 2026.10.23 or newer installed, run:

```sh
mkdir -p "$HOME/code/github.com/matoous"
mise bootstrap --from https://github.com/matoous/home.git \
  --from-dir "$HOME/code/github.com/matoous/home"
```

The path above is the default. Pass a different directory as the first argument to `setup.sh`, or set `--from-dir` when calling mise directly. Mise resolves dotfile sources relative to the checkout.

### Fish login shell

```sh
fish_path="$(mise bootstrap packages where brew:fish)/bin/fish"
grep -Fxq "$fish_path" /etc/shells || echo "$fish_path" | sudo tee -a /etc/shells
chsh -s "$fish_path"
```

Open a new terminal to start Fish.

## Maintenance

Run Git commands from your checkout. Mise only links tracked files from its directory mappings, so stage new dotfile sources before applying them.

| Command | What it does |
| --- | --- |
| `mise -C "$HOME" dot apply --dry-run` | Preview changes to managed files. |
| `mise -C "$HOME" dot apply` | Apply the dotfiles and Codex preferences. |
| `mise -C "$HOME" install --locked` | Install developer tools at their locked versions. |
| `mise -C "$HOME" bootstrap packages apply` | Install missing native packages and apps. |
| `mise -C "$HOME" bootstrap packages upgrade` | Update installed native packages and apps. |
| `mise upgrade --global` | Upgrade global developer tools and refresh their lockfile. |
| `mise -C "$HOME" bootstrap --dry-run` | Preview the full setup. |

Commit tool changes with the corresponding `mise.lock` and generated `.mise/locks/` files. For an optional tool environment, select `embedded` or `beam`.

```sh
mise -E embedded -C "$HOME" bootstrap --only packages,tools
mise -E beam -C "$HOME" bootstrap --only tools
mise -E embedded,beam lock --global --platform macos-arm64 --bump
```

## Local configuration

- Mise reads `~/.config/mise/config.local.toml` alongside the shared config. Use it for local environment variables, additional dotfile links, or device-specific bootstrap settings.
- Git reads the optional `~/.config/gitconfig.local`. Configure your identity, signing key, and any URL rewrites there.
- On first setup, the Codex template seeds a local `~/.codex/config.toml` with mode `0600`. Mise merges the shared plugin preferences into that file. Configure accounts, credentials, and additional MCP servers locally.
- Helix and Mitos runtime links for source builds belong in the local config directories. pgcli credentials and history stay local as well.

Run `mise run codex:setup` to install missing plugins and apply their preferences. On a new machine, use `codex login` and sign into any connected services you use. The [son-of-anton](https://github.com/matoous/son-of-anton) marketplace supplies the shared skills and Rex plugin.

The Rex config provides `rex do dev`, `rex do ask`, `rex do diff`, and `rex do test`. Mitos also uses the Rex `ask` action for `:ask` in a Rex terminal. After editing either config, reload it with `rex config reload` or Mitos's `:config-reload`.

To set up Rex themes, run **Import Warm Burnout Dark** or **Import Warm Burnout Light** from the command palette. Both actions use the Ghostty palettes linked by mise.
