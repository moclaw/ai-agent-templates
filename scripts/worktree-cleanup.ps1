<#
.SYNOPSIS
    Clean up Git worktrees that are no longer needed
.DESCRIPTION
    Removes worktrees for branches that have been merged or deleted remotely.
.EXAMPLE
    .\worktree-cleanup.ps1
#>

$ErrorActionPreference = "Stop"

Write-Host "🧹 Cleaning up Git worktrees..."

# Get list of all worktrees
$worktrees = git worktree list --porcelain | Select-String "^worktree " | ForEach-Object { $_.ToString().Split(' ')[1] }

# Main repo path
$mainRepo = git rev-parse --show-toplevel

Write-Host "Main repository: $mainRepo"
Write-Host ""

# Count worktrees cleaned
$cleaned = 0

foreach ($worktree in $worktrees) {
    # Skip main repository
    if ($worktree -eq $mainRepo) {
        continue
    }
    
    Write-Host "Checking worktree: $worktree"
    
    # Check if worktree directory exists
    if (-not (Test-Path $worktree)) {
        Write-Host "  ⚠️  Directory doesn't exist, removing worktree reference"
        git worktree remove "$worktree" --force
        $cleaned++
        continue
    }
    
    # Check if worktree branch was merged or deleted
    Push-Location "$worktree"
    $branch = git branch --show-current
    Pop-Location
    
    if (-not $branch) {
        Write-Host "  ⚠️  Detached HEAD state, skipping"
        continue
    }
    
    # Check if branch exists in remote
    git show-ref --verify --quiet "refs/remotes/origin/$branch"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ✓ Branch '$branch' not in remote, removing worktree"
        git worktree remove "$worktree" --force
        $cleaned++
        continue
    }
    
    # Check if branch is merged to main
    $merged = git branch --merged main | Select-String "^\s*$branch$"
    if ($merged) {
        Write-Host "  ✓ Branch '$branch' merged to main, removing worktree"
        git worktree remove "$worktree" --force
        $cleaned++
        continue
    }
    
    Write-Host "  ℹ️  Keeping worktree for branch '$branch'"
}

Write-Host ""
Write-Host "✨ Cleanup complete! Removed $cleaned worktree(s)"

# Prune worktree references
git worktree prune

Write-Host "🎉 Done!"
