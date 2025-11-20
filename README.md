# Claude AI Development Templates

A comprehensive organization template for Claude AI development projects, featuring multi-language support, documentation, configuration files, prompt engineering resources, and best practices.

## 📋 Overview

This repository serves as a professional template for teams and developers building applications with Claude AI (Anthropic). It includes everything you need to get started with Claude AI development, from basic setup to advanced prompt engineering techniques, with full support for multiple programming languages and GitHub Copilot integration.

## 🚀 Quick Start

### Interactive Setup

Run the interactive setup script to configure your project:

**Linux/macOS:**
```bash
./scripts/setup.sh
```

**Windows (PowerShell):**
```powershell
.\scripts\setup.ps1
```

The setup wizard will:
- Detect or ask for your preferred programming language
- Configure language-specific settings
- Allow you to specify a target directory for the project (defaults to current directory)
- Set up MCP integration (JIRA, Confluence)
- Configure GitHub Copilot integration
- Create example projects
- Install dependencies

**Note:** You can specify any directory path (including non-existent nested paths) as the target directory. The setup script will create the directory structure and set up the project there.

### Manual Setup

1. **Clone this repository**
   ```bash
   git clone https://github.com/moclaw/ai-agent-templates.git
   cd ai-agent-templates
   ```

2. **Set up your environment**
   ```bash
   cp config/.env.example .env
   # Edit .env with your Claude API key
   ```

3. **Choose your language template**
   ```bash
   # Available templates:
   # - templates/languages/javascript
   # - templates/languages/python
   # - templates/languages/go
   # - templates/languages/java
   # - templates/languages/csharp
   # - templates/languages/ruby
   # - templates/languages/multi (for polyglot projects)
   ```

## 🎯 Features

### 🌐 Multi-Language Support
- **JavaScript/TypeScript** - Node.js applications with full TypeScript support
- **Python** - Python 3.8+ with async/await patterns
- **Go** - Go 1.19+ with idiomatic Go patterns
- **Java** - Java 17+ with Maven/Gradle support
- **C#/.NET** - .NET 8+ applications
- **Ruby** - Ruby 3.0+ applications
- **Multi-Language** - Support for polyglot projects

Each language template includes:
- Language-specific configuration files
- Claude AI integration examples
- Testing frameworks
- Linting and formatting tools
- Best practices documentation

### 🤖 GitHub Copilot Integration
- **Dual AI Assistant Support**: Use both Claude and Copilot together
- **Copilot Instructions**: Project-specific guidance in `.github/copilot/`
- **Custom Commands**: Copilot commands for common tasks
- **Workspace Settings**: VS Code/JetBrains configuration
- **Best Practices**: When to use Copilot vs Claude

See [ai_docs/copilot.md](ai_docs/copilot.md) for details.

### 🔧 Configuration Management
- Pre-configured templates for Claude API integration
- Environment-based configuration
- MCP (Model Context Protocol) integration
- Language-specific settings

### 📚 Comprehensive Documentation
- Detailed guides for all experience levels
- Language-specific best practices
- API integration examples
- Troubleshooting guides

### 💡 Prompt Engineering
- Curated collection of prompt patterns
- Custom Claude commands for workflows
- Tool use examples
- Testing frameworks for prompts

### 🔨 Example Projects
- Working examples for common use cases
- Language-specific implementations
- Integration demonstrations
- Production-ready patterns

### ✅ Testing & Validation
- Test frameworks for each language
- Prompt testing utilities
- CI/CD integration examples
- Quality assurance tools

### 🚢 Deployment Guides
- Production deployment strategies
- Environment management
- Monitoring and logging
- Security best practices

## 📁 Repository Structure

```
.
├── .claude/                    # Claude Code configuration
│   ├── commands/              # Custom Claude commands (13 files)
│   │   ├── setup.md
│   │   ├── infinite.md
│   │   ├── auto-merge-prs.md
│   │   ├── prime.md
│   │   ├── prompts.md
│   │   ├── reflection.md
│   │   ├── respond-reviews.md
│   │   ├── tech-manager.md
│   │   ├── tech-reorg.md
│   │   ├── engineer.md
│   │   ├── parallel.md
│   │   ├── pr-comments.md
│   │   └── support.md
│   ├── settings.json          # Global Claude settings
│   └── settings.local.json    # Local Claude settings override
├── .github/                   # GitHub configuration
│   └── copilot/               # GitHub Copilot instructions
├── ai_docs/                   # AI-related documentation
│   ├── tool-use.md            # Anthropic tool usage guide
│   ├── copilot.md             # Copilot integration guide
│   ├── jira-confluence.md     # JIRA/Confluence MCP
│   ├── react-native.md       # React Native development
│   └── supabase.md           # Supabase integration
├── scripts/                   # Utility scripts
│   ├── worktree-cleanup.sh    # Clean up git worktrees
│   ├── worktree.sh            # Create individual worktree
│   ├── worktree-batch.sh      # Batch worktree creation
│   ├── setup.sh              # Interactive setup wizard (Linux/macOS)
│   └── setup.ps1             # Interactive setup wizard (Windows)
├── specs/                     # Project specifications
│   ├── code-standards.md      # Universal code standards
│   ├── project-management.md  # AI-assisted project management
│   └── project_plan.md        # Master project overview
├── templates/                 # Language templates
│   └── languages/             # Language-specific templates
│       ├── javascript/        # JavaScript/TypeScript
│       ├── python/            # Python
│       ├── go/                # Go
│       ├── java/              # Java
│       ├── csharp/            # C#/.NET
│       ├── ruby/              # Ruby
│       └── multi/             # Multi-language
├── .gitignore                 # Git ignore rules
├── .mcp.json                  # MCP server configuration
├── CLAUDE.md                  # Claude-specific documentation
├── CONTRIBUTING.md            # Contribution guidelines
├── LICENSE                    # MIT License
└── README.md                  # This file
```

## 📖 Documentation

### Core Guides
- [CLAUDE.md](CLAUDE.md) - Claude-specific documentation and usage
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [AI Docs](ai_docs/) - AI integration guides

### Language-Specific
- [JavaScript/TypeScript](templates/languages/javascript/README.md)
- [Python](templates/languages/python/README.md)
- [Go](templates/languages/go/README.md)
- [Multi-Language](templates/languages/multi/README.md)

### Integration Guides
- [Anthropic Tool Use](ai_docs/tool-use.md)
- [GitHub Copilot Integration](ai_docs/copilot.md)
- [JIRA & Confluence MCP](ai_docs/jira-confluence.md)
- [React Native](ai_docs/react-native.md)
- [Supabase](ai_docs/supabase.md)

## 🛠️ Configuration

### Environment Variables

Create a `.env` file based on `.env.example`:

```env
ANTHROPIC_API_KEY=your_api_key_here
CLAUDE_MODEL=claude-3-5-sonnet-20241022
MAX_TOKENS=4096
TEMPERATURE=1.0
```

### Language Selection

The interactive setup script (`scripts/setup.sh` or `scripts/setup.ps1` on Windows) will:
1. Detect your current language (if applicable)
2. Ask for language preference
3. Generate language-specific configuration
4. Set up development environment
5. Install dependencies

### MCP Integration

Configure MCP servers in `.mcp.json` for:
- JIRA integration
- Confluence integration
- Custom MCP servers

### GitHub Copilot

Configure Copilot in:
- `.github/copilot/instructions.md` - Project-specific guidance
- `.vscode/settings.json` - Workspace settings

## 💻 Usage Examples

### Starting a New Project

**Linux/macOS:**
```bash
# Run interactive setup
./scripts/setup.sh

# Follow prompts to:
# - Select language
# - Configure integrations
# - Set up GitHub Copilot
# - Create example project
```

**Windows (PowerShell):**
```powershell
# Run interactive setup
.\scripts\setup.ps1

# Follow prompts to:
# - Select language
# - Configure integrations
# - Set up GitHub Copilot
# - Create example project
```

### Using Claude Commands

In Claude Desktop/Code:
```
@engineer PROJ-123
@prime --focus backend
@reflection --deep
@tech-manager --plan-sprint
```

### Using with GitHub Copilot

1. Write clear comments for Copilot
2. Use Claude for architecture decisions
3. Use Copilot for code completion
4. Use Claude for code review

See [GitHub Copilot Integration Guide](ai_docs/copilot.md) for details.

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Resources

### Official Documentation
- [Anthropic API Documentation](https://docs.anthropic.com/)
- [Claude Model Documentation](https://docs.anthropic.com/claude/docs)
- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [MCP Documentation](https://modelcontextprotocol.io/)

### Community
- [GitHub Discussions](https://github.com/moclaw/ai-agent-templates/discussions)
- [Issues](https://github.com/moclaw/ai-agent-templates/issues)

## 📧 Support

- **Issues**: [GitHub Issues](https://github.com/moclaw/ai-agent-templates/issues)
- **Discussions**: [GitHub Discussions](https://github.com/moclaw/ai-agent-templates/discussions)

## 🙏 Acknowledgments

- Thanks to Anthropic for creating Claude
- GitHub Copilot team for AI-assisted development tools
- Community contributors and maintainers
- All developers using this template

---

**Built with ❤️ for the Claude AI and GitHub Copilot community** 🚀