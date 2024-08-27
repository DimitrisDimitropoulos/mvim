#!/bin/env bash

# Define an associative array for plugins and their installation paths
declare -A plugins=(
	["savq/melange-nvim"]="start/melange-nvim"
	["ibhagwan/fzf-lua"]="start/fzf-lua"
	["lewis6991/gitsigns.nvim"]="start/gitsigns.nvim"
	["neovim/nvim-lspconfig"]="start/nvim-lspconfig"
	["echasnovski/mini.splitjoin"]="start/mini.splitjoin"
	["NvChad/nvim-colorizer.lua"]="opt/nvim-colorizer.lua"
	["nvim-treesitter/nvim-treesitter"]="start/nvim-treesitter"
)

# Navigate to the Neovim configuration directory
cd ~/.config/mvim/pack/mvim || exit

# Add each plugin as a submodule
for repo in "${!plugins[@]}"; do
	git submodule add "https://github.com/$repo.git" "${plugins[$repo]}"
done

# Initialize and update all submodules
git submodule update --init --recursive
