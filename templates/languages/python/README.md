# Python Template

This template provides a starting point for Python projects with Claude AI integration.

## Quick Start

```bash
pip install -r requirements.txt
python src/main.py
```

## Project Structure

```
.
├── src/
│   ├── main.py           # Main entry point
│   ├── claude/           # Claude AI integration
│   │   ├── __init__.py
│   │   ├── client.py     # Anthropic client setup
│   │   └── tools.py      # Custom tools
│   ├── services/         # Business logic
│   └── utils/            # Utility functions
├── tests/                # Test files
├── requirements.txt
├── pyproject.toml
└── .env
```

## Configuration Files

### requirements.txt
```
anthropic>=0.30.0
python-dotenv>=1.0.0
pytest>=8.0.0
black>=24.0.0
pylint>=3.0.0
mypy>=1.0.0
```

### pyproject.toml
```toml
[tool.black]
line-length = 88
target-version = ['py38', 'py39', 'py310', 'py311']

[tool.pylint]
max-line-length = 88
disable = [
    "C0111",  # missing-docstring
    "R0903",  # too-few-public-methods
]

[tool.mypy]
python_version = "3.8"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_classes = "Test*"
python_functions = "test_*"
addopts = "--cov=src --cov-report=html --cov-report=term"
```

## Example Code

### Basic Claude Integration

```python
# src/claude/client.py
import os
from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()

client = Anthropic(api_key=os.environ.get("ANTHROPIC_API_KEY"))

def chat(message: str, **kwargs) -> str:
    """
    Send a message to Claude and get a response.
    
    Args:
        message: The user message to send
        **kwargs: Additional parameters for the API call
        
    Returns:
        The assistant's response text
    """
    response = client.messages.create(
        model=kwargs.get("model", "claude-3-5-sonnet-20241022"),
        max_tokens=kwargs.get("max_tokens", 4096),
        messages=[{"role": "user", "content": message}]
    )
    
    return response.content[0].text
```

### Tool Use Example

```python
# src/claude/tools.py
from typing import Dict, Any, List
import json

tools: List[Dict[str, Any]] = [
    {
        "name": "get_weather",
        "description": "Get weather for a location",
        "input_schema": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "City name"
                }
            },
            "required": ["location"]
        }
    }
]

async def execute_tool(tool_name: str, tool_input: Dict[str, Any]) -> Dict[str, Any]:
    """Execute a tool by name with given input."""
    if tool_name == "get_weather":
        return await get_weather(tool_input["location"])
    else:
        raise ValueError(f"Unknown tool: {tool_name}")

async def get_weather(location: str) -> Dict[str, Any]:
    """Get weather for a location."""
    # Implement weather API call
    return {
        "location": location,
        "temperature": 72,
        "conditions": "sunny"
    }
```

### Main Application

```python
# src/main.py
import asyncio
from claude.client import client
from claude.tools import tools, execute_tool

async def main():
    """Main application entry point."""
    message = client.messages.create(
        model="claude-3-5-sonnet-20241022",
        max_tokens=1024,
        tools=tools,
        messages=[
            {"role": "user", "content": "What is the weather in San Francisco?"}
        ]
    )
    
    # Handle tool calls
    if message.stop_reason == "tool_use":
        tool_use = next(
            block for block in message.content 
            if block.type == "tool_use"
        )
        result = await execute_tool(tool_use.name, tool_use.input)
        print(result)

if __name__ == "__main__":
    asyncio.run(main())
```

## Testing

### Example Test

```python
# tests/test_claude.py
import pytest
from src.claude.client import chat

@pytest.mark.asyncio
async def test_chat():
    """Test basic chat functionality."""
    response = await chat("Hello!")
    assert response is not None
    assert isinstance(response, str)
    assert len(response) > 0

def test_chat_with_options():
    """Test chat with custom options."""
    response = chat("Hello!", max_tokens=100)
    assert response is not None
```

## Type Hints

```python
from typing import Optional, Dict, Any, List
from anthropic.types import Message

def chat(
    message: str,
    model: str = "claude-3-5-sonnet-20241022",
    max_tokens: int = 4096,
    temperature: float = 1.0,
) -> str:
    """
    Send a message to Claude.
    
    Args:
        message: User message
        model: Claude model to use
        max_tokens: Maximum tokens in response
        temperature: Sampling temperature
        
    Returns:
        Assistant response text
    """
    # Implementation
    pass
```

## Best Practices

1. **Type Hints**: Use type hints for all functions
2. **Docstrings**: Write docstrings for public APIs
3. **Error Handling**: Use try-except blocks
4. **Async/Await**: Use async for I/O operations
5. **Testing**: Write pytest tests
6. **Formatting**: Use black for formatting
7. **Linting**: Use pylint and mypy

## Virtual Environment

```bash
# Create virtual environment
python -m venv venv

# Activate (Linux/Mac)
source venv/bin/activate

# Activate (Windows)
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Resources

- [Python Docs](https://docs.python.org/)
- [Anthropic Python SDK](https://github.com/anthropics/anthropic-sdk-python)
- [pytest](https://pytest.org/)
- [black](https://black.readthedocs.io/)
