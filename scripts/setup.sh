#!/bin/bash

# Interactive Setup Script for AI Agent Templates
# This script helps you configure the template for your preferred language and tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Welcome message
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   AI Agent Template Setup                 ║${NC}"
echo -e "${BLUE}║   Claude AI Development Environment        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Function to prompt for input with default
prompt_with_default() {
    local prompt=$1
    local default=$2
    local var_name=$3
    
    read -p "$(echo -e "${YELLOW}${prompt} ${NC}[${GREEN}${default}${NC}]: ")" input
    eval $var_name="\${input:-$default}"
}

# Function to select from options
select_option() {
    local prompt=$1
    shift
    local options=("$@")
    
    echo -e "${YELLOW}$prompt${NC}" >&2
    PS3="$(echo -e "${GREEN}Enter number: ${NC}")"
    select opt in "${options[@]}"; do
        if [[ -n $opt ]]; then
            echo "$opt"
            break
        fi
    done
}

# Detect existing language if possible
detect_language() {
    if [ -f "package.json" ]; then
        echo "javascript"
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        echo "python"
    elif [ -f "go.mod" ]; then
        echo "go"
    elif [ -f "pom.xml" ] || [ -f "build.gradle" ]; then
        echo "java"
    elif [ -f "*.csproj" ]; then
        echo "csharp"
    elif [ -f "Gemfile" ]; then
        echo "ruby"
    else
        echo "unknown"
    fi
}

# Main setup
echo -e "${GREEN}→${NC} Step 1: Language Selection"
echo ""

detected=$(detect_language)
if [ "$detected" != "unknown" ]; then
    echo -e "  ${BLUE}ℹ${NC}  Detected language: ${GREEN}$detected${NC}"
    read -p "  Use detected language? (y/n) [y]: " use_detected
    if [ "${use_detected:-y}" = "y" ]; then
        LANGUAGE=$detected
    fi
fi

if [ -z "$LANGUAGE" ]; then
    LANGUAGE=$(select_option "Select your primary programming language:" \
        "JavaScript/TypeScript (Node.js)" \
        "Python" \
        "Go" \
        "Java" \
        "C#/.NET" \
        "Ruby" \
        "Multiple Languages")
    
    # Map selection to language code
    case "$LANGUAGE" in
        "JavaScript/TypeScript (Node.js)") LANGUAGE="javascript" ;;
        "Python") LANGUAGE="python" ;;
        "Go") LANGUAGE="go" ;;
        "Java") LANGUAGE="java" ;;
        "C#/.NET") LANGUAGE="csharp" ;;
        "Ruby") LANGUAGE="ruby" ;;
        "Multiple Languages") LANGUAGE="multi" ;;
    esac
fi

echo -e "  ${GREEN}✓${NC} Language selected: ${GREEN}$LANGUAGE${NC}"
echo ""

# Step 2: Project Name
echo -e "${GREEN}→${NC} Step 2: Project Configuration"
echo ""
prompt_with_default "  Project name" "my-ai-project" PROJECT_NAME
prompt_with_default "  Project description" "AI-powered application" PROJECT_DESC
DEFAULT_DIR="${1:-.}"
prompt_with_default "  Target directory" "$DEFAULT_DIR" TARGET_DIR
echo ""

# Step 3: MCP Integration
echo -e "${GREEN}→${NC} Step 3: MCP (Model Context Protocol) Integration"
echo ""
read -p "  Enable JIRA integration? (y/n) [n]: " ENABLE_JIRA
read -p "  Enable Confluence integration? (y/n) [n]: " ENABLE_CONFLUENCE
read -p "  Enable custom MCP servers? (y/n) [n]: " ENABLE_CUSTOM_MCP
echo ""

# Step 4: GitHub Copilot Integration
echo -e "${GREEN}→${NC} Step 4: GitHub Copilot Integration"
echo ""
read -p "  Enable GitHub Copilot extensions? (y/n) [y]: " ENABLE_COPILOT
read -p "  Configure Copilot workspace settings? (y/n) [y]: " CONFIG_COPILOT_WORKSPACE
echo ""

# Step 5: Additional Features
echo -e "${GREEN}→${NC} Step 5: Additional Features"
echo ""
read -p "  Initialize git repository? (y/n) [y]: " INIT_GIT
read -p "  Install dependencies? (y/n) [y]: " INSTALL_DEPS
read -p "  Create example project? (y/n) [y]: " CREATE_EXAMPLE
echo ""

# Summary
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Configuration Summary                    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Language:           ${GREEN}$LANGUAGE${NC}"
echo -e "  Project Name:       ${GREEN}$PROJECT_NAME${NC}"
echo -e "  Target Directory:   ${GREEN}$TARGET_DIR${NC}"
echo -e "  JIRA:               ${GREEN}${ENABLE_JIRA:-n}${NC}"
echo -e "  Confluence:         ${GREEN}${ENABLE_CONFLUENCE:-n}${NC}"
echo -e "  GitHub Copilot:     ${GREEN}${ENABLE_COPILOT:-y}${NC}"
echo ""
read -p "$(echo -e "${YELLOW}Proceed with setup? ${NC}(y/n) [y]: ")" PROCEED

if [ "${PROCEED:-y}" != "y" ]; then
    echo -e "${RED}Setup cancelled.${NC}"
    exit 0
fi

echo ""
echo -e "${GREEN}→${NC} Setting up project..."
echo ""

# Resolve paths
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$REPO_ROOT/templates"
CONFIG_DIR="$REPO_ROOT/config"

# Create and move to target directory
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    echo -e "  ${GREEN}✓${NC} Created target directory: $TARGET_DIR"
fi
cd "$TARGET_DIR"

# Create language-specific configuration
echo -e "  ${BLUE}→${NC} Creating language-specific files..."

case "$LANGUAGE" in
    "javascript")
        # Copy JavaScript template
        if [ -d "$TEMPLATES_DIR/languages/javascript" ]; then
            cp -r "$TEMPLATES_DIR/languages/javascript/"* .
        fi
        
        # Create package.json if it doesn't exist
        if [ ! -f "package.json" ]; then
            cat > package.json <<EOF
{
  "name": "$PROJECT_NAME",
  "version": "1.0.0",
  "description": "$PROJECT_DESC",
  "main": "index.js",
  "scripts": {
    "test": "jest",
    "lint": "eslint .",
    "dev": "node index.js"
  },
  "keywords": ["ai", "claude", "automation"],
  "author": "",
  "license": "MIT",
  "dependencies": {
    "@anthropic-ai/sdk": "^0.30.0",
    "dotenv": "^16.0.0"
  },
  "devDependencies": {
    "eslint": "^8.0.0",
    "jest": "^29.0.0"
  }
}
EOF
        fi
        
        # Create .eslintrc.json
        cat > .eslintrc.json <<EOF
{
  "env": {
    "node": true,
    "es2021": true
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "rules": {
    "indent": ["error", 2],
    "quotes": ["error", "single"],
    "semi": ["error", "always"]
  }
}
EOF
        echo -e "    ${GREEN}✓${NC} Created Node.js configuration files"
        ;;
        
    "python")
        # Copy Python template
        if [ -d "$TEMPLATES_DIR/languages/python" ]; then
            cp -r "$TEMPLATES_DIR/languages/python/"* .
        fi
        
        # Create requirements.txt if it doesn't exist
        if [ ! -f "requirements.txt" ]; then
            cat > requirements.txt <<EOF
anthropic>=0.30.0
python-dotenv>=1.0.0
pytest>=8.0.0
black>=24.0.0
pylint>=3.0.0
EOF
        fi
        
        # Create pyproject.toml
        cat > pyproject.toml <<EOF
[tool.black]
line-length = 88
target-version = ['py38']

[tool.pylint]
max-line-length = 88

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_classes = "Test*"
python_functions = "test_*"
EOF
        echo -e "    ${GREEN}✓${NC} Created Python configuration files"
        ;;
        
    "go")
        # Create go.mod if it doesn't exist
        if [ ! -f "go.mod" ]; then
            go mod init "$PROJECT_NAME" 2>/dev/null || true
        fi
        echo -e "    ${GREEN}✓${NC} Created Go configuration files"
        ;;
        
    "java")
        # Create Maven pom.xml or Gradle build.gradle
        if [ ! -f "pom.xml" ] && [ ! -f "build.gradle" ]; then
            cat > pom.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>$PROJECT_NAME</artifactId>
    <version>1.0.0</version>
    
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
</project>
EOF
        fi
        echo -e "    ${GREEN}✓${NC} Created Java configuration files"
        ;;
        
    "csharp")
        # Create .NET project file
        if ! ls *.csproj 1> /dev/null 2>&1; then
            cat > "$PROJECT_NAME.csproj" <<EOF
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>
</Project>
EOF
        fi
        echo -e "    ${GREEN}✓${NC} Created C# configuration files"
        ;;
        
    "ruby")
        # Create Gemfile if it doesn't exist
        if [ ! -f "Gemfile" ]; then
            cat > Gemfile <<EOF
source 'https://rubygems.org'

gem 'anthropic', '~> 0.1'
gem 'dotenv', '~> 2.8'

group :development, :test do
  gem 'rspec', '~> 3.12'
  gem 'rubocop', '~> 1.50'
end
EOF
        fi
        echo -e "    ${GREEN}✓${NC} Created Ruby configuration files"
        ;;
esac

# Setup .env file
echo -e "  ${BLUE}→${NC} Creating environment configuration..."
if [ ! -f ".env" ]; then
    if [ -f "$CONFIG_DIR/.env.example" ]; then
        cp "$CONFIG_DIR/.env.example" .env
    else
        cat > .env <<EOF
# Anthropic API Configuration
ANTHROPIC_API_KEY=your_api_key_here
CLAUDE_MODEL=claude-3-5-sonnet-20241022
MAX_TOKENS=4096
TEMPERATURE=1.0
EOF
    fi
    echo -e "    ${GREEN}✓${NC} Created .env file"
fi

# Setup MCP if enabled
if [ "${ENABLE_JIRA}" = "y" ] || [ "${ENABLE_CONFLUENCE}" = "y" ]; then
    echo -e "  ${BLUE}→${NC} Configuring MCP integration..."
    
    # Create or update .mcp.json
    cat > .mcp.json <<EOF
{
  "mcpServers": {
EOF

    if [ "${ENABLE_JIRA}" = "y" ]; then
        cat >> .mcp.json <<EOF
    "jira": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-jira"],
      "env": {
        "JIRA_URL": "https://your-domain.atlassian.net",
        "JIRA_EMAIL": "your-email@example.com",
        "JIRA_API_TOKEN": "your-jira-api-token"
      }
    }EOF
        [ "${ENABLE_CONFLUENCE}" = "y" ] && echo "," >> .mcp.json
        echo "" >> .mcp.json
    fi

    if [ "${ENABLE_CONFLUENCE}" = "y" ]; then
        cat >> .mcp.json <<EOF
    "confluence": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-confluence"],
      "env": {
        "CONFLUENCE_URL": "https://your-domain.atlassian.net/wiki",
        "CONFLUENCE_EMAIL": "your-email@example.com",
        "CONFLUENCE_API_TOKEN": "your-confluence-api-token"
      }
    }
EOF
    fi

    cat >> .mcp.json <<EOF
  }
}
EOF
    echo -e "    ${GREEN}✓${NC} MCP configuration created"
fi

# Setup GitHub Copilot integration
if [ "${ENABLE_COPILOT:-y}" = "y" ]; then
    echo -e "  ${BLUE}→${NC} Configuring GitHub Copilot integration..."
    
    mkdir -p .github/copilot
    
    cat > .github/copilot/instructions.md <<EOF
# GitHub Copilot Instructions for $PROJECT_NAME

## Project Overview
$PROJECT_DESC

This project uses Claude AI for development assistance with the following setup:
- Language: $LANGUAGE
- AI Model: Claude 3.5 Sonnet
- Integration: MCP (Model Context Protocol)

## Coding Standards
- Follow the standards in \`specs/code-standards.md\`
- Write tests for all new functionality
- Document public APIs with clear comments
- Use consistent naming conventions

## AI Assistant Guidelines
When generating code:
1. Follow project conventions from existing code
2. Include error handling and validation
3. Add inline comments for complex logic
4. Write accompanying tests
5. Consider performance and scalability

## Language-Specific Notes
$(case "$LANGUAGE" in
    "javascript") echo "- Use modern ES6+ syntax
- Prefer async/await over callbacks
- Use TypeScript types when available
- Follow ESLint rules" ;;
    "python") echo "- Follow PEP 8 style guidelines
- Use type hints for function signatures
- Write docstrings for all functions
- Use pytest for testing" ;;
    "go") echo "- Follow Go idioms and conventions
- Use error handling best practices
- Write table-driven tests
- Keep functions focused and small" ;;
    "java") echo "- Follow Java naming conventions
- Use meaningful variable names
- Prefer composition over inheritance
- Write JUnit tests" ;;
    "csharp") echo "- Follow C# coding conventions
- Use LINQ when appropriate
- Implement IDisposable for resources
- Write xUnit tests" ;;
    "ruby") echo "- Follow Ruby style guide
- Use meaningful method names
- Prefer blocks and iterators
- Write RSpec tests" ;;
esac)

## Project Structure
Follow the organization in the project root:
- \`.claude/\` - Claude-specific commands and configs
- \`ai_docs/\` - AI integration documentation
- \`specs/\` - Project specifications
- \`scripts/\` - Utility scripts

## Integration with Claude
This project is optimized for Claude AI development. Use the custom commands in \`.claude/commands/\` for common workflows.
EOF

    if [ "${CONFIG_COPILOT_WORKSPACE:-y}" = "y" ]; then
        mkdir -p .vscode
        cat > .vscode/settings.json <<EOF
{
  "github.copilot.enable": {
    "*": true
  },
  "github.copilot.advanced": {
    "inlineSuggestCount": 3
  },
  "editor.inlineSuggest.enabled": true,
  "editor.quickSuggestions": {
    "comments": true,
    "strings": true,
    "other": true
  }
}
EOF
    fi
    
    echo -e "    ${GREEN}✓${NC} GitHub Copilot configuration created"
fi

# Initialize git if requested
if [ "${INIT_GIT:-y}" = "y" ] && [ ! -d ".git" ]; then
    echo -e "  ${BLUE}→${NC} Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: AI Agent Template setup for $LANGUAGE"
    echo -e "    ${GREEN}✓${NC} Git repository initialized"
fi

# Install dependencies if requested
if [ "${INSTALL_DEPS:-y}" = "y" ]; then
    echo -e "  ${BLUE}→${NC} Installing dependencies..."
    
    case "$LANGUAGE" in
        "javascript")
            if command -v npm &> /dev/null; then
                npm install
                echo -e "    ${GREEN}✓${NC} Node.js dependencies installed"
            else
                echo -e "    ${YELLOW}⚠${NC}  npm not found. Please install Node.js and run 'npm install'"
            fi
            ;;
        "python")
            if command -v pip &> /dev/null; then
                pip install -r requirements.txt
                echo -e "    ${GREEN}✓${NC} Python dependencies installed"
            else
                echo -e "    ${YELLOW}⚠${NC}  pip not found. Please install Python and run 'pip install -r requirements.txt'"
            fi
            ;;
        "go")
            if command -v go &> /dev/null; then
                go mod tidy
                echo -e "    ${GREEN}✓${NC} Go dependencies installed"
            else
                echo -e "    ${YELLOW}⚠${NC}  go not found. Please install Go and run 'go mod tidy'"
            fi
            ;;
        "ruby")
            if command -v bundle &> /dev/null; then
                bundle install
                echo -e "    ${GREEN}✓${NC} Ruby dependencies installed"
            else
                echo -e "    ${YELLOW}⚠${NC}  bundler not found. Please install Ruby and run 'bundle install'"
            fi
            ;;
    esac
fi

# Create example if requested
if [ "${CREATE_EXAMPLE:-y}" = "y" ]; then
    echo -e "  ${BLUE}→${NC} Creating example project..."
    mkdir -p examples/$LANGUAGE-example
    echo -e "    ${GREEN}✓${NC} Example directory created at examples/$LANGUAGE-example/"
fi

# Final success message
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Setup Complete! 🎉                       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Your AI Agent Template is ready for ${GREEN}$LANGUAGE${NC} development!"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. Add your Anthropic API key to ${GREEN}.env${NC}"
[ "${ENABLE_JIRA}" = "y" ] && echo -e "  2. Configure JIRA credentials in ${GREEN}.mcp.json${NC}"
[ "${ENABLE_CONFLUENCE}" = "y" ] && echo -e "  3. Configure Confluence credentials in ${GREEN}.mcp.json${NC}"
echo -e "  4. Review the custom commands in ${GREEN}.claude/commands/${NC}"
echo -e "  5. Read ${GREEN}CLAUDE.md${NC} for usage instructions"
echo -e "  6. Start building with: ${GREEN}@work_on_ticket_engineer${NC}"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo -e "  - Getting Started: ${GREEN}docs/getting-started.md${NC}"
echo -e "  - Best Practices: ${GREEN}docs/best-practices.md${NC}"
echo -e "  - API Reference: ${GREEN}ai_docs/tool-use.md${NC}"
echo -e "  - Worktree Management: ${GREEN}scripts/worktree*.sh${NC}"
echo ""
echo -e "${YELLOW}Happy coding with Claude AI! 🚀${NC}"
echo ""
