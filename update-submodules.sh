#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Error handling function
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Status message function
status_msg() {
    echo -e "${YELLOW}==>${NC} $1"
}

# Success message function
success_msg() {
    echo -e "${GREEN}==>${NC} $1"
}

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    error_exit "Not in a Git repository"
fi

# Initialize submodules
status_msg "Initializing submodules..."
git submodule update --init --recursive || error_exit "Failed to initialize submodules"
success_msg "Submodules initialized successfully"

# Set up remote tracking branches
status_msg "Setting up remote tracking branches..."
git submodule foreach 'git fetch origin && git remote set-head origin -a' || error_exit "Failed to set up remote tracking branches"
success_msg "Remote tracking branches set up successfully"

# Update submodules
status_msg "Updating submodules with remote changes..."
git submodule update --remote --merge || error_exit "Failed to update submodules"
success_msg "Submodules updated successfully"

status_msg "All operations completed successfully!"
exit 0

