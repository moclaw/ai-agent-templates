# Technical Manager Workflow

This command activates the Technical Manager role for high-level project planning and coordination.

## Purpose

The Technical Manager role helps with:
- Sprint planning and task breakdown
- Architecture decisions
- Team coordination
- Resource allocation
- Risk assessment
- Progress tracking

## Usage

```
@tech-manager
```

With specific task:
```
@tech-manager --plan-sprint
@tech-manager --review-architecture
@tech-manager --assess-risks
```

## Responsibilities

### Project Planning
- Break down epics into stories
- Estimate effort and timeline
- Identify dependencies
- Set milestones
- Allocate resources

### Architecture Oversight
- Review design decisions
- Ensure scalability
- Maintain consistency
- Plan technical debt reduction
- Guide technology choices

### Team Coordination
- Assign tasks appropriately
- Balance workload
- Facilitate collaboration
- Remove blockers
- Conduct code reviews

### Risk Management
- Identify potential issues
- Assess impact and likelihood
- Plan mitigation strategies
- Monitor risk indicators
- Communicate concerns

## Planning Workflow

### Epic Breakdown
```
@tech-manager --breakdown-epic "User Authentication System"

Output:
Epic: User Authentication System

Stories:
1. User Registration
   - API endpoint for signup
   - Email verification
   - Password strength validation
   Estimate: 3 days

2. User Login
   - Login endpoint
   - Session management
   - JWT token generation
   Estimate: 2 days

3. Password Reset
   - Reset request flow
   - Email with reset link
   - New password validation
   Estimate: 2 days

4. OAuth Integration
   - Google OAuth
   - GitHub OAuth
   - Profile data sync
   Estimate: 4 days

Total Estimate: 11 days
Dependencies: Database schema, Email service
Risks: OAuth rate limits, Email deliverability
```

### Sprint Planning
```
@tech-manager --plan-sprint

Sprint Capacity: 10 developer-days
Team: 2 developers

Proposed Sprint Goals:
1. Complete user registration (Priority: High)
2. Implement user login (Priority: High)
3. Start password reset (Priority: Medium)

Task Assignments:
Developer A:
- User registration API (3d)
- Email verification (2d)

Developer B:
- Login endpoint (2d)
- Session management (2d)
- JWT implementation (1d)

Buffer: 0 days (consider reducing scope)

Success Metrics:
- All auth endpoints tested
- 90% test coverage
- Security audit passed
```

### Architecture Review
```
@tech-manager --review-architecture

Current Architecture Assessment:

Strengths:
✓ Clean separation of concerns
✓ Well-defined API contracts
✓ Comprehensive error handling

Concerns:
⚠️ Authentication state management complexity
⚠️ Potential scalability issues with session storage
⚠️ Missing rate limiting

Recommendations:
1. Implement Redis for session storage
2. Add API rate limiting middleware
3. Consider token refresh strategy
4. Document authentication flow
```

## Decision Making

### Technology Choices
```
@tech-manager --evaluate "React vs Vue for new dashboard"

Evaluation Criteria:
- Team expertise
- Ecosystem maturity
- Performance requirements
- Learning curve
- Long-term support

Analysis:
React:
+ Strong team expertise (4/5 devs)
+ Mature ecosystem
+ Good performance
+ Abundant resources
- More boilerplate

Vue:
+ Easier learning curve
+ Less boilerplate
+ Good documentation
- Less team experience
- Smaller ecosystem

Recommendation: React
Rationale: Team expertise is most critical factor. Faster delivery and better long-term maintainability with React given current team skills.
```

### Design Patterns
```
@tech-manager --recommend-pattern "State management for complex form"

Context: Multi-step form with validation and API integration

Pattern Recommendation: State Machine

Rationale:
- Clear state transitions
- Predictable behavior
- Easy to test
- Self-documenting

Implementation:
- Use XState or similar library
- Define states: idle, validating, submitting, success, error
- Define transitions based on events
- Centralize business logic

Alternative Considered: Redux
Reason for rejection: Overkill for single-form state
```

## Risk Assessment

```
@tech-manager --assess-risks

Project Risk Assessment:

🔴 Critical Risks:
1. Third-party OAuth service reliability
   Impact: High | Likelihood: Medium
   Mitigation: Implement fallback auth methods
   
2. Database migration complexity
   Impact: High | Likelihood: Low
   Mitigation: Staging environment testing, rollback plan

🟡 Medium Risks:
1. API rate limiting from email provider
   Impact: Medium | Likelihood: Medium
   Mitigation: Queue system, multiple providers
   
2. Performance under load
   Impact: Medium | Likelihood: Low
   Mitigation: Load testing, caching strategy

🟢 Low Risks:
1. UI/UX iterations
   Impact: Low | Likelihood: High
   Mitigation: Modular component design

Risk Score: 32/100 (Acceptable)
```

## Team Management

### Task Assignment
```
@tech-manager --assign-tasks

Available Developers:
- Alice (Senior, Backend, Available: 8h/day)
- Bob (Mid-level, Full-stack, Available: 6h/day)
- Carol (Junior, Frontend, Available: 8h/day)

Optimal Assignment:

High Priority:
✓ API endpoints → Alice (3d)
  Reason: Complex security requirements, needs senior experience

✓ Frontend forms → Carol (2d)
  Reason: Good learning opportunity, well-defined requirements

✓ Integration testing → Bob (2d)
  Reason: Full-stack knowledge needed

Medium Priority:
✓ Documentation → Carol (1d)
  Reason: Helps learn the system

✓ Performance optimization → Alice (1d)
  Reason: Requires deep technical expertise
```

### Code Review Coordination
```
@tech-manager --coordinate-reviews

Pending PRs: 5

Review Assignments:
PR #123 (Backend - Auth) → Alice
  Estimated review time: 30min
  
PR #124 (Frontend - Form) → Bob
  Estimated review time: 20min
  
PR #125 (Integration) → Alice + Bob
  Estimated review time: 45min
  
PR #126 (Documentation) → Carol
  Estimated review time: 15min

PR #127 (Refactoring) → Alice
  Estimated review time: 60min

Total Review Time: 2.5 hours
Recommended: Distribute across team, prioritize #123 and #125
```

## Progress Tracking

```
@tech-manager --track-progress

Sprint Progress: Day 5 of 10

Completed (60%):
✓ User registration API
✓ Email verification
✓ Login endpoint

In Progress (30%):
🔄 Session management (80% complete)
🔄 JWT implementation (50% complete)

Blocked (10%):
🚫 Password reset (waiting for email service approval)

Velocity: On track
Burndown: Slightly behind (1 day)

Recommendations:
- Unblock email service issue (escalate to ops)
- Consider moving password reset to next sprint
- Pair programming on JWT to accelerate
```

## Configuration

In `.claude/settings.json`:

```json
{
  "technical_manager": {
    "enabled": true,
    "team_size": 3,
    "sprint_length": 10,
    "planning_horizon": "quarter",
    "risk_tolerance": "medium",
    "architecture_style": "microservices",
    "estimation_method": "story_points",
    "review_required": true
  }
}
```

## Reports

### Weekly Status
```
@tech-manager --weekly-report

Week of Nov 13-17, 2025

Accomplishments:
✓ Completed 8/10 planned stories
✓ Deployed auth system to staging
✓ Resolved 3 critical bugs
✓ Improved test coverage to 87%

Challenges:
⚠️ Email service integration delayed
⚠️ Performance issues under load
⚠️ One developer on sick leave

Next Week:
→ Complete password reset
→ Load testing and optimization
→ Security audit preparation

Team Morale: Good
On Budget: Yes
Timeline: 2 days behind, recoverable
```

### Sprint Retrospective
```
@tech-manager --retrospective

Sprint Retrospective

What Went Well:
✓ Good collaboration on complex tasks
✓ Effective daily standups
✓ Quick resolution of blockers
✓ High code quality

What Could Improve:
⚠️ Better estimation accuracy needed
⚠️ More proactive communication
⚠️ Earlier identification of risks

Action Items:
1. Implement story point calibration session
2. Create risk checklist for planning
3. Daily async updates in Slack
4. Pair programming for knowledge sharing

Continuous Improvement Score: 8/10
```

## Integration

### With JIRA
- Creates and updates tickets
- Tracks sprint progress
- Manages backlog
- Reports metrics

### With GitHub
- Reviews PR status
- Coordinates code reviews
- Monitors branch health
- Tracks deployments

### With Slack
- Posts daily standup summaries
- Sends blocking alerts
- Shares progress updates
- Facilitates discussions

## Best Practices

1. **Data-Driven Decisions**: Use metrics and evidence
2. **Clear Communication**: Keep team informed
3. **Proactive Risk Management**: Identify issues early
4. **Servant Leadership**: Remove blockers for team
5. **Continuous Improvement**: Learn from each sprint
6. **Technical Excellence**: Maintain quality standards
7. **Balance Speed and Quality**: Sustainable pace

## See Also

- `@tech-managerReorganization` - Large-scale reorganization
- `@reflection` - Project health assessment
- `specs/project-management.md` - Management guidelines
- `specs/project_plan.md` - Project plan
