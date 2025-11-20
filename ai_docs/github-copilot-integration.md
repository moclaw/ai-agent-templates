# GitHub Copilot Integration Guide

This guide covers how to integrate GitHub Copilot with your Claude AI development template for optimal AI-assisted development.

## Overview

This template supports both GitHub Copilot and Claude AI, allowing you to leverage the strengths of both:
- **GitHub Copilot**: Real-time code completion and suggestions in your IDE
- **Claude AI**: Complex reasoning, architecture decisions, and workflow automation

## Setup

### 1. Install GitHub Copilot

**VS Code:**
```bash
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

**JetBrains IDEs:**
- Install from IDE Plugin Marketplace
- Search for "GitHub Copilot"

### 2. Configure Copilot for Your Project

The setup script creates `.github/copilot/instructions.md` with project-specific guidance for Copilot.

**Manual Setup:**
```bash
mkdir -p .github/copilot
# Edit .github/copilot/instructions.md with your project guidelines
```

### 3. Workspace Settings

Create `.vscode/settings.json`:
```json
{
  "github.copilot.enable": {
    "*": true
  },
  "github.copilot.advanced": {
    "inlineSuggestCount": 3
  },
  "editor.inlineSuggest.enabled": true
}
```

## Copilot Instructions Format

### Basic Structure

```markdown
# GitHub Copilot Instructions

## Project Context
[Brief description of your project]

## Coding Standards
- Follow standards in specs/code-standards.md
- Use [style guide]
- Naming conventions: [conventions]

## Common Patterns
[List common patterns used in codebase]

## Examples
[Show examples of good code from your project]
```

### Language-Specific Instructions

#### JavaScript/TypeScript
```markdown
## JavaScript Guidelines
- Use modern ES6+ syntax
- Prefer async/await over callbacks
- Use TypeScript types
- Follow ESLint rules

## Common Patterns
- API calls with error handling
- React hooks best practices
- Express middleware patterns
```

#### Python
```markdown
## Python Guidelines
- Follow PEP 8
- Use type hints
- Write docstrings
- Use pytest for tests

## Common Patterns
- Context managers for resources
- List comprehensions
- Decorator patterns
```

#### Go
```markdown
## Go Guidelines
- Follow Go idioms
- Error handling patterns
- Use defer for cleanup
- Table-driven tests

## Common Patterns
- Interface-based design
- Goroutines and channels
- Struct methods
```

## Copilot + Claude Workflow

### 1. Architecture with Claude

Use Claude for high-level decisions:
```
@technicalManager --review-architecture

# Claude provides:
# - Architecture analysis
# - Design patterns
# - Scalability recommendations
```

### 2. Implementation with Copilot

Use Copilot for code completion:
```javascript
// Type comment and let Copilot complete
// Create a function to validate email addresses

// Copilot suggests:
function validateEmail(email) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}
```

### 3. Review with Claude

Use Claude for code review:
```
@respond_to_all_code_reviews

# Claude:
# - Analyzes feedback
# - Makes changes
# - Responds to comments
```

### 4. Testing with Both

**Copilot**: Generate test cases
```javascript
// Write tests for validateEmail function
describe('validateEmail', () => {
  it('accepts valid emails', () => {
    expect(validateEmail('test@example.com')).toBe(true);
  });
  // Copilot continues...
});
```

**Claude**: Test strategy
```
@work_on_ticket_engineer PROJ-123

# Claude creates comprehensive test plan
```

## Best Practices

### When to Use Copilot

✓ **Good for:**
- Code completion
- Boilerplate code
- Similar patterns to existing code
- Quick refactoring
- Test generation
- Documentation comments

### When to Use Claude

✓ **Good for:**
- Complex logic
- Architecture decisions
- Multi-file changes
- Workflow automation
- Code review analysis
- Bug investigation

### Combining Both

**Example Workflow:**

1. **Plan with Claude:**
   ```
   @work_on_ticket_engineer PROJ-123
   ```
   Claude creates implementation plan

2. **Implement with Copilot:**
   ```javascript
   // Following Claude's plan
   // Implement user authentication
   ```
   Copilot suggests code

3. **Refine with Claude:**
   ```
   Review this authentication code for security issues
   ```
   Claude provides security analysis

4. **Test with Copilot:**
   ```javascript
   // Generate tests
   ```
   Copilot creates test cases

5. **Document with Claude:**
   ```
   Update documentation for new auth feature
   ```
   Claude updates docs

## Copilot Chat Features

### Code Explanation

```
/explain
# Copilot explains selected code
```

### Generate Tests

```
/tests
# Copilot generates test cases
```

### Fix Issues

```
/fix
# Copilot suggests fixes for problems
```

### Optimize Code

```
/optimize
# Copilot suggests performance improvements
```

## Custom Copilot Commands

### Setup Custom Commands

Create `.github/copilot/commands.json`:
```json
{
  "commands": [
    {
      "name": "review-security",
      "description": "Review code for security issues",
      "prompt": "Review this code for security vulnerabilities including SQL injection, XSS, CSRF, and authentication issues. Reference our security standards in specs/code-standards.md"
    },
    {
      "name": "add-error-handling",
      "description": "Add comprehensive error handling",
      "prompt": "Add proper error handling to this code including try-catch blocks, validation, and user-friendly error messages"
    },
    {
      "name": "generate-docs",
      "description": "Generate comprehensive documentation",
      "prompt": "Generate detailed documentation for this code including description, parameters, return values, examples, and edge cases"
    }
  ]
}
```

### Usage

```
/review-security
/add-error-handling
/generate-docs
```

## Integration with MCP

### Copilot with JIRA

In `.github/copilot/instructions.md`:
```markdown
## JIRA Integration
- Link commits to JIRA tickets: `feat(AUTH-123): add login`
- Reference acceptance criteria from JIRA
- Follow story requirements
```

### Copilot with Confluence

```markdown
## Documentation
- Follow Confluence standards
- Link to relevant docs
- Update docs with code changes
```

## Copilot Settings

### Aggressive Suggestions

```json
{
  "github.copilot.advanced": {
    "inlineSuggestCount": 5,
    "listCount": 10
  }
}
```

### Conservative Suggestions

```json
{
  "github.copilot.advanced": {
    "inlineSuggestCount": 1,
    "listCount": 3
  }
}
```

### Language-Specific Settings

```json
{
  "github.copilot.enable": {
    "javascript": true,
    "python": true,
    "markdown": false
  }
}
```

## Prompt Engineering for Copilot

### Good Comments

```javascript
// ✓ Good: Specific and descriptive
// Create a function that validates email addresses using regex,
// returns true for valid emails and false otherwise

// ✗ Bad: Too vague
// email function
```

### Context Matters

```javascript
// Copilot uses surrounding code for context
const users = await fetchUsers();

// Filter active users with premium subscription
// Copilot suggests based on users variable
const premiumUsers = users.filter(
  // Copilot completes...
);
```

## Troubleshooting

### Copilot Not Working

1. Check authentication: `Copilot: Sign In`
2. Verify subscription is active
3. Check internet connection
4. Restart IDE

### Poor Suggestions

1. Add more context in comments
2. Show examples in nearby code
3. Update `.github/copilot/instructions.md`
4. Be more specific in prompts

### Conflicts with Claude

- Use Copilot for completion
- Use Claude for reasoning
- Keep contexts separate
- Review all AI suggestions

## Advanced Integration

### Pre-commit Hooks

```bash
# .husky/pre-commit
#!/bin/sh

# Use Claude for review before commit
@respond_to_all_code_reviews
```

### CI/CD Integration

```yaml
# .github/workflows/copilot-review.yml
name: Copilot Code Review
on: [pull_request]
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Copilot Analysis
        run: # Use Copilot CLI for analysis
```

## Metrics and Analytics

Track usage:
- Copilot acceptance rate
- Most used suggestions
- Time saved
- Code quality improvement

## Resources

- [GitHub Copilot Docs](https://docs.github.com/copilot)
- [Copilot Best Practices](https://github.blog/2023-06-20-how-to-write-better-prompts-for-github-copilot/)
- [Claude + Copilot Examples](./examples/)

## See Also

- `CLAUDE.md` - Claude-specific documentation
- `ai_docs/anthropic-tool-use.md` - Claude tool use guide
- `specs/code-standards.md` - Coding standards
- `.claude/commands/` - Claude custom commands

---

**Maximize productivity by using both Copilot and Claude for their respective strengths!** 🚀
