#!/bin/bash
set -euo pipefail

if [[ "$(uname -s)" != Darwin || "$(uname -m)" != arm64 ]]; then
  echo "This setup script requires Apple Silicon macOS."
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish installing the command line tools, then rerun this script."
  exit 1
fi

export PATH="$HOME/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/opt/curl/bin:/opt/homebrew/opt/libpq/bin:$PATH"
if ! command -v mise >/dev/null; then
  curl -fsSL https://mise.run | sh
fi

# Keep variables literal so Zsh expands them when it reads the profile.
# shellcheck disable=SC2016
path_init='export PATH="$HOME/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/opt/curl/bin:/opt/homebrew/opt/libpq/bin:$PATH"'
if ! grep -Fqx "$path_init" "$HOME/.zprofile" 2>/dev/null; then
  printf '\n%s\n' "$path_init" >> "$HOME/.zprofile"
fi

checkout="${1:-$HOME/code/github.com/matoous/home}"
mkdir -p "$(dirname "$checkout")"
exec mise bootstrap --from https://github.com/matoous/home.git --from-dir "$checkout"
