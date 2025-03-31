# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/damiannolan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  golang
  gpg-agent
  ssh-agent
  themes
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# Lanuage
export LANG=en

# GPG
export GPG_TTY=$(tty)

# Golang
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN:$GOPATH

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# bun completions
[ -s "/Users/damiannolan/.bun/_bun" ] && source "/Users/damiannolan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# scripting fns
function git_commit_browser() {
  # Ensure we are inside a Git repository
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "❌ Not inside a Git repository!"
    return 1
  fi

  # Use fzf to display commit history with a larger dropdown window
  commit_hash=$(git log --pretty=format:"%h %C(yellow)%h%Creset %C(cyan)(%ad)%Creset %s %C(blue)- %an%Creset" --date=short --abbrev-commit --color=always |
    fzf --ansi --no-sort \
        --preview "git show --color=always {1}" \
        --preview-window=right:75% \
        --height=95% --border --reverse --min-height=20 \
        --prompt="Select a commit: " --exit-0 |
    awk '{print $1}')  # Extract correct commit hash

  # Exit if no commit was selected
  if [[ -z "$commit_hash" || "$commit_hash" == " " ]]; then
    echo "❌ No commit selected. Exiting..."
    return 0
  fi

  # Show commit details
  clear
  echo "✅ Showing details for commit: $commit_hash"
  git show --color=always "$commit_hash" | less -R
}

cleanlog() {
  if [[ -z "$1" ]]; then
    echo "Usage: cleanlog <filename>"
    return 1
  fi

  input_file="$1"

  if [[ ! -f "$input_file" ]]; then
    echo "File not found: $input_file"
    return 1
  fi

  # Create a safe temp file in the same directory
  tmp_file="$(dirname "$input_file")/.$(basename "$input_file").tmp"

  # Clean the file by stripping ANSI codes
  sed -E "s/\x1B\[[0-9;]*[mK]//g" "$input_file" > "$tmp_file"

  if [[ $? -eq 0 ]]; then
    mv "$tmp_file" "$input_file"
    echo "✅ Cleaned ANSI codes from: $input_file"
  else
    echo "❌ Failed to clean file"
    rm -f "$tmp_file"
    return 1
  fi
}
