#!/usr/bin/env bash

TARGETS=(
    "theme:$HOME/.themes:archive"
    "icon:$HOME/.icons:archive"
    "fcitx:$HOME/.local/share/fcitx5/themes:plain"
)

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=false
SELECTED=()

C=$(tput setaf 6); G=$(tput setaf 2); Y=$(tput setaf 3); X=$(tput sgr0)

for arg in "$@"; do
    case "$arg" in
        -f|--force) FORCE=true ;;
        -*) echo "Unknown option: $arg"; exit 1 ;;
        *)  SELECTED+=("$arg") ;;
    esac
done

msg()  { echo "${C}[I]${X} $1"; }
ok()   { echo "${G}[✓]${X} $1"; }
warn() { echo "${Y}[!]${X} $1"; }

deploy_archive() {
    local src="$1" dest="$2"
    for ext in "tar.gz" "zip"; do
        for file in "$src"/*."$ext"; do
            [[ ! -e "$file" ]] && continue
            local name=$(basename "$file")
            local dir="${name%."$ext"}"; [[ "$ext" == "tar.gz" ]] && dir="${dir%.tar}"
            local target="$dest/$dir"

            if [[ -e "$target" || -L "$target" ]]; then
                $FORCE && rm -rf "$target" || { warn "Skip: $dir (exists)"; continue; }
            fi

            msg "Extracting: $name"
            if [[ "$ext" == "tar.gz" ]]; then
                tar -xzf "$file" -C "$dest"
            else
                unzip -o -q "$file" -d "$dest"
            fi
            [[ $? -eq 0 ]] && ok "Done: $dir"
        done
    done
}

deploy_plain() {
    local src="$1" dest="$2"
    for item in "$src"/*; do
        [[ ! -d "$item" ]] && continue
        local name=$(basename "$item")
        local target="$dest/$name"

        if [[ -e "$target" || -L "$target" ]]; then
            $FORCE && rm -rf "$target" || continue
        fi
        cp -r "$item" "$dest/" && ok "Copied: $name"
    done
}

msg "Starting deployment..."
$FORCE && warn "Force mode enabled"

for cfg in "${TARGETS[@]}"; do
    IFS=':' read -r src_sub dest mode <<< "$cfg"

    if [[ ${#SELECTED[@]} -gt 0 ]]; then
        found=false
        for s in "${SELECTED[@]}"; do [[ "$s" == "$src_sub" ]] && found=true && break; done
        $found || continue
    fi

    src_path="$ROOT/$src_sub"
    [[ ! -d "$src_path" ]] && continue
    [[ ! -d "$dest" ]] && mkdir -p "$dest"

    msg "Processing group: $src_sub"
    case "$mode" in
        archive) deploy_archive "$src_path" "$dest" ;;
        plain)   deploy_plain "$src_path" "$dest" ;;
    esac
done

ok "Execution finished"
