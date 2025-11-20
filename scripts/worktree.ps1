<#
.SYNOPSIS
    Set up a Git worktree for a branch
.DESCRIPTION
    Creates a new git worktree for the specified branch.
.EXAMPLE
    .\worktree.ps1 feature/new-auth
.EXAMPLE
    .\worktree.ps1 feature/new-auth ..\worktrees\new-auth
#>

param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Branch,

    [Parameter(Position=1)]
    [string]$WorktreePath
)

$ErrorActionPreference = "Stop"

if (-not $WorktreePath) {
    $WorktreePath = Join-Path "..\worktrees" (Split-Path $Branch -Leaf)
}

Write-Host "🌳 Setting up worktree for branch: $Branch"
Write-Host "📁 Worktree path: $WorktreePath"
Write-Host ""

# Check if branch exists remotely
git show-ref --verify --quiet "refs/remotes/origin/$Branch"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Branch exists remotely, checking out..."
    git worktree add "$WorktreePath" "$Branch"
} else {
    git show-ref --verify --quiet "refs/heads/$Branch"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Branch exists locally, checking out..."
        git worktree add "$WorktreePath" "$Branch"
    } else {
        Write-Host "ℹ️  Branch doesn't exist, creating new branch..."
        git worktree add "$WorktreePath" -b "$Branch"
    }
}

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create worktree."
    exit 1
}

Set-Location "$WorktreePath"

Write-Host ""
Write-Host "✨ Worktree setup complete!"
Write-Host ""
Write-Host "📂 Worktree location: $WorktreePath"
Write-Host "🌿 Branch: $(git branch --show-current)"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  cd $WorktreePath"
Write-Host "  # Make your changes"
Write-Host "  # When done: cd -; git worktree remove $WorktreePath"
