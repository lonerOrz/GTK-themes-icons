#!/usr/bin/env bash

SYNC_MAP=(
    "theme:$HOME/.themes:archive"
    "icon:$HOME/.icons:archive"
    "fcitx:$HOME/.local/share/fcitx5/themes:plain"
)

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
C=$(tput setaf 6); G=$(tput setaf 2); Y=$(tput setaf 3); X=$(tput sgr0)

msg()  { echo "${C}[I]${X} $1"; }
ok()   { echo "${G}[✓]${X} $1"; }
warn() { echo "${Y}[!]${X} $1"; }

warn "Backup system themes to repo?"
read -p "Confirm? (y/N): " confirm; [[ "$confirm" != "y" ]] && exit 0

msg "Starting backup..."

for cfg in "${SYNC_MAP[@]}"; do
    IFS=':' read -r repo_sub sys_path mode <<< "$cfg"
    repo_path="$ROOT/$repo_sub"
    [[ ! -d "$sys_path" ]] && continue

    msg "Processing group: $repo_sub"

    mkdir -p "$repo_path"
    rm -rf "${repo_path:?}"/*

    cd "$sys_path" || continue
    for item in *; do
        [[ ! -d "$item" || "$item" == "." || "$item" == ".." ]] && continue

        if [[ "$mode" == "archive" ]]; then
            msg "Packing: $item"
            tar -czf "$repo_path/$item.tar.gz" "$item"
        else
            msg "Copying: $item"
            cp -r "$item" "$repo_path/"
        fi
        [[ $? -eq 0 ]] && ok "Done: $item"
    done
done

ok "Backup complete"
