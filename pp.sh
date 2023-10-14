#!/bin/bash

# Function to get the current git branch
get_git_branch() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
        echo "on $branch"
    fi
}

# Function to set the prompt
set_prompt() {
    local user_host="$(whoami)@$(hostname)"
    local current_dir="\w"
    local in="┌ in"
    local at="└"
    local colon="\$ "
    local git_branch=$(get_git_branch)

    PS1="$in $current_dir $git_branch\n$at $user_host $colon"
}

# Call the set_prompt function
PROMPT_COMMAND=set_prompt

# Set PROMPT_DIRTRIM
PROMPT_DIRTRIM=3
