# Work on Ticket - Engineer Role

This command activates the Engineer role for implementing features and fixing bugs.

## Purpose

The Engineer role focuses on:
- Implementing user stories
- Writing clean, tested code
- Following coding standards
- Documenting changes
- Collaborating with team

## Usage

```
@work_on_ticket_engineer <ticket-id>
```

Examples:
```
@work_on_ticket_engineer PROJ-123
@work_on_ticket_engineer "Add user profile page"
@work_on_ticket_engineer --continue
```

## Workflow

### 1. Ticket Analysis
```
@work_on_ticket_engineer PROJ-123

Loading ticket PROJ-123...

Title: Add user profile page
Type: Feature
Priority: High
Assignee: You

Description:
Create a user profile page that displays user information
and allows editing of basic details.

Acceptance Criteria:
✓ Display user name, email, avatar
✓ Edit button to enable editing
✓ Save changes to backend
✓ Cancel button to discard changes
✓ Form validation
✓ Error handling

Technical Notes:
- Use existing UserService API
- Follow component patterns in ui/components
- Match design in Figma (link)

Dependencies:
- UserService API completed
- Design approved

Estimated Effort: 5 hours
```

### 2. Planning
```
Implementation Plan:

Tasks:
1. Create ProfilePage component (1h)
   - Layout and structure
   - State management
   - Routing setup

2. Implement view mode (1h)
   - Fetch user data
   - Display fields
   - Loading states

3. Implement edit mode (1.5h)
   - Form inputs
   - Validation
   - Error handling

4. API integration (0.5h)
   - Save changes
   - Handle responses
   - Error states

5. Testing (1h)
   - Unit tests
   - Integration tests
   - Manual testing

6. Documentation (0.5h)
   - Component docs
   - Update changelog

Total: 5.5 hours (includes buffer)

Approach:
- Start with basic structure
- Iterate with functionality
- Test incrementally
- Refactor for quality
```

### 3. Implementation
```
Starting implementation...

✓ Created branch: feature/PROJ-123-user-profile
✓ Created ProfilePage.tsx
✓ Added route configuration
✓ Implemented view mode
✓ Added loading spinner
✓ Implemented edit mode
✓ Added form validation
✓ Integrated with UserService
✓ Added error handling
✓ Wrote unit tests (12 tests)
✓ Wrote integration test
✓ Updated documentation

✓ All tests passing
✓ Linter clean
✓ Build successful

Ready for code review.
```

### 4. Testing
```
Test Results:

Unit Tests: ✓ 12/12 passing
Coverage: 94%

Integration Tests: ✓ 3/3 passing

Manual Testing:
✓ View mode displays correctly
✓ Edit mode enables fields
✓ Validation works
✓ Save persists changes
✓ Cancel discards changes
✓ Error states display
✓ Loading states work
✓ Responsive design
✓ Accessibility checked
```

### 5. Code Review Prep
```
Creating pull request...

PR #456: Add user profile page

Description:
Implements PROJ-123: User profile page with view and edit modes.

Changes:
- Added ProfilePage component
- Integrated with UserService API
- Added comprehensive tests
- Updated documentation

Testing:
- Unit tests: 12 new tests
- Integration tests: 3 new tests
- Manual testing completed
- All acceptance criteria met

Screenshots:
[View mode screenshot]
[Edit mode screenshot]
[Validation screenshot]

Checklist:
✓ Code follows standards
✓ Tests written and passing
✓ Documentation updated
✓ Changelog updated
✓ No console errors
✓ Accessibility verified
✓ Design approved
✓ Ready for review

Related: PROJ-123
```

## Code Quality

### Standards Adherence
```
✓ Naming conventions followed
✓ TypeScript types defined
✓ Error handling implemented
✓ Input validation present
✓ No magic numbers/strings
✓ Comments where needed
✓ No console.logs
✓ Proper imports organization
```

### Testing Requirements
```
✓ Unit tests for components
✓ Unit tests for utilities
✓ Integration tests for flows
✓ Edge cases covered
✓ Error scenarios tested
✓ Mocking appropriate
✓ Test descriptions clear
```

### Documentation
```
✓ JSDoc comments on public APIs
✓ Component props documented
✓ Complex logic explained
✓ README updated if needed
✓ Changelog entry added
✓ Architecture docs updated
```

## Development Practices

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/PROJ-123-description

# Commit regularly with clear messages
git commit -m "feat(profile): add ProfilePage component"
git commit -m "test(profile): add ProfilePage tests"
git commit -m "docs(profile): update component documentation"

# Keep branch updated
git fetch origin
git rebase origin/main

# Push for review
git push origin feature/PROJ-123-description
```

### Commit Messages
```
Format: <type>(<scope>): <subject>

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Formatting
- refactor: Code restructuring
- test: Adding tests
- chore: Maintenance

Examples:
feat(auth): add JWT token refresh
fix(profile): resolve avatar upload issue
docs(api): update authentication guide
test(users): add user service tests
```

### Code Review Readiness
```
Before requesting review:

Self Review:
✓ Read through all changes
✓ Remove debug code
✓ Check for TODOs
✓ Verify tests pass
✓ Run linter
✓ Build locally
✓ Test manually

PR Quality:
✓ Clear title and description
✓ Link to ticket
✓ List changes
✓ Add screenshots
✓ Note breaking changes
✓ Mention reviewers
```

## Common Tasks

### Implementing Feature
```
@work_on_ticket_engineer PROJ-123

Process:
1. Understand requirements
2. Plan implementation
3. Write failing test
4. Implement feature
5. Make test pass
6. Refactor
7. Add more tests
8. Document
9. Create PR
```

### Fixing Bug
```
@work_on_ticket_engineer BUG-456

Process:
1. Reproduce bug
2. Write failing test
3. Debug root cause
4. Fix issue
5. Verify test passes
6. Check for similar issues
7. Add regression test
8. Update docs if needed
9. Create PR
```

### Refactoring
```
@work_on_ticket_engineer TECH-789

Process:
1. Identify code smell
2. Write tests if missing
3. Plan refactoring
4. Make small changes
5. Run tests after each change
6. Verify no behavior change
7. Update documentation
8. Create PR
```

## Troubleshooting

### Build Failures
```
1. Check error message
2. Verify dependencies installed
3. Clear build cache
4. Check for TypeScript errors
5. Verify environment variables
6. Review recent changes
```

### Test Failures
```
1. Read test output carefully
2. Run single test in isolation
3. Check test data/mocks
4. Verify assumptions
5. Debug with breakpoints
6. Review recent changes
```

### Integration Issues
```
1. Check API contracts
2. Verify data formats
3. Test with real data
4. Check error handling
5. Review logs
6. Coordinate with backend team
```

## Collaboration

### Asking for Help
```
When blocked:
1. Try debugging first (15-30 min)
2. Search documentation
3. Check similar code
4. Ask specific questions
5. Share what you've tried
6. Provide context

Example:
"I'm implementing PROJ-123 and getting error X when Y.
I've tried A and B, but still seeing the issue.
The code is at [link]. Any ideas?"
```

### Pair Programming
```
@work_on_ticket_engineer PROJ-123 --pair @teammate

Benefits:
- Faster problem solving
- Knowledge sharing
- Better code quality
- Fewer bugs
- Team building

Best Practices:
- Switch driver/navigator regularly
- Communicate thinking
- Ask questions
- Be respectful
- Take breaks
```

## Configuration

In `.claude/settings.json`:

```json
{
  "engineer_workflow": {
    "enabled": true,
    "auto_tests": true,
    "auto_lint": true,
    "commit_style": "conventional",
    "test_coverage_threshold": 80,
    "require_ticket_link": true,
    "pr_template": "default"
  }
}
```

## Metrics

Track your work:
- Story points completed
- Bug fix rate
- Code review turnaround
- Test coverage
- Code quality scores

## See Also

- `@work_on_ticket_parallel` - Parallel task execution
- `@work_on_ticket_respond_to_pr_comments` - PR comment workflow
- `@work_on_ticket_support_engineer` - Support role workflow
- `specs/code-standards.md` - Coding standards
