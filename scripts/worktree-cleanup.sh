#!/bin/bash

# Clean up Git worktrees that are no longer needed
# Usage: ./cleanup-worktrees.sh

set -e

echo "🧹 Cleaning up Git worktrees..."

# Get list of all worktrees
worktrees=$(git worktree list --porcelain | grep "worktree" | cut -d' ' -f2)

# Main repo path
main_repo=$(git rev-parse --show-toplevel)

echo "Main repository: $main_repo"
echo ""

# Count worktrees cleaned
cleaned=0

for worktree in $worktrees; do
  # Skip main repository
  if [ "$worktree" = "$main_repo" ]; then
    continue
  fi
  
  echo "Checking worktree: $worktree"
  
  # Check if worktree directory exists
  if [ ! -d "$worktree" ]; then
    echo "  ⚠️  Directory doesn't exist, removing worktree reference"
    git worktree remove "$worktree" --force
    ((cleaned++))
    continue
  fi
  
  # Check if worktree branch was merged or deleted
  cd "$worktree"
  branch=$(git branch --show-current)
  
  if [ -z "$branch" ]; then
    echo "  ⚠️  Detached HEAD state, skipping"
    cd "$main_repo"
    continue
  fi
  
  cd "$main_repo"
  
  # Check if branch exists in remote
  if ! git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
    echo "  ✓ Branch '$branch' not in remote, removing worktree"
    git worktree remove "$worktree" --force
    ((cleaned++))
    continue
  fi
  
  # Check if branch is merged to main
  if git branch --merged main | grep -q "^\s*$branch$"; then
    echo "  ✓ Branch '$branch' merged to main, removing worktree"
    git worktree remove "$worktree" --force
    ((cleaned++))
    continue
  fi
  
  echo "  ℹ️  Keeping worktree for branch '$branch'"
done

echo ""
echo "✨ Cleanup complete! Removed $cleaned worktree(s)"

# Prune worktree references
git worktree prune

echo "🎉 Done!"
