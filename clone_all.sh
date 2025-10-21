#!/bin/bash

#########################################
# Usage:
#   Normal mode (stops on first error)
#   ./clone_all.sh

#   Force mode (continues despite errors)
#   ./clone_all.sh -f
#########################################
 
# Student GH username list - one per newline
LIST_FILE="student_gh_usernames.txt"
ORGANIZATION="UWSEDS"
HOMEWORK_NAME="homework-0-"

# Parse command-line arguments
FORCE=false
while getopts "f" opt; do
    case $opt in
        f)
            FORCE=true
            ;;
        \?)
            echo "Usage: $0 [-f]" >&2
            echo "  -f: Force mode - continue on errors" >&2
            exit 1
            ;;
    esac
done

# Initialize counters and arrays
success_count=0
failed_users=()

# Read file line by line
while IFS= read -r name || [ -n "$name" ]; do
    # Trim whitespace
    name=$(echo "$name" | xargs)
    
    # Skip empty lines
    if [ -z "$name" ]; then
        continue
    fi
    
    repo_url="git@github.com:${ORGANIZATION}/${HOMEWORK_NAME}${name}.git"
    
    # Attempt to clone
    if git clone "$repo_url" 2>&1; then
        echo ""
        ((success_count++))
    else
        failed_users+=("$name")
        if [ "$FORCE" = false ]; then
            echo "Failed to clone repository for $name" >&2
            echo "Stopping due to error. Use -f flag to continue on errors." >&2
            exit 1
        fi
        echo "Continuing despite error (force mode enabled)..."
    fi
    echo ""
done < "$LIST_FILE"

echo "Done processing all entries."

# Print summary if in force mode
if [ "$FORCE" = true ]; then
    echo "=========================================="
    echo "SUMMARY"
    echo "=========================================="
    echo "Successful clones: $success_count"
    
    if [ ${#failed_users[@]} -eq 0 ]; then
        echo "Failed clones: 0"
    else
        echo "Failed clones: ${#failed_users[@]}"
        echo ""
        echo "Failed usernames:"
        for user in "${failed_users[@]}"; do
            echo "  - $user"
        done
    fi
    echo "=========================================="
fi
