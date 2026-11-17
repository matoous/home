function fish_title
end

set -gx LANG en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx CDPATH ".:~:~/code"
set -gx LS_COLORS 'di=01;34:ln=01;36:ex=01;32:*.7z=01;31:*.bz2=01;31:*.gz=01;31:*.rar=01;31:*.tar=01;31:*.tgz=01;31:*.xz=01;31:*.zip=01;31:*.avif=01;35:*.gif=01;35:*.jpeg=01;35:*.jpg=01;35:*.png=01;35:*.svg=01;35:*.webp=01;35:*.mov=01;35:*.mp4=01;35:*.webm=01;35:*.flac=00;36:*.m4a=00;36:*.mp3=00;36:*.ogg=00;36:*.csv=00;33:*.json=00;33:*.toml=00;33:*.yaml=00;33:*.yml=00;33:*.md=00;32:*.txt=00;32:*.doc=00;31:*.docx=00;31:*.pdf=00;31:*.xls=00;31:*.xlsx=00;31'

# Editor
set -gx EDITOR ms

# Mise binary and native packages (mise uses the Homebrew prefix).
fish_add_path --path "$HOME/.local/bin" /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/ruby/bin /opt/homebrew/opt/curl/bin /opt/homebrew/opt/libpq/bin

# Scripts resolve project versions through shims and skip interactive startup.
if not status is-interactive
    mise activate fish --shims | source
    return
end

# Developer tools and project-specific runtime versions
mise activate fish | source

# FZF
set -gx FZF_DEFAULT_OPTS '
--style=minimal
--cycle
--preview-window=wrap
--marker=*
--multi
--color=fg:-1,bg:-1,fg+:-1,bg+:-1,gutter:-1,border:-1,separator:-1,scrollbar:-1,label:-1,query:-1,info:6,prompt:6,spinner:6,pointer:5,marker:3,hl:4,hl+:12,header:6
'
set -g fzf_fd_opts --color=always
set -g fzf_directory_opts --scheme=path
set -g fzf_preview_file_cmd 'bat --style=numbers --color=always --theme=ansi'
set -g fzf_preview_dir_cmd 'eza --all --color=always --group-directories-first --icons=never'
if functions -q fzf_configure_bindings; and functions -q _fzf_search_history
    fzf_configure_bindings --directory=ctrl-t --git_log=ctrl-g --history=ctrl-r
end

# GPG
set -gx GPG_TTY $(tty)

# Rust
if test -f "$HOME/export-esp.sh"
    sh "$HOME/export-esp.sh"
end

# Overrides
alias cat='bat --theme=ansi'
alias dig='doggo'
alias find='fd'
alias jsonnet='jrsonnet'
alias jsonnetfmt='jrsonnet-fmt'
alias loc='tokei'
alias rm='trash'
alias screen='fastfetch'

# Navigation
alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."

# Aliases
alias cpu='htop -s PERCENT_CPU' # CPU
alias dk="docker"
alias dkc="docker compose"
alias e='exit'
alias g='git'
alias ip="doggo --short myip.opendns.com @resolver1.opendns.com"
alias k='kubectl'
alias ll='eza --long --sort=age --git --time=modified --time-style=iso'
alias ls='eza --all --group-directories-first --level=2'
alias lsa='eza --all --group-directories-first --level=2'
alias mem='htop -s PERCENT_MEM' # Memory
alias mx='chmod +x'
alias now="biff"
alias p='python3'
alias wdc="pwd | tr -d '\n' | pbcopy"
alias pb='pbcopy'
alias ps="procs"
alias sizeof='du -sh'
alias sz='source ~/.config/fish/config.fish'
alias tf="terraform"
alias top="btop"
alias wifi='wifi-password -q'

direnv hook fish | source
zoxide init fish | source
starship init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
