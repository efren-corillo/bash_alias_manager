#!/bin/bash

# Step 1: Check if ~/.bash_aliases exists. Reset if it does, create if it doesn't.
if [ -f ~/.bash_aliases ]; then
    > ~/.bash_aliases
else
    touch ~/.bash_aliases
fi

# Step 2:  Read and add aliases from the JSON file
if [ -f "$ALIASES_FILE" ]; then
    while read -r alias command; do
        echo "alias $alias='$command'" >> ~/.bash_aliases
    done < <(jq -r '.aliases | to_entries[] | .key + " " + .value' $ALIASES_FILE)
else
    echo "Aliases file not found: $ALIASES_FILE"
    exit 1
fi

# Add more aliases here as needed
# echo "alias your_alias='your_command'" >> ~/.bash_aliases

# Step 3: Source the ~/.bash_aliases file
source ~/.bash_aliases

# End of script
