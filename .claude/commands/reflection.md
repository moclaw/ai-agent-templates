# Reflection - Project Instruction Analysis

This command analyzes your project structure, documentation, and codebase to provide insights and recommendations.

## Purpose

Reflection helps you:
- Understand project organization
- Identify documentation gaps
- Discover improvement opportunities
- Analyze code patterns
- Assess technical debt
- Plan refactoring efforts

## Usage

```
@reflection
```

With specific focus:
```
@reflection --focus architecture
@reflection --focus documentation
@reflection --focus code-quality
@reflection --deep
```

## Analysis Categories

### Project Structure
- Directory organization
- File naming conventions
- Module dependencies
- Configuration files
- Build artifacts

### Documentation
- README completeness
- API documentation
- Code comments
- Setup instructions
- Architecture diagrams

### Code Quality
- Code complexity
- Duplication
- Test coverage
- Linting issues
- Security concerns

### Architecture
- Design patterns
- Component coupling
- Layer separation
- Data flow
- Integration points

### Dependencies
- Package versions
- Update availability
- Security vulnerabilities
- License compliance
- Bundle size

## Output Format

```
# Project Reflection Report

## Executive Summary
High-level overview of project health and key findings.

## Project Structure
✓ Strengths:
  - Well-organized components
  - Clear separation of concerns

⚠️ Areas for Improvement:
  - Inconsistent naming in utils/
  - Mixed configuration formats

## Documentation
✓ Strengths:
  - Comprehensive README
  - Good API documentation

⚠️ Gaps:
  - Missing architecture diagrams
  - Incomplete setup guide

## Code Quality
✓ Strengths:
  - Good test coverage (85%)
  - Consistent style

⚠️ Issues:
  - High complexity in auth module
  - Code duplication in validators

## Recommendations
1. [Priority] Refactor authentication module
2. [Medium] Add architecture documentation
3. [Low] Standardize config files

## Action Items
- [ ] Create architecture diagram
- [ ] Refactor auth module
- [ ] Update dependencies
- [ ] Improve test coverage in area X
```

## Reflection Modes

### Quick Reflection
```
@reflection --quick
```
Fast overview (~2 minutes)

### Standard Reflection
```
@reflection
```
Comprehensive analysis (~5 minutes)

### Deep Reflection
```
@reflection --deep
```
Thorough investigation (~10 minutes)

## Focused Analysis

### Architecture Focus
```
@reflection --focus architecture
```
Analyzes:
- Design patterns
- Component relationships
- Layering
- Scalability concerns

### Documentation Focus
```
@reflection --focus documentation
```
Checks:
- Documentation completeness
- Example quality
- Setup instructions
- API references

### Code Quality Focus
```
@reflection --focus code-quality
```
Reviews:
- Complexity metrics
- Code smells
- Test coverage
- Maintainability

### Security Focus
```
@reflection --focus security
```
Examines:
- Vulnerability scan
- Authentication patterns
- Data validation
- Secret management

### Performance Focus
```
@reflection --focus performance
```
Evaluates:
- Bottlenecks
- Resource usage
- Optimization opportunities
- Caching strategies

## Configuration

In `.claude/settings.json`:

```json
{
  "reflection": {
    "enabled": true,
    "auto_reflect": false,
    "frequency": "weekly",
    "include_patterns": [
      "src/**/*.{js,ts,jsx,tsx}",
      "tests/**/*.{js,ts}",
      "docs/**/*.md"
    ],
    "exclude_patterns": [
      "node_modules/**",
      "dist/**",
      "coverage/**"
    ],
    "metrics": {
      "complexity_threshold": 10,
      "duplication_threshold": 5,
      "coverage_target": 80
    }
  }
}
```

## Automated Reflection

Schedule regular reflections:

```json
{
  "reflection": {
    "auto_reflect": true,
    "schedule": "0 9 * * MON",
    "notification": {
      "slack": "#dev-team",
      "email": "team@example.com"
    }
  }
}
```

## Integration Points

### With JIRA
- Links findings to technical debt tickets
- Creates improvement tasks
- Tracks refactoring progress

### With GitHub
- Comments on PRs with insights
- Suggests reviewers based on changes
- Flags high-risk modifications

### With CI/CD
- Runs on merge to main
- Gates on quality thresholds
- Generates trend reports

## Metrics Tracked

### Code Metrics
- Lines of code
- Cyclomatic complexity
- Maintainability index
- Technical debt ratio

### Test Metrics
- Coverage percentage
- Test execution time
- Flaky test rate
- Assertion quality

### Documentation Metrics
- Documentation coverage
- Outdated docs count
- Example completeness
- Link validity

### Dependency Metrics
- Outdated packages
- Security vulnerabilities
- License issues
- Bundle size impact

## Trend Analysis

Track changes over time:
```
@reflection --trends --since 30-days
```

Output:
```
📊 Reflection Trends (Last 30 Days)

Code Quality: ↗️ +5%
Test Coverage: ↗️ +8% (77% → 85%)
Documentation: → Stable
Dependencies: ↘️ -2 vulnerabilities
Complexity: ↗️ +3% (needs attention)
```

## Recommendations Engine

Prioritized suggestions:

### High Priority
- Security vulnerabilities
- Critical bugs
- Broken documentation
- Build failures

### Medium Priority  
- Code complexity
- Test coverage gaps
- Outdated dependencies
- Architecture concerns

### Low Priority
- Code style issues
- Minor optimizations
- Documentation polish
- Convenience improvements

## Action Planning

Generate action plan:
```
@reflection --action-plan
```

Output:
```
# 30-Day Improvement Plan

## Week 1: Security
- [ ] Update vulnerable dependencies
- [ ] Add input validation to API endpoints
- [ ] Review authentication implementation

## Week 2: Quality
- [ ] Refactor high-complexity functions
- [ ] Increase test coverage to 85%
- [ ] Fix linting issues

## Week 3: Documentation
- [ ] Add architecture diagram
- [ ] Update API documentation
- [ ] Create troubleshooting guide

## Week 4: Performance
- [ ] Optimize database queries
- [ ] Implement caching layer
- [ ] Reduce bundle size
```

## Best Practices

1. **Regular Reflection**: Run weekly or bi-weekly
2. **Act on Findings**: Don't just collect insights
3. **Track Progress**: Monitor trends over time
4. **Share Results**: Discuss with team
5. **Prioritize**: Focus on high-impact items
6. **Automate**: Integrate with CI/CD

## Troubleshooting

### Analysis Takes Too Long
- Use `--quick` mode
- Exclude large directories
- Focus analysis scope

### Missing Issues
- Use `--deep` mode
- Check include patterns
- Verify file access

### Too Many False Positives
- Adjust thresholds
- Refine patterns
- Add ignore rules

## Export Options

### Markdown Report
```
@reflection --export report.md
```

### JSON Data
```
@reflection --export report.json
```

### HTML Dashboard
```
@reflection --export report.html
```

## Comparison

Compare with previous reflection:
```
@reflection --compare last-month
```

Compare with other branch:
```
@reflection --compare origin/main
```

## Integration Examples

### Pre-Release Checklist
```bash
# Before release
@reflection --focus security
@reflection --focus performance
@reflection --focus documentation
```

### Sprint Retrospective
```bash
# End of sprint
@reflection --trends --since 2-weeks
@reflection --action-plan
```

### Onboarding New Developer
```bash
# For new team member
@reflection --focus architecture
@reflection --focus documentation
```

## See Also

- `@prime` - Load project context
- `@tech-manager` - Project planning
- `specs/project-management.md` - Project standards
