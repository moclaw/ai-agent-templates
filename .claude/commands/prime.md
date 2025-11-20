# Prime Context Command

This command primes Claude's context with essential project information for optimal performance.

## Purpose

The Prime command loads critical project context into Claude's working memory, including:
- Project structure and architecture
- Coding standards and conventions
- Key dependencies and their usage
- Common patterns and practices
- Active tasks and priorities

## Usage

```
@prime
```

With specific context:
```
@prime --focus backend
@prime --focus frontend
@prime --full
```

## What Gets Loaded

### Project Essentials
- README.md overview
- Architecture documentation
- Code standards from `specs/code-standards.md`
- Project plan from `specs/project_plan.md`

### Technical Context
- Key configuration files
- Dependency list and versions
- API documentation
- Database schemas

### Development Context
- Active branches
- Recent commits
- Open issues/tickets
- TODO items

## Context Layers

### Minimal (Default)
```
@prime
```
Loads essential information only (~5K tokens)

### Focused
```
@prime --focus backend
```
Loads specific area in detail (~10K tokens)

### Full
```
@prime --full
```
Loads comprehensive context (~30K tokens)

## Configuration

In `.claude/settings.json`:

```json
{
  "prime_context": {
    "auto_prime": true,
    "cache_duration": 3600,
    "include": [
      "README.md",
      "specs/code-standards.md",
      "specs/project_plan.md",
      "ai_docs/*.md"
    ],
    "exclude": [
      "node_modules/**",
      "dist/**",
      ".git/**"
    ],
    "max_tokens": 30000
  }
}
```

## Auto-Prime

Enable automatic context loading:

```json
{
  "prime_context": {
    "auto_prime": true,
    "triggers": [
      "session_start",
      "branch_switch",
      "project_open"
    ]
  }
}
```

## Context Categories

### Architecture
- System design
- Component relationships
- Data flow
- Integration points

### Standards
- Coding conventions
- Naming patterns
- File organization
- Testing requirements

### Domain Knowledge
- Business logic
- Domain models
- Business rules
- Terminology

### Tools & Setup
- Development environment
- Build process
- Testing framework
- Deployment pipeline

## Optimization

### Token Management
Prime intelligently manages tokens:
- Prioritizes recent/relevant content
- Uses prompt caching (Claude 3.5+)
- Refreshes stale context
- Removes redundant information

### Cache Strategy
```json
{
  "prime_context": {
    "cache_strategy": "aggressive",
    "cache_key_prefix": "project",
    "invalidate_on": [
      "config_change",
      "dependency_update"
    ]
  }
}
```

## Context Verification

After priming, verify context loaded:

```
@prime --verify
```

Output:
```
✓ Project structure loaded
✓ Code standards loaded
✓ 15 dependencies indexed
✓ 3 active tickets loaded
✓ Architecture docs cached
  
Context ready. Token usage: 12,450
```

## Best Practices

1. **Prime Early**: Run at session start
2. **Focus Context**: Use focused loading for specific work
3. **Update Regularly**: Re-prime after major changes
4. **Verify Loading**: Check context completeness
5. **Monitor Tokens**: Track context size

## Advanced Usage

### Custom Context Files
```
@prime --include custom-context.md
```

### Temporary Context
```
@prime --temp --include feature-spec.md
```

### Context Export
```
@prime --export context-snapshot.json
```

## Integration Points

### With JIRA
Loads:
- Active sprint tickets
- Story descriptions
- Acceptance criteria
- Related issues

### With Git
Loads:
- Branch context
- Recent commits
- PR descriptions
- Code review comments

### With Documentation
Loads:
- API specs
- Architecture docs
- Runbooks
- Onboarding guides

## Troubleshooting

### Context Too Large
- Use focused loading
- Exclude unnecessary files
- Increase cache efficiency

### Missing Information
- Check include patterns
- Verify file paths
- Review exclude rules

### Stale Context
- Force refresh: `@prime --refresh`
- Check cache duration
- Verify auto-prime triggers

## Performance Tips

1. Use prompt caching for stable content
2. Focus on relevant subsystems
3. Exclude large generated files
4. Optimize documentation structure
5. Leverage incremental updates

## Context Layers Example

```
Minimal Prime (5K tokens):
├── README.md (1K)
├── code-standards.md (2K)
└── current-task.md (2K)

Focused Prime (10K tokens):
├── Minimal context (5K)
├── Backend architecture (3K)
└── Related APIs (2K)

Full Prime (30K tokens):
├── All documentation (15K)
├── Key source files (10K)
└── Dependencies & config (5K)
```

## Metrics

Track priming effectiveness:
- Context hit rate
- Token efficiency
- Time to first response
- Accuracy improvement

## See Also

- `@reflection` - Analyze project structure
- `@technicalManager` - Project planning
- Prompt caching documentation
