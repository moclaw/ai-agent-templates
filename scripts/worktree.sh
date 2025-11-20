#!/bin/bash

# Set up a Git worktree for a branch
# Usage: ./setup-worktree.sh <branch-name> [worktree-path]

set -e

if [ -z "$1" ]; then
  echo "Usage: ./setup-worktree.sh <branch-name> [worktree-path]"
  echo ""
  echo "Examples:"
  echo "  ./setup-worktree.sh feature/new-auth"
  echo "  ./setup-worktree.sh feature/new-auth ../worktrees/new-auth"
  exit 1
fi

BRANCH=$1
WORKTREE_PATH=${2:-"../worktrees/$(basename $BRANCH)"}

echo "🌳 Setting up worktree for branch: $BRANCH"
echo "📁 Worktree path: $WORKTREE_PATH"
echo ""

# Check if branch exists remotely
if git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
  echo "✓ Branch exists remotely, checking out..."
  git worktree add "$WORKTREE_PATH" "$BRANCH"
elif git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  echo "✓ Branch exists locally, checking out..."
  git worktree add "$WORKTREE_PATH" "$BRANCH"
else
  echo "ℹ️  Branch doesn't exist, creating new branch..."
  git worktree add "$WORKTREE_PATH" -b "$BRANCH"
fi

cd "$WORKTREE_PATH"

echo ""
echo "✨ Worktree setup complete!"
echo ""
echo "📂 Worktree location: $WORKTREE_PATH"
echo "🌿 Branch: $(git branch --show-current)"
echo ""
echo "Next steps:"
echo "  cd $WORKTREE_PATH"
echo "  # Make your changes"
echo "  # When done: cd - && git worktree remove $WORKTREE_PATH"
