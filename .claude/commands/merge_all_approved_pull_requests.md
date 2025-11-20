# Merge All Approved Pull Requests

This command automatically merges all approved pull requests in batch.

## Purpose

Streamline the PR merge process by automatically merging all PRs that have been approved by reviewers, saving time and reducing manual work.

## Usage

```
@merge_all_approved_pull_requests
```

With options:
```
@merge_all_approved_pull_requests --branch main --squash
```

## Prerequisites

- GitHub CLI (`gh`) configured
- Appropriate repository permissions
- PRs must have required approvals
- CI/CD checks must pass

## Process

1. **Fetch Approved PRs**: Query GitHub for approved PRs
2. **Validation**: Check each PR meets merge criteria:
   - Has required approvals
   - All CI checks passing
   - No merge conflicts
   - Branch is up to date
3. **Merge Strategy**: Apply configured merge strategy
4. **Cleanup**: Optionally delete merged branches
5. **Notification**: Report merge results

## Merge Criteria

A PR is eligible for auto-merge if:
- ✅ Minimum approvals met (default: 1)
- ✅ All required checks passing
- ✅ No merge conflicts
- ✅ Branch is current with base
- ✅ No "do not merge" labels
- ✅ Not in draft state

## Configuration

In `.claude/settings.json`:

```json
{
  "auto_merge": {
    "enabled": true,
    "min_approvals": 1,
    "require_all_checks": true,
    "merge_method": "squash",
    "delete_branch": true,
    "protected_branches": ["main", "production"],
    "exclude_labels": ["wip", "do-not-merge", "needs-review"]
  }
}
```

## Merge Methods

### Squash (Default)
```
--squash
```
Combines all commits into one

### Merge Commit
```
--merge
```
Creates a merge commit

### Rebase
```
--rebase
```
Rebases and fast-forwards

## Filtering Options

### By Branch
```
@merge_all_approved_pull_requests --branch develop
```

### By Author
```
@merge_all_approved_pull_requests --author dependabot
```

### By Label
```
@merge_all_approved_pull_requests --label ready-to-merge
```

### Dry Run
```
@merge_all_approved_pull_requests --dry-run
```
Shows what would be merged without actually merging

## Safety Features

- **Dry Run Mode**: Preview before merging
- **Protected Branches**: Cannot merge to protected branches without override
- **Conflict Detection**: Skips PRs with conflicts
- **Rollback Support**: Can revert if issues detected
- **Audit Log**: All merges logged

## Output

```
Scanning for approved PRs...
Found 5 approved PRs

PR #123: feat: Add user authentication ✓
  - 2 approvals
  - All checks passed
  - Merging with squash...
  - ✅ Merged successfully

PR #124: fix: Resolve login bug ✓
  - 1 approval
  - All checks passed  
  - Merging with squash...
  - ✅ Merged successfully

PR #125: docs: Update README ⚠️
  - Has merge conflict
  - ⏭️ Skipped

Summary:
✅ Merged: 2
⏭️ Skipped: 1
❌ Failed: 0
```

## Error Handling

### Merge Conflict
- PR is skipped
- Author notified
- Manual resolution required

### Failed Checks
- PR is skipped
- Team notified
- Re-run checks suggested

### Permission Error
- Operation halts
- Admin notification sent

## Best Practices

1. **Review First**: Always review before auto-merging
2. **Use Labels**: Tag PRs ready for auto-merge
3. **Set Standards**: Define clear approval criteria
4. **Monitor Results**: Review merge logs regularly
5. **Test Integration**: Ensure CI covers critical paths

## Integration with CI/CD

Works with:
- GitHub Actions
- CircleCI
- Jenkins
- GitLab CI
- Travis CI

## Notifications

Configure notifications in settings:
- Slack webhook
- Email alerts
- GitHub notifications
- Custom webhooks

## Troubleshooting

### No PRs Found
- Check approval status
- Verify branch filters
- Review exclude labels

### Merge Failed
- Check CI status
- Review merge conflicts
- Verify permissions

### Unexpected Behavior
- Run with `--dry-run`
- Review configuration
- Check audit logs
