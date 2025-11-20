# AI-Assisted Project Management System

This document defines the AI-assisted project management approach using Claude, JIRA, and Confluence.

## Overview

Our project management system leverages AI (Claude) to enhance productivity, automate routine tasks, and maintain high-quality documentation.

## Architecture

```
Claude AI (MCP)
    ↓
JIRA (Issue Tracking) ←→ Confluence (Documentation)
    ↓                         ↓
GitHub (Code)             Team (Collaboration)
```

## Workflows

### Sprint Planning

**Process:**
1. Product Owner creates epic in JIRA
2. Run `@technicalManager --breakdown-epic EPIC-ID`
3. Claude analyzes epic and suggests story breakdown
4. Team reviews and refines stories
5. Claude estimates story points based on historical data
6. Run `@technicalManager --plan-sprint`
7. Claude suggests optimal sprint composition
8. Team finalizes sprint commitment

**Automation:**
- Epic breakdown into stories
- Story point estimation
- Sprint capacity calculation
- Task assignment suggestions
- Dependency identification

### Feature Development

**Process:**
1. Developer picks ticket from sprint
2. Run `@work_on_ticket_engineer PROJ-123`
3. Claude loads context from JIRA and Confluence
4. Claude helps implement feature
5. Claude creates tests
6. Claude updates documentation
7. Claude creates PR with JIRA link
8. Code review with `@respond_to_all_code_reviews`
9. Merge with `@merge_all_approved_pull_requests`

**Automation:**
- Context loading
- Code generation
- Test creation
- Documentation updates
- PR creation and linking

### Bug Triage

**Process:**
1. Bug reported in JIRA
2. Run `@work_on_ticket_support_engineer BUG-456`
3. Claude investigates logs and code
4. Claude suggests root cause
5. Claude provides workaround
6. Claude implements fix
7. Claude updates KB article
8. Claude creates post-mortem

**Automation:**
- Log analysis
- Root cause identification
- Workaround suggestions
- Fix implementation
- Documentation updates

## JIRA Configuration

### Issue Types

**Epic**
- Large feature or initiative
- Contains multiple stories
- Tracked at quarter level

**Story**
- User-facing feature
- Estimated in story points
- Completed within sprint

**Task**
- Technical work
- Implementation step
- Part of story

**Bug**
- Defect in existing functionality
- Severity levels: Critical, High, Medium, Low
- SLA-based response times

**Spike**
- Research or investigation
- Time-boxed
- Produces decision document

### Custom Fields

- **Story Points**: Fibonacci (1, 2, 3, 5, 8, 13)
- **Sprint**: Current sprint assignment
- **Epic Link**: Parent epic
- **Acceptance Criteria**: Definition of done
- **Technical Notes**: Implementation details
- **AI Context**: Claude-specific instructions

### Workflow States

```
Open → In Progress → Code Review → Testing → Done

Transitions:
- Open → In Progress: Start work
- In Progress → Code Review: Create PR
- Code Review → Testing: PR merged
- Testing → Done: QA passed
- Any → Open: Reopen if issues found
```

### Automation Rules

1. **Auto-assign**: When ticket moved to "In Progress", assign to user
2. **Link PR**: When PR created, link to ticket
3. **Update status**: When PR merged, move to "Testing"
4. **Sprint completion**: When sprint ends, move incomplete to next sprint
5. **SLA alerts**: Notify if bug SLA approaching

## Confluence Integration

### Page Structure

```
Project Space
├── Overview
├── Architecture
│   ├── System Design
│   ├── Database Schema
│   └── API Documentation
├── Development
│   ├── Setup Guide
│   ├── Coding Standards
│   └── Testing Guide
├── Operations
│   ├── Deployment Guide
│   ├── Monitoring
│   └── Runbooks
├── Retrospectives
│   ├── Sprint Retros
│   └── Post-Mortems
└── Decision Records
    └── ADRs
```

### Templates

**Feature Documentation Template:**
```markdown
# Feature: [Name]

## Overview
[Brief description]

## Requirements
- [Requirement 1]
- [Requirement 2]

## Design
[Design details, diagrams]

## Implementation
[Technical details]

## Testing
[Test strategy]

## Deployment
[Deployment steps]

## Monitoring
[Metrics and alerts]

## JIRA Links
[Links to related tickets]
```

**Post-Mortem Template:**
```markdown
# Post-Mortem: [Incident]

## Summary
[What happened]

## Timeline
[Detailed sequence of events]

## Impact
[Who/what was affected]

## Root Cause
[Why it happened]

## Resolution
[How it was fixed]

## Action Items
- [ ] [Action 1] (Owner, Due Date)
- [ ] [Action 2] (Owner, Due Date)

## Lessons Learned
[What we learned]
```

## Claude Integration Points

### Context Priming

```
@prime --focus [area]
```

Loads relevant context:
- JIRA tickets
- Confluence docs
- Code structure
- Git history

### Autonomous Work

```
@work_on_ticket_engineer PROJ-123
```

Claude will:
1. Load ticket and linked docs
2. Understand requirements
3. Review relevant code
4. Implement changes
5. Write tests
6. Update documentation
7. Create PR
8. Update JIRA

### Code Review

```
@respond_to_all_code_reviews
```

Claude analyzes feedback and:
- Makes requested changes
- Responds to comments
- Updates tests
- Pushes changes

### Documentation

```
Update Confluence page with deployment instructions
```

Claude maintains documentation:
- Creates new pages
- Updates existing content
- Adds diagrams
- Links to JIRA

## Metrics and Reporting

### Sprint Metrics

- **Velocity**: Story points completed per sprint
- **Completion Rate**: % of committed work completed
- **Bug Rate**: Bugs found per story point
- **Cycle Time**: Time from start to done
- **Lead Time**: Time from creation to done

### Quality Metrics

- **Code Coverage**: % of code tested
- **Review Time**: Time to approve PR
- **Rework Rate**: % of work needing changes
- **Defect Density**: Defects per 1K lines of code
- **Technical Debt**: Tracked debt items

### Team Metrics

- **Capacity**: Available story points
- **Allocation**: Time spent on features vs bugs vs tech debt
- **Blocker Time**: Time waiting on blockers
- **Collaboration**: PR reviews, pair programming

## Best Practices

### Ticket Creation

1. **Clear Title**: Describe what, not how
2. **Context**: Provide background
3. **Acceptance Criteria**: Define success
4. **Links**: Reference related tickets/docs
5. **Estimates**: Size appropriately
6. **Priority**: Set correctly

### Documentation

1. **Up-to-date**: Update with code changes
2. **Discoverable**: Good navigation structure
3. **Searchable**: Use good keywords
4. **Visual**: Include diagrams
5. **Versioned**: Track changes

### Code Reviews

1. **Timely**: Review within 24 hours
2. **Constructive**: Be helpful, not critical
3. **Thorough**: Check standards, tests, docs
4. **Automated**: Use linters and CI
5. **Learn**: Share knowledge

### Sprint Ceremonies

1. **Planning**: Whole team, time-boxed
2. **Daily Standup**: 15 minutes max
3. **Review**: Demo completed work
4. **Retrospective**: Continuous improvement
5. **Refinement**: Prepare backlog

## Tools Configuration

### MCP Setup

See `.mcp.json` for:
- JIRA connection
- Confluence connection
- Authentication

### GitHub Integration

- Branch naming: `feature/PROJ-123-description`
- PR template with JIRA link
- Status checks required
- Auto-link to JIRA

### Slack Integration

- Sprint updates
- Build notifications
- Alert escalations
- Team communication

## Security and Access

### JIRA Permissions

- **Developers**: Create, edit, comment
- **QA**: Test, close bugs
- **PM**: All permissions
- **External**: View only

### Confluence Permissions

- **Team**: Edit team space
- **Public**: View published docs
- **Admin**: Manage spaces

### API Access

- Use service accounts
- Rotate credentials regularly
- Audit access logs
- Limit permissions

## Continuous Improvement

### Regular Reviews

- **Weekly**: Sprint progress
- **Bi-weekly**: Process improvements
- **Monthly**: Metrics review
- **Quarterly**: Strategic alignment

### Feedback Loops

- Retrospectives after each sprint
- Post-mortems for incidents
- Code review feedback
- User feedback integration

## See Also

- `specs/project_plan.md` - Current project plan
- `specs/code-standards.md` - Coding standards
- `.claude/commands/` - Available AI commands
- `ai_docs/jira-and-confluence-tool-use.md` - Integration guide
