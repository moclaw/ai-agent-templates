# Work on Ticket - Parallel Execution

This command enables parallel execution of multiple related tasks.

## Purpose

Execute multiple independent tasks simultaneously to:
- Speed up development
- Maximize productivity
- Handle related work efficiently
- Coordinate dependent tasks
- Manage parallel workflows

## Usage

```
@parallel <ticket-ids>
```

Examples:
```
@parallel PROJ-123 PROJ-124 PROJ-125
@parallel --epic EPIC-10
@parallel --sprint current
```

## When to Use

### Good for Parallel:
✓ Independent features
✓ Multiple bug fixes
✓ Documentation tasks
✓ Testing different scenarios
✓ Refactoring separate modules

### Not for Parallel:
✗ Dependent tasks
✗ Shared state changes
✗ Sequential workflows
✗ Single file edits
✗ Coordinated releases

## Workflow

### Task Analysis
```
@parallel PROJ-123 PROJ-124 PROJ-125

Analyzing tasks...

PROJ-123: Add user avatar upload
- Files: UserProfile.tsx, avatar-service.ts
- Dependencies: None
- Estimated: 2 hours
- Status: Ready

PROJ-124: Fix login redirect bug
- Files: AuthController.ts, routes.ts
- Dependencies: None
- Estimated: 1 hour
- Status: Ready

PROJ-125: Update API documentation
- Files: docs/api.md, openapi.yaml
- Dependencies: None
- Estimated: 1.5 hours
- Status: Ready

Conflict Check: ✓ No file conflicts
Parallel Execution: ✓ Safe
Estimated Total Time: 2 hours (vs 4.5 hours sequential)
```

### Execution Strategy
```
Parallel Execution Plan:

Thread 1: PROJ-123 (Avatar Upload)
├── Create branch
├── Implement upload component
├── Add backend endpoint
├── Write tests
└── Create PR

Thread 2: PROJ-124 (Login Bug)
├── Create branch
├── Reproduce issue
├── Fix redirect logic
├── Add regression test
└── Create PR

Thread 3: PROJ-125 (Docs)
├── Create branch
├── Update API docs
├── Update OpenAPI spec
├── Review accuracy
└── Create PR

Estimated Completion: 2 hours
Progress Updates: Every 30 minutes
```

### Progress Tracking
```
Execution Progress:

[========>  ] PROJ-123: 80% (Implementation done, testing)
[=======>   ] PROJ-124: 70% (Fix applied, testing)
[=========> ] PROJ-125: 90% (Docs updated, final review)

Next Updates:
- PROJ-123: Tests completed (ETA 15 min)
- PROJ-124: PR created (ETA 20 min)
- PROJ-125: PR created (ETA 10 min)

Overall: 80% complete
```

## Task Coordination

### Dependency Management
```
@parallel --with-dependencies PROJ-123 PROJ-124 PROJ-126

Task Dependencies:

PROJ-123: Database schema ← (Start first)
├── No dependencies
└── Required by: PROJ-126

PROJ-124: API endpoint ← (Start second)
├── Depends on: PROJ-123
└── Required by: PROJ-126

PROJ-126: Frontend component ← (Start last)
├── Depends on: PROJ-123, PROJ-124
└── No dependents

Execution Order:
1. Start PROJ-123 immediately
2. Start PROJ-124 when PROJ-123 schema done
3. Start PROJ-126 when PROJ-124 API ready

Estimated Total: 3 hours (with coordination)
```

### Resource Allocation
```
Resource Planning:

Available:
- 4 CPU cores
- 16GB RAM
- 3 concurrent builds

Allocation:
Thread 1 (PROJ-123):
- 1 core for build
- 4GB RAM
- Database access

Thread 2 (PROJ-124):
- 1 core for tests
- 4GB RAM
- API access

Thread 3 (PROJ-125):
- Minimal resources
- Documentation only

Reserved:
- 2 cores for IDE/tools
- 8GB RAM for system
```

## Conflict Resolution

### File Conflicts
```
Conflict Detected:

PROJ-123 and PROJ-124 both modify:
- src/config.ts

Resolution Strategy:
1. Complete PROJ-123 first
2. Rebase PROJ-124 on PROJ-123
3. Resolve conflicts
4. Continue execution

Estimated Delay: 10 minutes
```

### Merge Conflicts
```
Merge Conflict Management:

Sequential Merging:
1. Merge PROJ-123 (no conflicts)
2. Rebase PROJ-124 on main
3. Merge PROJ-124
4. Rebase PROJ-125 on main
5. Merge PROJ-125

Alternative: Merge Queue
- Add all PRs to queue
- Auto-rebase and merge
- Handle conflicts automatically
```

## Advanced Features

### Epic Completion
```
@parallel --epic EPIC-10

EPIC-10: User Management System

Stories (8):
✓ PROJ-120: User model
✓ PROJ-121: User API
◯ PROJ-122: User UI
◯ PROJ-123: User auth
◯ PROJ-124: User profile
◯ PROJ-125: User search
◯ PROJ-126: User admin
◯ PROJ-127: User tests

Parallel Execution Plan:
Batch 1 (Completed):
- PROJ-120, PROJ-121

Batch 2 (Current, no conflicts):
- PROJ-122: UI components
- PROJ-123: Auth integration
- PROJ-124: Profile page

Batch 3 (Waiting on Batch 2):
- PROJ-125: Search (needs PROJ-122)
- PROJ-126: Admin (needs PROJ-123, PROJ-124)
- PROJ-127: Tests (needs all)

Progress: 25% (2/8 complete)
ETA: 3 days
```

### Sprint Completion
```
@parallel --sprint current

Current Sprint: Sprint 15

Remaining Tickets: 5
Total Points: 13
Days Left: 2

Parallelization Plan:

High Priority (8 points):
→ PROJ-200: Critical bug (3 pts)
→ PROJ-201: API feature (5 pts)

Medium Priority (5 points):
→ PROJ-202: UI update (2 pts)
→ PROJ-203: Documentation (1 pt)
→ PROJ-204: Refactoring (2 pts)

Execution Strategy:
- Parallel: PROJ-200, PROJ-202, PROJ-203
- Sequential after: PROJ-201, PROJ-204
- Estimated completion: 1.5 days
- Buffer: 0.5 days
```

## Monitoring

### Real-time Status
```
Live Status Dashboard:

PROJ-123 [●●●●●●●●○○] 80%
├── Branch: feature/PROJ-123
├── Commits: 5
├── Tests: 12/15 passing
└── ETA: 30 minutes

PROJ-124 [●●●●●●●○○○] 70%
├── Branch: bugfix/PROJ-124
├── Commits: 3
├── Tests: 8/8 passing
└── ETA: 45 minutes

PROJ-125 [●●●●●●●●●○] 90%
├── Branch: docs/PROJ-125
├── Commits: 4
├── Tests: N/A
└── ETA: 15 minutes

System Resources:
CPU: [●●●○○○○○○○] 30%
RAM: [●●●●●○○○○○] 50%
Network: [●●○○○○○○○○] 20%
```

### Error Handling
```
Error Detected in PROJ-124:

Type: Test Failure
Test: "should redirect after login"
Error: Expected '/dashboard', got '/home'

Actions:
1. Pausing PROJ-124 execution
2. Continuing PROJ-123 and PROJ-125
3. Alerting assignee
4. Queuing retry after fix

Other tasks unaffected.
```

## Configuration

```json
{
  "parallel_execution": {
    "enabled": true,
    "max_threads": 3,
    "auto_coordinate": true,
    "conflict_resolution": "automatic",
    "progress_updates": "30m",
    "resource_limits": {
      "max_cpu_percent": 80,
      "max_ram_gb": 12,
      "max_disk_io": "100MB/s"
    }
  }
}
```

## Best Practices

1. **Check Independence**: Ensure tasks don't conflict
2. **Monitor Progress**: Watch all threads actively
3. **Handle Errors Gracefully**: Don't let one failure block others
4. **Communicate Status**: Keep team informed
5. **Merge Strategically**: Plan merge order
6. **Test Thoroughly**: Test each task independently
7. **Document Decisions**: Record parallel execution choices

## Performance Tips

### Optimize Parallelization
- Group similar tasks
- Balance workload
- Minimize resource contention
- Use caching effectively
- Batch related operations

### Avoid Bottlenecks
- Shared database access
- File system locks
- API rate limits
- Build system limits
- Test environment conflicts

## Troubleshooting

### Tasks Stuck
```
Problem: One task not progressing

Check:
- Resource availability
- External dependencies
- Error messages
- Network connectivity
- Service availability

Solution:
- Restart task
- Allocate more resources
- Resolve blocking issue
- Continue other tasks
```

### Resource Exhaustion
```
Problem: System running slow

Check:
- CPU usage
- Memory usage
- Disk I/O
- Network bandwidth

Solution:
- Reduce concurrent tasks
- Increase system resources
- Optimize task execution
- Queue some tasks
```

## Integration

### With CI/CD
- Parallel test execution
- Concurrent builds
- Matrix testing
- Multi-environment deployment

### With Project Management
- Update JIRA in parallel
- Sync status automatically
- Track metrics
- Generate reports

## Metrics

Track parallel execution:
- Time saved vs sequential
- Resource utilization
- Conflict frequency
- Success rate
- Team velocity

## See Also

- `@engineer` - Single ticket workflow
- `@tech-manager` - Project planning
- `@auto-merge-prs` - Batch merging
