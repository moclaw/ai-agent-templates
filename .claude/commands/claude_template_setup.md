# Claude Template Setup Guide

This guide helps you set up a new project using the Claude AI development template.

## Prerequisites

- Claude Desktop or Claude Code installed
- Git configured
- Node.js 16+ or Python 3.8+ (depending on your project type)
- Anthropic API key

## Quick Setup

1. **Clone or Use This Template**
   ```bash
   git clone <your-repo-url>
   cd <your-project>
   ```

2. **Configure Environment**
   ```bash
   # Copy environment template
   cp .env.example .env
   
   # Edit .env and add your API key
   ANTHROPIC_API_KEY=sk-ant-api03-xxxxx
   ```

3. **Install Dependencies**
   
   For Node.js projects:
   ```bash
   npm install
   ```
   
   For Python projects:
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure Claude Settings**
   - Review `.claude/settings.json` for global settings
   - Create `.claude/settings.local.json` for local overrides (not committed)

5. **Review Custom Commands**
   Explore `.claude/commands/` for available workflows:
   - `work_on_ticket_engineer.md` - Standard development workflow
   - `prompt_writer.md` - Prompt engineering assistance
   - `reflection.md` - Project analysis and planning

## Project Structure

```
your-project/
├── .claude/              # Claude configuration
├── ai_docs/              # AI-specific documentation
├── scripts/              # Utility scripts
├── specs/                # Project specifications
├── src/                  # Source code
└── tests/                # Test files
```

## Next Steps

1. Review the project specifications in `specs/`
2. Read through `ai_docs/` for integration guides
3. Start development using Claude commands
4. Use `@technicalManager` for project planning
5. Use `@work_on_ticket_engineer` for implementation

## Custom Commands Usage

In Claude Desktop/Code, you can reference commands with `@` syntax:
- `@work_on_ticket_engineer` - Start working on a ticket
- `@prompt_writer` - Get help writing prompts
- `@reflection` - Analyze project structure

## Troubleshooting

### API Key Issues
- Ensure `.env` file exists and has correct API key
- Check key has proper permissions in Anthropic console

### Command Not Found
- Verify `.claude/commands/` directory structure
- Restart Claude Desktop/Code to reload commands

### Settings Not Applied
- Check `.claude/settings.json` syntax
- Local settings override global settings

## Resources

- [Claude Documentation](https://docs.anthropic.com/)
- [MCP Documentation](https://modelcontextprotocol.io/)
- Project-specific docs in `ai_docs/`
