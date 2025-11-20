# Interactive Setup Script for AI Agent Templates (PowerShell)
# This script helps you configure the template for your preferred language and tools

param(
    [string]$TargetDirectory
)

# Stop on errors
$ErrorActionPreference = "Stop"

# Colors for output
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

# Welcome message
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   AI Agent Template Setup                 ║" -ForegroundColor Cyan
Write-Host "║   Claude AI Development Environment        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Function to prompt for input with default
function Get-InputWithDefault {
    param(
        [string]$Prompt,
        [string]$Default
    )
    
    $input = Read-Host "$Prompt [$Default]"
    if ([string]::IsNullOrWhiteSpace($input)) {
        return $Default
    }
    return $input
}

# Function to select from options
function Select-Option {
    param(
        [string]$Prompt,
        [string[]]$Options
    )
    
    Write-Host $Prompt -ForegroundColor Yellow
    Write-Host ""
    
    for ($i = 0; $i -lt $Options.Length; $i++) {
        Write-Host "  $($i + 1). $($Options[$i])"
    }
    
    do {
        $selection = Read-Host "`nEnter number (1-$($Options.Length))"
        $index = [int]$selection - 1
    } while ($index -lt 0 -or $index -ge $Options.Length)
    
    return $Options[$index]
}

# Detect existing language if possible
function Get-DetectedLanguage {
    if (Test-Path "package.json") {
        return "javascript"
    }
    elseif ((Test-Path "requirements.txt") -or (Test-Path "pyproject.toml")) {
        return "python"
    }
    elseif (Test-Path "go.mod") {
        return "go"
    }
    elseif ((Test-Path "pom.xml") -or (Test-Path "build.gradle")) {
        return "java"
    }
    elseif (Get-ChildItem -Filter "*.csproj" -ErrorAction SilentlyContinue) {
        return "csharp"
    }
    elseif (Test-Path "Gemfile") {
        return "ruby"
    }
    else {
        return "unknown"
    }
}

# Main setup
Write-Host "→ Step 1: Language Selection" -ForegroundColor Green
Write-Host ""

$detected = Get-DetectedLanguage
if ($detected -ne "unknown") {
    Write-Host "  ℹ  Detected language: $detected" -ForegroundColor Blue
    $useDetected = Get-InputWithDefault "  Use detected language? (y/n)" "y"
    if ($useDetected -eq "y") {
        $LANGUAGE = $detected
    }
}

if (-not $LANGUAGE) {
    $languageChoice = Select-Option "Select your primary programming language:" @(
        "JavaScript/TypeScript (Node.js)",
        "Python",
        "Go",
        "Java",
        "C#/.NET",
        "Ruby",
        "Multiple Languages"
    )
    
    # Map selection to language code
    $LANGUAGE = switch ($languageChoice) {
        "JavaScript/TypeScript (Node.js)" { "javascript" }
        "Python" { "python" }
        "Go" { "go" }
        "Java" { "java" }
        "C#/.NET" { "csharp" }
        "Ruby" { "ruby" }
        "Multiple Languages" { "multi" }
    }
}

Write-Host "  ✓ Language selected: $LANGUAGE" -ForegroundColor Green
Write-Host ""

# Step 2: Project Name
Write-Host "→ Step 2: Project Configuration" -ForegroundColor Green
Write-Host ""
$PROJECT_NAME = Get-InputWithDefault "  Project name" "my-ai-project"
$PROJECT_DESC = Get-InputWithDefault "  Project description" "AI-powered application"
$defaultDir = if ([string]::IsNullOrWhiteSpace($TargetDirectory)) { "." } else { $TargetDirectory }
$TARGET_DIR = Get-InputWithDefault "  Target directory" $defaultDir
Write-Host ""

# Step 3: MCP Integration
Write-Host "→ Step 3: MCP (Model Context Protocol) Integration" -ForegroundColor Green
Write-Host ""
$ENABLE_JIRA = Get-InputWithDefault "  Enable JIRA integration? (y/n)" "n"
$ENABLE_CONFLUENCE = Get-InputWithDefault "  Enable Confluence integration? (y/n)" "n"
$ENABLE_CUSTOM_MCP = Get-InputWithDefault "  Enable custom MCP servers? (y/n)" "n"
Write-Host ""

# Step 4: GitHub Copilot Integration
Write-Host "→ Step 4: GitHub Copilot Integration" -ForegroundColor Green
Write-Host ""
$ENABLE_COPILOT = Get-InputWithDefault "  Enable GitHub Copilot extensions? (y/n)" "y"
$CONFIG_COPILOT_WORKSPACE = Get-InputWithDefault "  Configure Copilot workspace settings? (y/n)" "y"
Write-Host ""

# Step 5: Additional Features
Write-Host "→ Step 5: Additional Features" -ForegroundColor Green
Write-Host ""
$INIT_GIT = Get-InputWithDefault "  Initialize git repository? (y/n)" "y"
$INSTALL_DEPS = Get-InputWithDefault "  Install dependencies? (y/n)" "y"
$CREATE_EXAMPLE = Get-InputWithDefault "  Create example project? (y/n)" "y"
Write-Host ""

# Summary
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Configuration Summary                    ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Language:           $LANGUAGE" -ForegroundColor Green
Write-Host "  Project Name:       $PROJECT_NAME" -ForegroundColor Green
Write-Host "  Target Directory:   $TARGET_DIR" -ForegroundColor Green
Write-Host "  JIRA:               $ENABLE_JIRA" -ForegroundColor Green
Write-Host "  Confluence:         $ENABLE_CONFLUENCE" -ForegroundColor Green
Write-Host "  GitHub Copilot:     $ENABLE_COPILOT" -ForegroundColor Green
Write-Host ""
$PROCEED = Get-InputWithDefault "Proceed with setup? (y/n)" "y"

if ($PROCEED -ne "y") {
    Write-Host "Setup cancelled." -ForegroundColor Red
    exit 0
}

Write-Host ""
Write-Host "→ Setting up project..." -ForegroundColor Green
Write-Host ""

# Resolve template paths before changing directory
$ScriptRoot = $PSScriptRoot
$RepoRoot = Resolve-Path (Join-Path $ScriptRoot "..")
$TemplatesDir = Join-Path $RepoRoot "templates"
$ConfigDir = Join-Path $RepoRoot "config"

# Create and move to target directory
if (-not (Test-Path $TARGET_DIR)) {
    New-Item -ItemType Directory -Path $TARGET_DIR -Force | Out-Null
    Write-Host "  ✓ Created target directory: $TARGET_DIR" -ForegroundColor Green
}
Set-Location $TARGET_DIR

# Create language-specific configuration
Write-Host "  → Creating language-specific files..." -ForegroundColor Blue

switch ($LANGUAGE) {
    "javascript" {
        # Copy JavaScript template
        $JsTemplate = Join-Path $TemplatesDir "languages/javascript"
        if (Test-Path $JsTemplate) {
            Copy-Item -Path "$JsTemplate/*" -Destination "." -Recurse -Force
        }
        
        # Create package.json if it doesn't exist
        if (-not (Test-Path "package.json")) {
            @"
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
"@ | Out-File -FilePath "package.json" -Encoding utf8
        }
        
        # Create .eslintrc.json
        @"
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
"@ | Out-File -FilePath ".eslintrc.json" -Encoding utf8
        
        Write-Host "    ✓ Created Node.js configuration files" -ForegroundColor Green
    }
    
    "python" {
        # Copy Python template
        $PyTemplate = Join-Path $TemplatesDir "languages/python"
        if (Test-Path $PyTemplate) {
            Copy-Item -Path "$PyTemplate/*" -Destination "." -Recurse -Force
        }
        
        # Create requirements.txt if it doesn't exist
        if (-not (Test-Path "requirements.txt")) {
            @"
anthropic>=0.30.0
python-dotenv>=1.0.0
pytest>=8.0.0
black>=24.0.0
pylint>=3.0.0
"@ | Out-File -FilePath "requirements.txt" -Encoding utf8
        }
        
        # Create pyproject.toml
        @"
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
"@ | Out-File -FilePath "pyproject.toml" -Encoding utf8
        
        Write-Host "    ✓ Created Python configuration files" -ForegroundColor Green
    }
    
    "go" {
        # Create go.mod if it doesn't exist
        if (-not (Test-Path "go.mod")) {
            if (Get-Command go -ErrorAction SilentlyContinue) {
                & go mod init $PROJECT_NAME 2>$null
            }
        }
        Write-Host "    ✓ Created Go configuration files" -ForegroundColor Green
    }
    
    "java" {
        # Create Maven pom.xml
        if ((-not (Test-Path "pom.xml")) -and (-not (Test-Path "build.gradle"))) {
            @"
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
"@ | Out-File -FilePath "pom.xml" -Encoding utf8
        }
        Write-Host "    ✓ Created Java configuration files" -ForegroundColor Green
    }
    
    "csharp" {
        # Create .NET project file
        if (-not (Get-ChildItem -Filter "*.csproj" -ErrorAction SilentlyContinue)) {
            @"
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>
</Project>
"@ | Out-File -FilePath "$PROJECT_NAME.csproj" -Encoding utf8
        }
        Write-Host "    ✓ Created C# configuration files" -ForegroundColor Green
    }
    
    "ruby" {
        # Create Gemfile if it doesn't exist
        if (-not (Test-Path "Gemfile")) {
            @"
source 'https://rubygems.org'

gem 'anthropic', '~> 0.1'
gem 'dotenv', '~> 2.8'

group :development, :test do
  gem 'rspec', '~> 3.12'
  gem 'rubocop', '~> 1.50'
end
"@ | Out-File -FilePath "Gemfile" -Encoding utf8
        }
        Write-Host "    ✓ Created Ruby configuration files" -ForegroundColor Green
    }
}

# Setup .env file
Write-Host "  → Creating environment configuration..." -ForegroundColor Blue
if (-not (Test-Path ".env")) {
    $EnvExample = Join-Path $ConfigDir ".env.example"
    if (Test-Path $EnvExample) {
        Copy-Item $EnvExample ".env"
    }
    else {
        @"
# Anthropic API Configuration
ANTHROPIC_API_KEY=your_api_key_here
CLAUDE_MODEL=claude-3-5-sonnet-20241022
MAX_TOKENS=4096
TEMPERATURE=1.0
"@ | Out-File -FilePath ".env" -Encoding utf8
    }
}
Write-Host "    ✓ Created .env file" -ForegroundColor Green

# Setup MCP if enabled
if (($ENABLE_JIRA -eq "y") -or ($ENABLE_CONFLUENCE -eq "y")) {
    Write-Host "  → Configuring MCP integration..." -ForegroundColor Blue
    
    $mcpConfig = @{
        mcpServers = @{}
    }
    
    if ($ENABLE_JIRA -eq "y") {
        $mcpConfig.mcpServers.jira = @{
            command = "npx"
            args = @("-y", "@modelcontextprotocol/server-jira")
            env = @{
                JIRA_URL = "https://your-domain.atlassian.net"
                JIRA_EMAIL = "your-email@example.com"
                JIRA_API_TOKEN = "your-jira-api-token"
            }
        }
    }
    
    if ($ENABLE_CONFLUENCE -eq "y") {
        $mcpConfig.mcpServers.confluence = @{
            command = "npx"
            args = @("-y", "@modelcontextprotocol/server-confluence")
            env = @{
                CONFLUENCE_URL = "https://your-domain.atlassian.net/wiki"
                CONFLUENCE_EMAIL = "your-email@example.com"
                CONFLUENCE_API_TOKEN = "your-confluence-api-token"
            }
        }
    }
    
    $mcpConfig | ConvertTo-Json -Depth 10 | Out-File -FilePath ".mcp.json" -Encoding utf8
    Write-Host "    ✓ MCP configuration created" -ForegroundColor Green
}

# Setup GitHub Copilot integration
if ($ENABLE_COPILOT -eq "y") {
    Write-Host "  → Configuring GitHub Copilot integration..." -ForegroundColor Blue
    
    New-Item -Path ".github/copilot" -ItemType Directory -Force | Out-Null
    
    $languageNotes = switch ($LANGUAGE) {
        "javascript" { @"
- Use modern ES6+ syntax
- Prefer async/await over callbacks
- Use TypeScript types when available
- Follow ESLint rules
"@ }
        "python" { @"
- Follow PEP 8 style guidelines
- Use type hints for function signatures
- Write docstrings for all functions
- Use pytest for testing
"@ }
        "go" { @"
- Follow Go idioms and conventions
- Use error handling best practices
- Write table-driven tests
- Keep functions focused and small
"@ }
        "java" { @"
- Follow Java naming conventions
- Use meaningful variable names
- Prefer composition over inheritance
- Write JUnit tests
"@ }
        "csharp" { @"
- Follow C# coding conventions
- Use LINQ when appropriate
- Implement IDisposable for resources
- Write xUnit tests
"@ }
        "ruby" { @"
- Follow Ruby style guide
- Use meaningful method names
- Prefer blocks and iterators
- Write RSpec tests
"@ }
    }
    
    @"
# GitHub Copilot Instructions for $PROJECT_NAME

## Project Overview
$PROJECT_DESC

This project uses Claude AI for development assistance with the following setup:
- Language: $LANGUAGE
- AI Model: Claude 3.5 Sonnet
- Integration: MCP (Model Context Protocol)

## Coding Standards
- Follow the standards in ``specs/code-standards.md``
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
$languageNotes

## Project Structure
Follow the organization in the project root:
- ``.claude/`` - Claude-specific commands and configs
- ``ai_docs/`` - AI integration documentation
- ``specs/`` - Project specifications
- ``scripts/`` - Utility scripts

## Integration with Claude
This project is optimized for Claude AI development. Use the custom commands in ``.claude/commands/`` for common workflows.
"@ | Out-File -FilePath ".github/copilot/instructions.md" -Encoding utf8
    
    if ($CONFIG_COPILOT_WORKSPACE -eq "y") {
        New-Item -Path ".vscode" -ItemType Directory -Force | Out-Null
        @"
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
"@ | Out-File -FilePath ".vscode/settings.json" -Encoding utf8
    }
    
    Write-Host "    ✓ GitHub Copilot configuration created" -ForegroundColor Green
}

# Initialize git if requested
if (($INIT_GIT -eq "y") -and (-not (Test-Path ".git"))) {
    Write-Host "  → Initializing git repository..." -ForegroundColor Blue
    git init
    git add .
    git commit -m "Initial commit: AI Agent Template setup for $LANGUAGE"
    Write-Host "    ✓ Git repository initialized" -ForegroundColor Green
}

# Install dependencies if requested
if ($INSTALL_DEPS -eq "y") {
    Write-Host "  → Installing dependencies..." -ForegroundColor Blue
    
    switch ($LANGUAGE) {
        "javascript" {
            if (Get-Command npm -ErrorAction SilentlyContinue) {
                npm install
                Write-Host "    ✓ Node.js dependencies installed" -ForegroundColor Green
            }
            else {
                Write-Host "    ⚠  npm not found. Please install Node.js and run 'npm install'" -ForegroundColor Yellow
            }
        }
        "python" {
            if (Get-Command pip -ErrorAction SilentlyContinue) {
                pip install -r requirements.txt
                Write-Host "    ✓ Python dependencies installed" -ForegroundColor Green
            }
            else {
                Write-Host "    ⚠  pip not found. Please install Python and run 'pip install -r requirements.txt'" -ForegroundColor Yellow
            }
        }
        "go" {
            if (Get-Command go -ErrorAction SilentlyContinue) {
                go mod tidy
                Write-Host "    ✓ Go dependencies installed" -ForegroundColor Green
            }
            else {
                Write-Host "    ⚠  go not found. Please install Go and run 'go mod tidy'" -ForegroundColor Yellow
            }
        }
        "ruby" {
            if (Get-Command bundle -ErrorAction SilentlyContinue) {
                bundle install
                Write-Host "    ✓ Ruby dependencies installed" -ForegroundColor Green
            }
            else {
                Write-Host "    ⚠  bundler not found. Please install Ruby and run 'bundle install'" -ForegroundColor Yellow
            }
        }
    }
}

# Create example if requested
if ($CREATE_EXAMPLE -eq "y") {
    Write-Host "  → Creating example project..." -ForegroundColor Blue
    New-Item -Path "examples/$LANGUAGE-example" -ItemType Directory -Force | Out-Null
    Write-Host "    ✓ Example directory created at examples/$LANGUAGE-example/" -ForegroundColor Green
}

# Final success message
Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   Setup Complete! 🎉                       ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Your AI Agent Template is ready for $LANGUAGE development!" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Add your Anthropic API key to .env" -ForegroundColor White
if ($ENABLE_JIRA -eq "y") {
    Write-Host "  2. Configure JIRA credentials in .mcp.json" -ForegroundColor White
}
if ($ENABLE_CONFLUENCE -eq "y") {
    Write-Host "  3. Configure Confluence credentials in .mcp.json" -ForegroundColor White
}
Write-Host "  4. Review the custom commands in .claude/commands/" -ForegroundColor White
Write-Host "  5. Read CLAUDE.md for usage instructions" -ForegroundColor White
Write-Host "  6. Start building with: @engineer" -ForegroundColor White
Write-Host ""
Write-Host "Documentation:" -ForegroundColor Cyan
Write-Host "  - Getting Started: docs/getting-started.md" -ForegroundColor White
Write-Host "  - Best Practices: docs/best-practices.md" -ForegroundColor White
Write-Host "  - API Reference: ai_docs/tool-use.md" -ForegroundColor White
Write-Host "  - Worktree Management: scripts/worktree*.ps1" -ForegroundColor White
Write-Host ""
Write-Host "Happy coding with Claude AI! 🚀" -ForegroundColor Yellow
Write-Host ""
