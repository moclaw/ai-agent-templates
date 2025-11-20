# JavaScript/TypeScript Template

This template provides a starting point for JavaScript/TypeScript projects with Claude AI integration.

## Quick Start

```bash
npm install
npm run dev
```

## Project Structure

```
.
├── src/
│   ├── index.js          # Main entry point
│   ├── claude/           # Claude AI integration
│   │   ├── client.js     # Anthropic client setup
│   │   └── tools.js      # Custom tools
│   ├── services/         # Business logic
│   └── utils/            # Utility functions
├── tests/                # Test files
├── package.json
├── .eslintrc.json
└── .env
```

## Configuration Files

### package.json
```json
{
  "name": "claude-ai-project",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "node src/index.js",
    "test": "jest",
    "lint": "eslint src/",
    "format": "prettier --write src/"
  },
  "dependencies": {
    "@anthropic-ai/sdk": "^0.30.0",
    "dotenv": "^16.0.0"
  },
  "devDependencies": {
    "eslint": "^8.0.0",
    "prettier": "^3.0.0",
    "jest": "^29.0.0"
  }
}
```

### .eslintrc.json
```json
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
```

## Example Code

### Basic Claude Integration

```javascript
// src/claude/client.js
import Anthropic from '@anthropic-ai/sdk';
import dotenv from 'dotenv';

dotenv.config();

export const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY,
});

export async function chat(message, options = {}) {
  const response = await anthropic.messages.create({
    model: process.env.CLAUDE_MODEL || 'claude-3-5-sonnet-20241022',
    max_tokens: parseInt(process.env.MAX_TOKENS) || 4096,
    messages: [{ role: 'user', content: message }],
    ...options,
  });

  return response.content[0].text;
}
```

### Tool Use Example

```javascript
// src/claude/tools.js
export const tools = [
  {
    name: 'get_weather',
    description: 'Get weather for a location',
    input_schema: {
      type: 'object',
      properties: {
        location: {
          type: 'string',
          description: 'City name',
        },
      },
      required: ['location'],
    },
  },
];

export async function executeTool(toolName, input) {
  switch (toolName) {
    case 'get_weather':
      return await getWeather(input.location);
    default:
      throw new Error(`Unknown tool: ${toolName}`);
  }
}

async function getWeather(location) {
  // Implement weather API call
  return { location, temperature: 72, conditions: 'sunny' };
}
```

### Main Application

```javascript
// src/index.js
import { anthropic } from './claude/client.js';
import { tools, executeToken } from './claude/tools.js';

async function main() {
  const message = await anthropic.messages.create({
    model: 'claude-3-5-sonnet-20241022',
    max_tokens: 1024,
    tools: tools,
    messages: [
      { role: 'user', content: 'What is the weather in San Francisco?' },
    ],
  });

  // Handle tool calls
  if (message.stop_reason === 'tool_use') {
    const toolUse = message.content.find((block) => block.type === 'tool_use');
    const result = await executeToolcall(toolUse.name, toolUse.input);
    console.log(result);
  }
}

main();
```

## Testing

### Jest Configuration

```javascript
// jest.config.js
export default {
  testEnvironment: 'node',
  transform: {},
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
    },
  },
};
```

### Example Test

```javascript
// tests/claude.test.js
import { chat } from '../src/claude/client.js';

describe('Claude Integration', () => {
  it('should return a response', async () => {
    const response = await chat('Hello!');
    expect(response).toBeDefined();
    expect(typeof response).toBe('string');
  });
});
```

## TypeScript Setup

### Install TypeScript

```bash
npm install -D typescript @types/node
```

### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2021",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### TypeScript Example

```typescript
// src/claude/client.ts
import Anthropic from '@anthropic-ai/sdk';

interface ChatOptions {
  model?: string;
  max_tokens?: number;
  temperature?: number;
}

export async function chat(
  message: string,
  options: ChatOptions = {}
): Promise<string> {
  const anthropic = new Anthropic({
    apiKey: process.env.ANTHROPIC_API_KEY!,
  });

  const response = await anthropic.messages.create({
    model: options.model || 'claude-3-5-sonnet-20241022',
    max_tokens: options.max_tokens || 4096,
    temperature: options.temperature || 1.0,
    messages: [{ role: 'user', content: message }],
  });

  return response.content[0].text;
}
```

## Best Practices

1. **Environment Variables**: Use `.env` for configuration
2. **Error Handling**: Wrap API calls in try-catch
3. **Rate Limiting**: Implement request throttling
4. **Logging**: Use structured logging
5. **Testing**: Write tests for all functions
6. **Types**: Use TypeScript or JSDoc for type safety

## Resources

- [Node.js Docs](https://nodejs.org/docs/)
- [Anthropic SDK](https://github.com/anthropics/anthropic-sdk-typescript)
- [ESLint](https://eslint.org/)
- [Jest](https://jestjs.io/)
