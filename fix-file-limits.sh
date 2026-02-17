#!/bin/bash
# Fix for "too many open files" error on macOS
# Run this script or add these lines to your ~/.zshrc or ~/.bash_profile

# Check current limits
launchctl limit maxfiles

# Set higher file descriptor limits (requires sudo)
# These settings will persist after reboot
sudo launchctl limit maxfiles 65536 200000

# Alternative: Add to your shell profile without sudo
# Add these lines to ~/.zshrc or ~/.bashrc:
# ulimit -n 65536
# ulimit -u 2048

echo "Current limits set. Add 'ulimit -n 65536' to your shell profile for permanent fix."
