#!/usr/bin/env bash

set -Eeuo pipefail

if [[ ! -f /etc/arch-release ]]; then
    printf 'This installer only supports Arch Linux.\n' >&2
    exit 1
fi

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
backup_suffix="$(date +%Y%m%d-%H%M%S)"

if (( EUID == 0 )); then
    pacman_cmd=(pacman)
    npm_cmd=(npm)
else
    command -v sudo >/dev/null || {
        printf 'sudo is required when running as a regular user.\n' >&2
        exit 1
    }
    sudo -v
    pacman_cmd=(sudo pacman)
    npm_cmd=(sudo npm)
fi

packages=(
    base-devel
    curl
    fd
    fzf
    git
    github-cli
    htop
    neovim
    nodejs
    npm
    openssh
    python
    python-pip
    ripgrep
    tmux
    tree-sitter-cli
    unzip
    wl-clipboard
    xclip
    yarn
    zsh
)

printf 'Installing Arch packages...\n'
"${pacman_cmd[@]}" -Syu --needed --noconfirm "${packages[@]}"

# Neofetch is archived and may not exist in newer Arch repositories.
if "${pacman_cmd[@]}" -Si neofetch >/dev/null 2>&1; then
    "${pacman_cmd[@]}" -S --needed --noconfirm neofetch
fi

if ! command -v opencode >/dev/null 2>&1; then
    printf 'Installing OpenCode...\n'
    "${npm_cmd[@]}" install --global opencode-ai
fi

link_config() {
    local source=$1
    local destination=$2

    mkdir -p "$(dirname -- "$destination")"

    if [[ -L $destination && $(readlink -f -- "$destination") == $(readlink -f -- "$source") ]]; then
        return
    fi

    if [[ -e $destination || -L $destination ]]; then
        local backup="${destination}.backup-${backup_suffix}"
        printf 'Backing up %s to %s\n' "$destination" "$backup"
        mv -- "$destination" "$backup"
    fi

    ln -s -- "$source" "$destination"
    printf 'Linked %s -> %s\n' "$destination" "$source"
}

link_config "$repo_dir/.tmux.conf" "$HOME/.tmux.conf"
link_config "$repo_dir/nvim" "$HOME/.config/nvim"
link_config "$repo_dir/htop" "$HOME/.config/htop"
link_config "$repo_dir/neofetch" "$HOME/.config/neofetch"
link_config "$repo_dir/gh" "$HOME/.config/gh"
link_config "$repo_dir/opencode/opencode.jsonc" "$HOME/.config/opencode/opencode.jsonc"
link_config "$repo_dir/alacritty" "$HOME/.config/alacritty"
link_config "$repo_dir/wezterm" "$HOME/.config/wezterm"
link_config "$repo_dir/session.sh" "$HOME/.local/bin/tmux-session"

oh_my_zsh_dir="$HOME/.oh-my-zsh"
if [[ ! -d $oh_my_zsh_dir ]]; then
    printf 'Installing Oh My Zsh...\n'
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$oh_my_zsh_dir"
fi

link_config "$repo_dir/zsh-theme/custom.zsh-theme" \
    "$oh_my_zsh_dir/custom/themes/custom.zsh-theme"

if [[ ! -e $HOME/.zshrc ]]; then
    printf '%s\n' \
        'export ZSH="$HOME/.oh-my-zsh"' \
        'ZSH_THEME="custom"' \
        'plugins=(git)' \
        'source "$ZSH/oh-my-zsh.sh"' > "$HOME/.zshrc"
    printf 'Created %s\n' "$HOME/.zshrc"
else
    printf 'Keeping existing %s; set ZSH_THEME="custom" to use the included theme.\n' "$HOME/.zshrc"
fi

printf '\nSetup complete. Start a new shell, or run: exec zsh\n'
if [[ ${SHELL:-} != */zsh ]]; then
    zsh_path="$(command -v zsh)"
    printf 'Setting zsh as the default shell...\n'
    chsh -s "$zsh_path"
fi
