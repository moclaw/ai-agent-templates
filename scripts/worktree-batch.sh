#!/bin/bash

# Set up multiple Git worktrees in batch
# Usage: ./setup-worktree-batch.sh <branch1> <branch2> ...
#    or: ./setup-worktree-batch.sh --from-file branches.txt

set -e

WORKTREES_DIR="../worktrees"

if [ "$1" = "--from-file" ]; then
  if [ -z "$2" ] || [ ! -f "$2" ]; then
    echo "Error: File not found: $2"
    exit 1
  fi
  
  echo "📄 Reading branches from: $2"
  branches=$(cat "$2" | grep -v '^#' | grep -v '^$')
else
  branches="$@"
fi

if [ -z "$branches" ]; then
  echo "Usage: ./setup-worktree-batch.sh <branch1> <branch2> ..."
  echo "   or: ./setup-worktree-batch.sh --from-file branches.txt"
  echo ""
  echo "branches.txt format:"
  echo "  feature/auth"
  echo "  feature/dashboard"
  echo "  bugfix/login-issue"
  exit 1
fi

# Create worktrees directory if it doesn't exist
mkdir -p "$WORKTREES_DIR"

echo "🌳 Setting up multiple worktrees..."
echo "📁 Base directory: $WORKTREES_DIR"
echo ""

success=0
failed=0

for branch in $branches; do
  # Skip empty lines and comments
  [[ -z "$branch" || "$branch" =~ ^#.* ]] && continue
  
  worktree_name=$(basename "$branch")
  worktree_path="$WORKTREES_DIR/$worktree_name"
  
  echo "➤ Setting up: $branch"
  
  # Check if worktree already exists
  if [ -d "$worktree_path" ]; then
    echo "  ⚠️  Worktree already exists at: $worktree_path"
    echo "  Skipping..."
    echo ""
    continue
  fi
  
  # Try to create worktree
  if ./scripts/setup-worktree.sh "$branch" "$worktree_path" > /dev/null 2>&1; then
    echo "  ✓ Created: $worktree_path"
    ((success++))
  else
    echo "  ✗ Failed to create worktree"
    ((failed++))
  fi
  
  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✨ Batch setup complete!"
echo "  Success: $success"
if [ $failed -gt 0 ]; then
  echo "  Failed:  $failed"
fi
echo ""
echo "📂 All worktrees:"
git worktree list
