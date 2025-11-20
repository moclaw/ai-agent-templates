# Contributing to AI Agent Templates

We welcome contributions! This guide will help you get started.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards others

## How to Contribute

### Reporting Bugs

1. Check if the bug already exists in [Issues](https://github.com/moclaw/ai-agent-templates/issues)
2. If not, create a new issue with:
   - Clear title
   - Detailed description
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details
   - Screenshots if applicable

### Suggesting Features

1. Check [Discussions](https://github.com/moclaw/ai-agent-templates/discussions) for similar ideas
2. Create a new discussion with:
   - Clear use case
   - Expected benefits
   - Potential implementation approach
   - Examples from other projects

### Submitting Changes

1. **Fork the repository**

```bash
git clone https://github.com/moclaw/ai-agent-templates.git
cd ai-agent-templates
```

2. **Create a branch**

```bash
git checkout -b feature/your-feature-name
```

Use prefixes:
- `feature/` for new features
- `fix/` for bug fixes
- `docs/` for documentation
- `refactor/` for refactoring

3. **Make your changes**

- Follow code standards in `specs/code-standards.md`
- Add tests for new functionality
- Update documentation as needed
- Ensure all tests pass

4. **Commit your changes**

```bash
git add .
git commit -m "feat: add awesome feature"
```

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` new feature
- `fix:` bug fix
- `docs:` documentation
- `style:` formatting
- `refactor:` code restructuring
- `test:` adding tests
- `chore:` maintenance

5. **Push to your fork**

```bash
git push origin feature/your-feature-name
```

6. **Create Pull Request**

- Go to the original repository
- Click "New Pull Request"
- Select your branch
- Fill in the PR template
- Link related issues

## Development Setup

### Prerequisites

- Node.js 16+ or Python 3.8+
- Git
- Anthropic API key (for testing)

### Installation

```bash
# Clone your fork
git clone https://github.com/YOUR-USERNAME/ai-agent-templates.git

# Install dependencies (if applicable)
npm install
# or
pip install -r requirements.txt

# Copy environment template
cp config/.env.example .env

# Add your API key to .env
```

### Running Tests

```bash
# Run all tests
npm test

# Run specific test
npm test -- path/to/test

# Run with coverage
npm run test:coverage
```

### Linting

```bash
# Check code style
npm run lint

# Auto-fix issues
npm run lint:fix
```

## Pull Request Guidelines

### Before Submitting

- [ ] Code follows style guidelines
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] Commit messages follow convention
- [ ] No merge conflicts
- [ ] Branch is up to date with main

### PR Description Template

```markdown
## Description
[Clear description of changes]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Related Issues
Fixes #123
Related to #456

## Testing
[How to test the changes]

## Screenshots
[If applicable]

## Checklist
- [ ] Tests pass
- [ ] Docs updated
- [ ] Follows code standards
- [ ] Reviewed own code
```

### Review Process

1. Maintainer will review your PR
2. Address any feedback
3. Once approved, PR will be merged
4. Your contribution will be in the next release!

## Documentation

### Updating Docs

- Keep documentation in sync with code
- Use clear, simple language
- Include examples
- Add screenshots for UI changes

### Documentation Structure

```
docs/
├── getting-started.md
├── best-practices.md
├── api-reference.md
└── ...

ai_docs/
├── anthropic-tool-use.md
├── jira-and-confluence-tool-use.md
└── ...
```

## Adding Custom Commands

To add a new Claude command:

1. Create `.claude/commands/your-command.md`
2. Follow existing command format
3. Update `.claude/settings.json` if needed
4. Add documentation
5. Test the command
6. Submit PR

Example structure:

```markdown
# Your Command Name

## Purpose
[What it does]

## Usage
```
@your_command [options]
```

## Examples
[Usage examples]

## Configuration
[Settings if any]

## See Also
[Related commands]
```

## Adding Examples

To add an example project:

1. Create directory in `examples/your-example/`
2. Include:
   - README.md
   - Complete code
   - Tests
   - Documentation
3. Ensure it works
4. Submit PR

## Style Guide

### Code Style

- 2 spaces for indentation
- Semicolons in JavaScript
- camelCase for variables
- PascalCase for classes/components
- UPPER_CASE for constants

### Documentation Style

- Use Markdown
- Clear headings
- Code blocks with language specified
- Examples for complex topics
- Link to related docs

### Commit Style

```
<type>(<scope>): <subject>

<body>

<footer>
```

Example:
```
feat(commands): add batch processing command

Added new command for processing multiple tickets in parallel.
Includes error handling and progress tracking.

Closes #123
```

## Getting Help

### Questions

- GitHub Discussions for general questions
- GitHub Issues for bugs
- Code review comments for PR-specific questions

### Community

- Be patient and respectful
- Search before asking
- Provide context and examples
- Share what you've tried

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Credited in documentation

Thank you for contributing! 🎉
