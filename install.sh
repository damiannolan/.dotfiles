#!/usr/bin/env bash

function installHomebrew() {
    echo "==================================="
    echo "Installing homebrew"
    echo "==================================="

    which -s brew > /dev/null
    if [[ $? -eq 1 ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        brew upgrade
    fi
}

function installHomebrewPackages() {
    echo "=================================="
    echo "Installing homebrew packages:"
    echo "git"
    echo "macvim"
    echo "tmux"
    echo "=================================="

    brew install git
    brew install macvim
    brew install tmux

    brew update
}

function installOhMyZsh() {
    echo "==================================="
    echo "Installing Oh my Zsh"
    echo "==================================="

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function setupVim() {
    echo "==================================="
    echo "Setting up vim and neovim"
    echo "==================================="

    ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
}

function setupTmux() {
    echo "==================================="
    echo "Linking tmux config"
    echo "==================================="

    ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
}

function setupZsh() {
    echo "==================================="
    echo "Setting ZSH as default shell"
    echo "==================================="

    ln -sf ~/dotfiles/zsh/.zshrc ~/.zhsrc

    chsh -s $(which zsh)
}

function install() {
    echo "==================================="
    echo "Beginning Installation..."
    echo "==================================="

    installHomebrew
    installHomebrewPackages
    installOhMyZsh
    setupVim
    setupTmux
    setupZsh
}

install