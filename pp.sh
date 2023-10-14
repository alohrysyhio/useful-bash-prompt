#!/bin/bash

# Function to get the current git branch
get_git_branch() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
        echo "$branch"
    fi
}

# Function to get the current git status
get_git_status() {
    if [[ -z $(git status --porcelain 2>/dev/null) ]]; then
        echo "✔" # Git repository is clean
    else
        echo "✘" # Git repository has uncommitted changes
    fi
}

# Function to get the number of staged changes in the current Git repository
get_staged_changes() {
    # Get the number of staged changes
    local staged_changes=$(git diff --cached --numstat | wc -l)
    # Check if there are staged changes
    if [[ "$staged_changes" -gt 0 ]]; then
        echo " $staged_changes:s"
    fi
}

# Function to get the number of unstaged changes in the current Git repository
get_unstaged_changes() {
    # Get the number of unstaged changes
    local unstaged_changes=$(git diff --numstat | wc -l)
    # Check if there are unstaged changes
    if [[ "$unstaged_changes" -gt 0 ]]; then
        echo " $unstaged_changes:!s"
    fi
}

# Function to get the number of untracked files in the current Git repository
get_untracked_files() {
    # Get the number of untracked files
    local untracked_files=$(git ls-files --others --exclude-standard --directory --no-empty-directory -o | wc -l)
    # Check if there are untracked files
    if [[ "$untracked_files" -gt 0 ]]; then
        echo " $untracked_files:?s"
    fi
}

# Function to set the prompt
set_prompt() {
    local user="$(whoami)"
    local host="$(hostname)"
    local current_dir="\w"
    local in="┌ in"
    local at="@"
    local line_start="└"
    local colon="\$ "

    #Variables of git
    local on=""
    local git_branch=""
    local git_status=""
    local changes_tracking=""

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        on="on"
        git_branch=$(get_git_branch)
        git_status=$(get_git_status)
        changes_tracking=$(get_unstaged_changes)$(get_staged_changes)$(get_untracked_files)
    fi

    PS1="$in $current_dir $on $git_branch $git_status$changes_tracking\n$line_start $user$at$host $colon"
}

# Call the set_prompt function
PROMPT_COMMAND=set_prompt

# Set PROMPT_DIRTRIM
PROMPT_DIRTRIM=3
