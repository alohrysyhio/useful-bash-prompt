#!/bin/bash

# Function to set the prompt
set_prompt() {
    local user_host="$(whoami)@$(hostname)"
    local current_dir="\w"
    local in="┌ in"
    local at="└"
    local colon="\$ "

    PS1="$in $current_dir\n$at $user_host $colon"
}

# Call the set_prompt function
PROMPT_COMMAND=set_prompt

# Set PROMPT_DIRTRIM
PROMPT_DIRTRIM=3
