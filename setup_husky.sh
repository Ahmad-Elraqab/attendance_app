#!/bin/bash

# Install Husky (if not already done)
if ! command -v husky &> /dev/null; then
  echo "Installing Husky..."
  fvm flutter pub add --dev husky
else
  echo "Husky already installed."
fi

# Install Husky hooks
echo "Installing Husky hooks..."
dart run husky install

# Create pre-commit file (if not already created)
if [ ! -f ".husky/pre-commit" ]; then
  echo "Creating pre-commit file..."
  # Generate pre-commit with commitlint (optional)
  # npx commitlint --generate

  # Alternative: Manually create pre-commit file
  echo "Using manual pre-commit file..."
  cat << EOF > ".husky/pre-commit"
# Check for LIN with FEAT or FIX in commit message
- msg: "Commit message must include 'FEAT' or 'FIX' along with 'LIN'"
  script: |
    # Use a descriptive regex for stricter checking
    if [[ ! \$MESSAGE =~ ^(feat|fix)(.*LIN.*)$ ]]; then
      echo "ERROR: Commit message must include 'FEAT' or 'FIX' along with 'LIN'."
      exit 1
    fi
EOF
else
  echo "pre-commit file already exists."
fi

# Set executable permissions for pre-commit
echo "Setting permissions..."
chmod +x ".husky/pre-commit"

# Verify core.hooksPath configuration
hooks_path=$(git config core.hooksPath)
if [ "$hooks_path" != ".husky" ]; then
  echo "WARNING: core.hooksPath is not set to .husky. Setting it now..."
  git config core.hooksPath ".husky"
fi

echo "Husky pre-commit hook setup complete!"
echo "Remember to test the hook by attempting a commit with incorrect and correct messages."
