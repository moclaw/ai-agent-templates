# Claude-Specific Documentation

This document provides Claude-specific information and guidelines for working with this template.

## Overview

This template is designed to maximize productivity when working with Claude AI. It provides:
- Pre-configured commands for common workflows
- Context management for efficient operations
- Integration with development tools
- Best practices and patterns

## Working with Claude

### Session Initialization

At the start of each session:

```
@prime

# This loads:
# - Project structure
# - Code standards
# - Active tickets
# - Recent changes
```

### Common Workflows

#### Starting New Feature

```
@work_on_ticket_engineer PROJ-123

# Claude will:
# 1. Load ticket from JIRA
# 2. Review requirements
# 3. Check related code
# 4. Implement feature
# 5. Write tests
# 6. Create PR
```

#### Code Review

```
@respond_to_all_code_reviews

# Claude will:
# 1. Analyze feedback
# 2. Make changes
# 3. Respond to comments
# 4. Update PR
```

#### Bug Investigation

```
@work_on_ticket_support_engineer BUG-456

# Claude will:
# 1. Reproduce issue
# 2. Analyze logs
# 3. Identify root cause
# 4. Provide fix
# 5. Update documentation
```

## Custom Commands

See `.claude/commands/` for all available commands:

- `claude_template_setup.md` - Setup guide
- `infinite.md` - Autonomous operation mode
- `merge_all_approved_pull_requests.md` - Auto-merge PRs
- `prime.md` - Context loading
- `prompt_writer.md` - Prompt engineering help
- `reflection.md` - Project analysis
- `respond_to_all_code_reviews.md` - Batch PR responses
- `technicalManager.md` - Project management
- `technicalManagerReorganization.md` - Large refactoring
- `work_on_ticket_engineer.md` - Feature development
- `work_on_ticket_parallel.md` - Parallel execution
- `work_on_ticket_respond_to_pr_comments.md` - PR comments
- `work_on_ticket_support_engineer.md` - Support issues

## Configuration

### Global Settings

Edit `.claude/settings.json` for project-wide configuration:

```json
{
  "ai_assistant": {
    "model": "claude-3-5-sonnet-20241022",
    "max_tokens": 4096
  },
  "engineer_workflow": {
    "auto_tests": true,
    "auto_lint": true,
    "test_coverage_threshold": 80
  }
}
```

### Local Settings

Edit `.claude/settings.local.json` for personal preferences:

```json
{
  "logging": {
    "level": "debug"
  }
}
```

This file is gitignored and won't be committed.

## Context Management

### What Gets Loaded

Claude can access:
- All project files
- Git history
- JIRA tickets (via MCP)
- Confluence docs (via MCP)
- GitHub PRs and issues

### Managing Context Size

Use focused context loading:

```
# Full context (30K tokens)
@prime --full

# Focused context (10K tokens)
@prime --focus backend

# Minimal context (5K tokens)
@prime
```

### Caching

Claude 3.5 Sonnet supports prompt caching:
- System prompts cached automatically
- Tool definitions cached
- Large documentation cached
- Reduces latency and cost

## Best Practices

### When to Use Claude

**Good for:**
- Writing new code
- Refactoring
- Writing tests
- Documentation
- Code review
- Debugging
- Architecture planning

**Not for:**
- Simple find/replace
- Bulk file operations
- Git operations
- Deployment

### Providing Context

When asking Claude:

```
Good:
"Implement user authentication with JWT tokens.
Requirements:
- Login endpoint
- Token refresh
- Middleware for protected routes
- Follow patterns in auth/ directory"

Poor:
"Add auth"
```

### Iterative Development

Work in small iterations:

1. Implement core functionality
2. Add tests
3. Refactor if needed
4. Add error handling
5. Update docs

### Error Recovery

If Claude makes a mistake:

```
"The login function has a bug - it doesn't handle
null email. Please fix and add a test for this case."
```

## Integration with Tools

### JIRA

Claude can:
- Read ticket details
- Update status
- Add comments
- Create new tickets
- Query with JQL

Requires MCP configuration in `.mcp.json`.

### Confluence

Claude can:
- Read documentation
- Create pages
- Update content
- Search knowledge base

Requires MCP configuration in `.mcp.json`.

### GitHub

Claude can:
- Read repository
- View PRs and issues
- Analyze code
- Suggest changes

Direct access via file system.

## Prompt Engineering

### Effective Prompts

```
# Structure your requests
<task>
What you want done
</task>

<requirements>
- Specific requirement 1
- Specific requirement 2
</requirements>

<context>
Relevant background information
</context>

<constraints>
- Must use existing API
- Performance critical
</constraints>
```

### Using Examples

```
"Create a form component similar to UserForm.tsx
but for editing products. Include:
- Product name, price, description
- Image upload
- Category select
- Validation
- Same styling as UserForm"
```

### Chain of Thought

```
"Debug this authentication issue step by step:
1. First, check if the token is being sent
2. Then, verify token format
3. Check if it's expired
4. Verify signature
5. Identify where it fails"
```

## Troubleshooting

### Claude Seems Confused

```
# Reset context
@prime --refresh

# Start fresh conversation
# (Use new chat session)
```

### Response Too Long/Short

```
# For longer response
"Please provide a detailed implementation with
error handling, tests, and documentation."

# For shorter response
"Just give me the function signature and key logic,
I'll fill in the details."
```

### Wrong Approach

```
"That approach won't work because [reason].
Instead, please use [alternative approach]."
```

## Performance Tips

1. **Prime Early**: Load context at session start
2. **Be Specific**: Clear requests get better results
3. **Use Examples**: Show don't just tell
4. **Iterate**: Build up complex solutions
5. **Leverage Caching**: Reuse context across requests

## Security Notes

- Never commit API keys
- Review generated code for security issues
- Validate all inputs
- Use environment variables
- Follow security best practices in `specs/code-standards.md`

## Getting Help

### Resources

- Command documentation: `.claude/commands/`
- AI integration: `ai_docs/`
- Code standards: `specs/code-standards.md`
- Project management: `specs/project-management.md`

### Community

- GitHub Discussions
- Issue tracker
- Slack channel

### Support

- Technical issues: GitHub Issues
- Questions: GitHub Discussions
- Urgent: team@your-org.com

## Updates

This template is actively maintained. Check for updates:

```bash
git fetch upstream
git merge upstream/main
```

Stay current with Claude capabilities:
- [Anthropic Documentation](https://docs.anthropic.com/)
- [Release notes](https://docs.anthropic.com/claude/docs/release-notes)
- [Model updates](https://docs.anthropic.com/claude/docs/models-overview)

## Feedback

We welcome feedback:
- Feature requests: GitHub Issues
- Bug reports: GitHub Issues
- Suggestions: GitHub Discussions
- Contributions: Pull Requests

---

**Happy coding with Claude! 🚀**
