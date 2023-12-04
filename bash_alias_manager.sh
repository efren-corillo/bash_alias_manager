#!/bin/bash

# JSON file containing aliases
ALIASES_FILE="./aliases.json"

# 1. check if ~/.bash_aliases exists. reset if it does, create if it doesn't.
if [ -f ~/.bash_aliases ]; then
    > ~/.bash_aliases
else
    touch ~/.bash_aliases
fi

# 2. read and add aliases from the JSON file
if [ -f "$ALIASES_FILE" ]; then
    while read -r alias command; do
        # Remove existing alias from ~/.bashrc
        sed -i "/alias $alias=/d" ~/.bashrc

        # Add new alias to ~/.bash_aliases
        echo "alias $alias='$command'" >> ~/.bash_aliases
    done < <(jq -r '.aliases | to_entries[] | .key + " " + .value' $ALIASES_FILE)
else
    echo "Aliases file not found: $ALIASES_FILE"
    exit 1
fi

# 3. source the ~/.bash_aliases and ~/.bashrc files
source ~/.bash_aliases
source ~/.bashrc
