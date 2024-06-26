#!/usr/bin/env bash

set -e

# Script URL
script_url="https://your_script_url.com/gosearch"  # Replace with your actual script URL

# Check for zsh
if ! which zsh &> /dev/null; then
  echo "zsh is not installed. This script is designed for zsh."
  echo "Installation instructions: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH"
  exit 1
fi

if [[ $SHELL != *"zsh"* ]]; then 
    echo "$SHELL is the default shell"
    echo "but zsh must be your defaul shell"
    exit 1
fi

# Check for fzf
if ! command -v fzf &> /dev/null; then
  echo "fzf is not installed."
  echo "Installation instructions: https://github.com/junegunn/fzf"
  exit 1
fi

# Check for pup
if ! command -v pup &> /dev/null; then
  echo "pup is not installed. It's used for parsing data."
  echo "Installation instructions: https://github.com/ericchiang/pup"
  exit 1
fi

# Download the script only if previous checks passed
GOSEARCH_PATH="/usr/share/zsh/functions/Zle/gosearch"
echo "Downloading gosearch script..."
curl -L "$script_url" -o $GOSEARCH_PATH && \
    chmod +x $GOSEARCH_PATH

echo "Installation complete! gosearch can be found in: $GOSEARCH_PATH"
echo "For the current shell you might need to source $GOSEARCH_PATH"
