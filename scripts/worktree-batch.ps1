<#
.SYNOPSIS
    Set up multiple Git worktrees in batch
.DESCRIPTION
    Creates multiple git worktrees from a list of branches or a file.
.EXAMPLE
    .\worktree-batch.ps1 feature/auth feature/dashboard
.EXAMPLE
    .\worktree-batch.ps1 -FromFile branches.txt
#>

param (
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Branches,

    [string]$FromFile
)

$ErrorActionPreference = "Stop"
$WorktreesDir = "..\worktrees"

if ($FromFile) {
    if (-not (Test-Path $FromFile)) {
        Write-Error "Error: File not found: $FromFile"
        exit 1
    }
    
    Write-Host "📄 Reading branches from: $FromFile"
    $Branches = Get-Content $FromFile | Where-Object { $_ -notmatch '^#' -and $_ -notmatch '^\s*$' }
}

if (-not $Branches) {
    Write-Host "Usage: .\worktree-batch.ps1 <branch1> <branch2> ..."
    Write-Host "   or: .\worktree-batch.ps1 -FromFile branches.txt"
    Write-Host ""
    Write-Host "branches.txt format:"
    Write-Host "  feature/auth"
    Write-Host "  feature/dashboard"
    Write-Host "  bugfix/login-issue"
    exit 1
}

# Create worktrees directory if it doesn't exist
if (-not (Test-Path $WorktreesDir)) {
    New-Item -ItemType Directory -Path $WorktreesDir -Force | Out-Null
}

Write-Host "🌳 Setting up multiple worktrees..."
Write-Host "📁 Base directory: $WorktreesDir"
Write-Host ""

$success = 0
$failed = 0

foreach ($branch in $Branches) {
    # Skip empty lines and comments (already filtered if from file, but good for args too)
    if ([string]::IsNullOrWhiteSpace($branch) -or $branch -match '^#') { continue }
    
    $worktreeName = Split-Path $branch -Leaf
    $worktreePath = Join-Path $WorktreesDir $worktreeName
    
    Write-Host "➤ Setting up: $branch"
    
    # Check if worktree already exists
    if (Test-Path $worktreePath) {
        Write-Host "  ⚠️  Worktree already exists at: $worktreePath"
        Write-Host "  Skipping..."
        Write-Host ""
        continue
    }
    
    # Try to create worktree
    $scriptPath = Join-Path $PSScriptRoot "worktree.ps1"
    try {
        & $scriptPath $branch $worktreePath | Out-Null
        if ($LASTEXITCODE -eq 0) {
             Write-Host "  ✓ Created: $worktreePath"
             $success++
        } else {
             throw "Failed"
        }
    } catch {
        Write-Host "  ✗ Failed to create worktree"
        $failed++
    }
    
    Write-Host ""
}

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "✨ Batch setup complete!"
Write-Host "  Success: $success"
if ($failed -gt 0) {
    Write-Host "  Failed:  $failed"
}
Write-Host ""
Write-Host "📂 All worktrees:"
git worktree list
