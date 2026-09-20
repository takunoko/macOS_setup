#!/usr/bin/env bash

# prezto: https://github.com/sorin-ionescu/prezto

set -euo pipefail

zsh_config_dir="${ZDOTDIR:-$HOME}"
zprezto_dir="$zsh_config_dir/.zprezto"
git_escape_magic="$zprezto_dir/modules/prompt/functions/git-escape-magic"
git_escape_magic_url="https://raw.githubusercontent.com/knu/zsh-git-escape-magic/master/git-escape-magic"

echo "Start zshprezto initialize"

# Clone only when prezto is not installed yet.  Do not replace an existing
# directory: it may contain local customizations that should survive reruns.
if [[ -d "$zprezto_dir/.git" ]]; then
  echo "Prezto already exists: $zprezto_dir"
elif [[ -e "$zprezto_dir" ]]; then
  echo "Error: $zprezto_dir exists but is not a git repository" >&2
  exit 1
else
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$zprezto_dir"
fi

# zshでgitコマンドをつかうときに自動で^をエスケープしてくれるプラグイン。
# Download next to the destination and replace it only after a successful
# download. This keeps reruns up to date without ever truncating a valid file.
mkdir -p "$(dirname "$git_escape_magic")"
temporary_plugin="$(mktemp "$(dirname "$git_escape_magic")/.git-escape-magic.XXXXXX")"
trap 'rm -f "$temporary_plugin"' EXIT
curl --fail --location --silent --show-error --output "$temporary_plugin" "$git_escape_magic_url"
chmod 644 "$temporary_plugin"
mv -f "$temporary_plugin" "$git_escape_magic"
trap - EXIT

# Link prezto runcoms into ZDOTDIR. Existing matching links are left alone;
# conflicting files are never overwritten.
for rcfile in "$zprezto_dir"/runcoms/*; do
  [[ -f "$rcfile" ]] || continue
  [[ "${rcfile##*/}" == "README.md" ]] && continue

  target="$zsh_config_dir/.${rcfile##*/}"
  if [[ -L "$target" && "$(readlink "$target")" == "$rcfile" ]]; then
    continue
  elif [[ -e "$target" || -L "$target" ]]; then
    echo "Error: refusing to replace existing file: $target" >&2
    exit 1
  fi

  ln -s "$rcfile" "$target"
done

echo "Finish zshprezto initialize"
