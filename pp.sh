#!/bin/bash

# Define colors with bold
BOLD_GRAY="\[\e[1;90m\]"
BOLD_RED="\[\e[1;31m\]"
BOLD_LIGHT_RED="\[\e[1;91m\]"
BOLD_GREEN="\[\e[1;32m\]"
BOLD_LIGHT_GREEN="\[\e[1;92m\]"
BOLD_YELLOW="\[\e[1;33m\]"
BOLD_LIGHT_YELLOW="\[\e[1;93m\]"
BOLD_BLUE="\[\e[1;34m\]"
BOLD_LIGHT_BLUE="\[\e[1;94m\]"
BOLD_MAGENTA="\[\e[1;35m\]"
BOLD_LIGHT_MAGENTA="\[\e[1;95m\]"
BOLD_CYAN="\[\e[1;36m\]"
BOLD_LIGHT_CYAN="\[\e[1;96m\]"
BOLD_LIGHT_GRAY="\[\e[1;37m\]"
BOLD_WHITE="\[\e[1;97m\]"
RESET="\[\e[0m\]"

# Function to get the current git branch
get_git_branch() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
        echo "${BOLD_LIGHT_MAGENTA}$branch${RESET}"
    fi
}

# Function to get the current git status
get_git_status() {
    if [[ -z $(git status --porcelain 2>/dev/null) ]]; then
        echo "${BOLD_LIGHT_GREEN}✔${RESET}" # Git repository is clean
    else
        echo "${BOLD_LIGHT_RED}✘${RESET}" # Git repository has uncommitted changes
    fi
}

# Function to get the number of staged changes in the current Git repository
get_staged_changes() {
    # Get the number of staged changes
    local staged_changes=$(git diff --cached --numstat | wc -l)
    # Check if there are staged changes
    if [[ "$staged_changes" -gt 0 ]]; then
        echo " ${BOLD_GREEN}$staged_changes:s${RESET}"
    fi
}

# Function to get the number of unstaged changes in the current Git repository
get_unstaged_changes() {
    # Get the number of unstaged changes
    local unstaged_changes=$(git diff --numstat | wc -l)
    # Check if there are unstaged changes
    if [[ "$unstaged_changes" -gt 0 ]]; then
        echo " ${BOLD_YELLOW}$unstaged_changes:!s${RESET}"
    fi
}

# Function to get the number of untracked files in the current Git repository
get_untracked_files() {
    # Get the number of untracked files
    local untracked_files=$(git ls-files --others --exclude-standard --directory --no-empty-directory -o | wc -l)
    # Check if there are untracked files
    if [[ "$untracked_files" -gt 0 ]]; then
        echo " ${BOLD_RED}$untracked_files:%${RESET}"
    fi
}

# Function to set the prompt
set_prompt() {
    # Prompt elements with styles and colors
    local user="${BOLD_LIGHT_BLUE}$(whoami)${RESET}"
    local host="${BOLD_LIGHT_BLUE}$(hostname)${RESET}"
    local current_dir="${BOLD_LIGHT_YELLOW}\w${RESET}"
    local in="${BOLD_WHITE}┌ in${RESET}"
    local at="${BOLD_WHITE}@${RESET}"
    local line_start="${BOLD_WHITE}└${RESET}"
    local colon="${BOLD_WHITE}\$ ${RESET}"

    #Variables of git
    local on=""
    local git_branch=""
    local git_status=""
    local changes_tracking=""

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        on="${BOLD_WHITE}on${RESET}"
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
