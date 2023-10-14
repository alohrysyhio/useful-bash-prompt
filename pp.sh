#!/bin/bash

# Function to get the current git branch
get_git_branch() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
        echo "on $branch"
    fi
}

# Function to get the current git status
get_git_status() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        if [[ -z $(git status --porcelain 2>/dev/null) ]]; then
            echo "✔" # Git repository is clean
        else
            echo "✘" # Git repository has uncommitted changes
        fi
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
    local git_status=$(get_git_status)

    PS1="$in $current_dir $git_branch $git_status\n$at $user_host $colon"
}

# Call the set_prompt function
PROMPT_COMMAND=set_prompt

# Set PROMPT_DIRTRIM
PROMPT_DIRTRIM=3
