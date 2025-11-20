# Work on Ticket - Respond to PR Comments

This command helps you efficiently respond to pull request comments and feedback.

## Purpose

Handle PR comments by:
- Analyzing all feedback
- Making requested changes
- Responding to questions
- Resolving discussions
- Getting approval

## Usage

```
@pr-comments <pr-number>
```

Examples:
```
@pr-comments 456
@pr-comments --current
@pr-comments 456 --reviewer @alice
```

## Workflow

### 1. Comment Analysis
```
@pr-comments 456

PR #456: Add user profile page
Branch: feature/PROJ-123
Status: Changes Requested

Found 7 comments from 2 reviewers:

Alice (@alice) - 5 comments:
🔴 REQUIRED (2):
  1. Line 45: Security - Validate user input before saving
  2. Line 78: Bug - Handle null avatar case

🟡 SUGGESTION (2):
  3. Line 23: Consider using useMemo for performance
  4. Line 102: Extract to separate component

🟢 QUESTION (1):
  5. Line 56: Why async here? Not awaiting anything

Bob (@bob) - 2 comments:
🟡 SUGGESTION (1):
  6. Line 34: Add error boundary

🟢 PRAISE (1):
  7. Line 67: Nice use of TypeScript generics!

Priority Order: 1, 2, 5, 3, 4, 6
```

### 2. Planning Response
```
Response Plan:

Immediate (Critical):
1. Comment #1 (Alice): Add input validation
   Action: Add Yup schema validation
   Estimate: 30 minutes

2. Comment #2 (Alice): Fix null avatar
   Action: Add null check and default avatar
   Estimate: 15 minutes

3. Comment #5 (Alice): Explain async usage
   Action: Respond with explanation or refactor
   Estimate: 10 minutes

Follow-up (Improvements):
4. Comment #3 (Alice): Add useMemo
   Action: Optimize with useMemo
   Estimate: 20 minutes

5. Comment #4 (Alice): Extract component
   Action: Create AvatarUpload component
   Estimate: 45 minutes

6. Comment #6 (Bob): Add error boundary
   Action: Wrap in ErrorBoundary
   Estimate: 15 minutes

7. Comment #7 (Bob): Acknowledge praise
   Action: Thank reviewer
   Estimate: 2 minutes

Total Estimate: 2.5 hours
```

### 3. Making Changes
```
Implementing changes...

✓ Comment #1: Input validation added
  - Added Yup validation schema
  - Validated before API call
  - Added error messages
  - Commit: a1b2c3d

✓ Comment #2: Null avatar handling
  - Added null check
  - Used default avatar constant
  - Added test case
  - Commit: e4f5g6h

✓ Comment #5: Removed unnecessary async
  - Refactored to sync function
  - Cleaner code
  - Commit: i7j8k9l

✓ Comment #3: Performance optimization
  - Added useMemo for expensive computation
  - Measured improvement
  - Commit: m1n2o3p

✓ Comment #4: Extracted component
  - Created AvatarUpload.tsx
  - Improved reusability
  - Added tests
  - Commit: q4r5s6t

✓ Comment #6: Error boundary added
  - Wrapped in ErrorBoundary
  - Added fallback UI
  - Commit: u7v8w9x

All changes committed and pushed.
```

### 4. Responding
```
Posting responses...

✓ Comment #1:
"Good catch! Added Yup validation schema. See a1b2c3d."

✓ Comment #2:
"Fixed in e4f5g6h. Now handles null case with default avatar."

✓ Comment #5:
"You're right! Removed async as we're not awaiting anything. See i7j8k9l."

✓ Comment #3:
"Great suggestion! Added useMemo, reduced re-renders by ~30%. See m1n2o3p."

✓ Comment #4:
"Agreed. Extracted AvatarUpload component for reusability. See q4r5s6t."

✓ Comment #6:
"Added ErrorBoundary wrapper with fallback UI. See u7v8w9x."

✓ Comment #7:
"Thanks! Tried to keep it type-safe and clean."

All comments addressed. Requesting re-review.
```

### 5. Verification
```
Pre-Review Checklist:

✓ All comments addressed
✓ All tests passing
✓ Linter clean
✓ Build successful
✓ Changes pushed
✓ Responses posted
✓ Discussions resolved
✓ Re-review requested

Ready for approval.
```

## Comment Types

### Required Changes
Handle immediately:
```
Comment: "This will cause a memory leak"

Response:
1. Acknowledge: "You're absolutely right"
2. Fix: Make the change
3. Explain: "Fixed by adding cleanup in useEffect"
4. Reference: "See commit abc123"
5. Test: "Added test to prevent regression"
```

### Suggestions
Evaluate and implement:
```
Comment: "Consider using X instead of Y"

Response:
If adopting:
"Great idea! Implemented X in commit abc123. 
It's cleaner and more performant."

If not adopting:
"Thanks for the suggestion! I considered X, but went 
with Y because [reason]. Happy to discuss further."
```

### Questions
Provide clear answers:
```
Comment: "Why did you choose approach A?"

Response:
"Good question! I chose A because:
1. Better performance for our use case
2. More maintainable
3. Consistent with rest of codebase

Alternative B would work but has [tradeoff].
Let me know if you'd like me to reconsider."
```

### Nitpicks
Address quickly:
```
Comment: "Typo in variable name"

Response:
"Fixed in commit abc123."

or

Comment: "Add space after comma"

Response:
"Done."
```

## Best Practices

### Timely Response
- Respond within 24 hours
- Prioritize by severity
- Don't wait for all answers
- Update as you progress

### Professional Tone
✓ "Good catch!"
✓ "Thanks for the feedback"
✓ "You're right, I'll fix that"
✓ "Great suggestion"

✗ "That's wrong"
✗ "I disagree"
✗ "This is fine as-is"
✗ Defensive responses

### Clear Communication
```
Good Response:
"Added null check in commit abc123. The function now 
returns a default value when user is undefined. Added 
test case to verify behavior."

Poor Response:
"Fixed."
```

### Show Your Work
```
Include:
✓ What you changed
✓ Why you changed it
✓ Commit reference
✓ Test coverage
✓ Impact assessment

Avoid:
✗ Vague responses
✗ Missing context
✗ No commit refs
✗ Untested changes
```

## Response Templates

### Bug Fix
```
Fixed in commit {hash}.

Changed:
- {What was wrong}
- {What you changed}
- {How you tested}

Added test case to prevent regression.
```

### Refactoring
```
Refactored in commit {hash}.

Improvements:
- {Specific improvement 1}
- {Specific improvement 2}

Benefits:
- {Benefit 1}
- {Benefit 2}
```

### Performance
```
Optimized in commit {hash}.

Changes:
- {What you optimized}
- {How you optimized}

Results:
- {Metric before} → {Metric after}
- {Percentage improvement}
```

### Explanation
```
Great question!

{Direct answer}

Reasoning:
- {Reason 1}
- {Reason 2}

Alternative considered: {Alternative}
Reason not chosen: {Tradeoff}

Happy to discuss further if you have concerns.
```

## Handling Disagreements

### Respectful Disagreement
```
I understand your concern. I considered {suggestion} 
but opted for {current approach} because:

1. {Technical reason}
2. {Business reason}
3. {Consistency reason}

However, I'm open to changing if you feel strongly.
What do you think?
```

### Seeking Consensus
```
Both approaches have merit:

Option A (current):
+ {Benefit 1}
+ {Benefit 2}
- {Drawback}

Option B (suggested):
+ {Benefit 1}
- {Drawback 1}
- {Drawback 2}

@tech-lead, what's your preference?
```

### Deferring Discussion
```
This is a good point that deserves more discussion.
I've created issue #XYZ to track it.

For this PR, I'll stick with {current approach} to 
keep the scope focused. We can address in a follow-up.

Does that sound reasonable?
```

## Automation

### Auto-Resolve Simple Issues
```
Auto-resolvable:
- Formatting issues (apply linter)
- Simple typos (auto-correct)
- Missing comments (generate)
- Import ordering (auto-fix)
```

### Smart Responses
```
AI-generated response drafts:
- Context-aware
- Professional tone
- Include commit refs
- Suggest improvements
```

## Configuration

```json
{
  "pr_response": {
    "enabled": true,
    "auto_resolve_simple": true,
    "response_tone": "professional",
    "include_commits": true,
    "request_rereviewed": true,
    "max_response_time": "24h"
  }
}
```

## Metrics

Track your responsiveness:
- Average response time
- Resolution rate
- Re-review requests
- Approval rate
- Comment quality score

## Troubleshooting

### Can't Reproduce Issue
```
"I'm having trouble reproducing this issue.

What I tried:
1. {Step 1}
2. {Step 2}
3. {Step 3}

Could you provide:
- Steps to reproduce
- Expected vs actual behavior
- Environment details

Happy to pair debug if needed."
```

### Unclear Feedback
```
"Thanks for the feedback! Could you clarify:

- {Specific question about feedback}
- {What specifically needs to change}

Want to make sure I address your concern correctly."
```

### Conflicting Feedback
```
"I'm getting conflicting feedback:

@alice suggested: {Approach A}
@bob suggested: {Approach B}

Both have merit. Could you two sync on preferred 
approach? Happy to implement either way."
```

## See Also

- `@respond-reviews` - Batch PR responses
- `@engineer` - Engineer workflow
- Code review guidelines in `specs/code-standards.md`
