# Respond to All Code Reviews

This command helps you respond to all pending code review comments in batch.

## Purpose

Efficiently address code review feedback by:
- Analyzing all review comments
- Prioritizing feedback
- Making requested changes
- Responding to reviewers
- Tracking resolution status

## Usage

```
@respond-reviews
```

With filters:
```
@respond-reviews --pr 123
@respond-reviews --reviewer @username
@respond-reviews --priority high
```

## Process

1. **Fetch Comments**: Retrieve all unresolved review comments
2. **Analyze**: Categorize feedback (bug, style, question, suggestion)
3. **Prioritize**: Order by impact and urgency
4. **Plan**: Create action plan for each comment
5. **Execute**: Make code changes
6. **Respond**: Reply to each comment
7. **Verify**: Ensure all feedback addressed

## Comment Categories

### Required Changes
- Bugs that must be fixed
- Security issues
- Breaking changes
- Test failures

### Improvements
- Performance optimizations
- Code quality enhancements
- Better error handling
- Refactoring suggestions

### Questions
- Clarification requests
- Design discussions
- Implementation alternatives
- Trade-off considerations

### Style/Minor
- Formatting
- Naming conventions
- Comments/documentation
- Code organization

## Response Strategy

### For Bugs
```
Fixed in commit abc123.

Changed X to Y because [reason].
Added test case to prevent regression.
```

### For Improvements
```
Good catch! Implemented in commit def456.

Refactored function to improve readability.
Performance improved by ~20%.
```

### For Questions
```
Great question. The reason we use X instead of Y is [explanation].

Happy to discuss further if you have concerns.
```

### For Style
```
Updated in commit ghi789.

Applied consistent naming throughout the module.
```

## Configuration

In `.claude/settings.json`:

```json
{
  "code_review_response": {
    "enabled": true,
    "auto_respond": false,
    "response_style": "professional",
    "include_commit_refs": true,
    "mark_resolved": true,
    "notify_reviewers": true,
    "batch_size": 10
  }
}
```

## Batch Processing

Handle multiple PRs:
```
@respond-reviews --all
```

Process by priority:
```
@respond-reviews --priority high --first
```

## Response Templates

### Acknowledgment
```
Thanks for the feedback! I've addressed this in commit {hash}.
```

### Agreement with Changes
```
Good point. Updated to use {approach} instead. See commit {hash}.
```

### Disagreement with Explanation
```
I considered {suggestion}, but opted for {current_approach} because {reason}.
Let me know if you'd like to discuss further.
```

### Need More Info
```
Could you clarify {question}? I want to make sure I understand the concern correctly.
```

### Deferred
```
Agreed this would be good. Created issue #{number} to track.
Let's address in a follow-up PR to keep this focused.
```

## Automation Features

### Smart Responses
- Context-aware replies
- Consistent tone
- Include relevant details
- Reference commits

### Change Tracking
- Links commits to comments
- Marks resolved automatically
- Updates PR description
- Notifies reviewers

### Quality Checks
- Verify all comments addressed
- Ensure changes tested
- Check for regressions
- Validate build passes

## Workflow

```
@respond-reviews

Output:
📋 Found 8 review comments across 3 PRs

PR #123: feat: Add authentication
  🔴 High Priority (2)
    - Comment by @alice: Security issue with token storage
    - Comment by @bob: Missing error handling
  
  🟡 Medium Priority (2)
    - Comment by @alice: Consider using async/await
    - Comment by @carol: Add JSDoc comments
  
  🟢 Low Priority (1)
    - Comment by @bob: Rename variable for clarity

PR #124: fix: Resolve login bug
  🔴 High Priority (1)
    - Comment by @alice: Test case missing
  
  🟡 Medium Priority (2)
    - Comment by @bob: Could simplify logic
    - Comment by @carol: Update documentation

Processing...

✅ PR #123 - Comment 1: Fixed token storage [commit: abc123]
✅ PR #123 - Comment 2: Added error handling [commit: def456]
✅ PR #123 - Comment 3: Refactored to async/await [commit: ghi789]
...

Summary:
✅ Resolved: 7
💬 Responded: 8
🔄 Follow-up needed: 1
```

## Best Practices

1. **Address High Priority First**: Fix bugs and security issues immediately
2. **Be Respectful**: Thank reviewers for their time
3. **Explain Reasoning**: Don't just make changes, explain why
4. **Test Changes**: Verify fixes work as expected
5. **Ask Questions**: Clarify unclear feedback
6. **Stay Professional**: Maintain constructive dialogue
7. **Follow Up**: Ensure reviewers are satisfied

## Integration

### With GitHub
- Fetches comments via API
- Posts responses automatically
- Marks conversations resolved
- Updates PR status

### With JIRA
- Links code review items
- Creates follow-up tickets
- Tracks technical debt
- Reports metrics

### With Slack
- Notifies on completion
- Alerts for blockers
- Shares summaries
- Coordinates with team

## Metrics

Track review response:
- Time to first response
- Resolution rate
- Re-review requests
- Reviewer satisfaction

## Advanced Options

### Dry Run
```
@respond-reviews --dry-run
```
Preview responses without posting

### Focus Mode
```
@respond-reviews --focus-pr 123
```
Handle specific PR only

### Reviewer Filter
```
@respond-reviews --reviewer @alice
```
Address specific reviewer's comments

### Time-Based
```
@respond-reviews --since 24h
```
Handle recent comments only

## Conflict Resolution

When reviewers disagree:
1. Acknowledge both perspectives
2. Present technical analysis
3. Suggest compromise if possible
4. Escalate to team lead if needed

## Quality Gates

Before marking resolved:
- [ ] Code change made
- [ ] Tests updated
- [ ] Documentation updated
- [ ] Build passes
- [ ] Response posted
- [ ] Reviewer notified

## Troubleshooting

### Can't Post Response
- Check GitHub permissions
- Verify API token
- Review rate limits

### Comment Not Found
- Refresh PR state
- Check comment thread
- Verify PR not closed

### Changes Not Applied
- Review commit history
- Check branch status
- Verify push succeeded

## See Also

- `@pr-comments` - Detailed PR comment workflow
- `@auto-merge-prs` - Auto-merge approved PRs
- Code review guidelines in `specs/code-standards.md`
