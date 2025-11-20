# Anthropic Tool Use Guide

This guide covers how to use Claude's tool use (function calling) capabilities effectively.

## Overview

Tool use allows Claude to interact with external systems, APIs, and functions by generating structured requests that your application can execute.

## Basic Concept

```
User Request → Claude analyzes → Decides to use tool → 
Your app executes → Results back to Claude → Claude responds
```

## Defining Tools

### Tool Schema

```json
{
  "name": "get_weather",
  "description": "Get current weather for a location. Returns temperature, conditions, and forecast.",
  "input_schema": {
    "type": "object",
    "properties": {
      "location": {
        "type": "string",
        "description": "City name or coordinates (lat,long)"
      },
      "unit": {
        "type": "string",
        "enum": ["celsius", "fahrenheit"],
        "description": "Temperature unit"
      }
    },
    "required": ["location"]
  }
}
```

### JavaScript Example

```javascript
const tools = [
  {
    name: "get_weather",
    description: "Get current weather for a location",
    input_schema: {
      type: "object",
      properties: {
        location: {
          type: "string",
          description: "City name"
        },
        unit: {
          type: "string",
          enum: ["celsius", "fahrenheit"],
          description: "Temperature unit"
        }
      },
      required: ["location"]
    }
  }
];

const message = await anthropic.messages.create({
  model: "claude-3-5-sonnet-20241022",
  max_tokens: 1024,
  tools: tools,
  messages: [
    {
      role: "user",
      content: "What's the weather like in San Francisco?"
    }
  ]
});
```

### Python Example

```python
tools = [
    {
        "name": "get_weather",
        "description": "Get current weather for a location",
        "input_schema": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "City name"
                },
                "unit": {
                    "type": "string",
                    "enum": ["celsius", "fahrenheit"],
                    "description": "Temperature unit"
                }
            },
            "required": ["location"]
        }
    }
]

message = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=1024,
    tools=tools,
    messages=[
        {
            "role": "user",
            "content": "What's the weather like in San Francisco?"
        }
    ]
)
```

## Handling Tool Calls

### Response with Tool Use

```json
{
  "id": "msg_...",
  "type": "message",
  "role": "assistant",
  "content": [
    {
      "type": "tool_use",
      "id": "toolu_...",
      "name": "get_weather",
      "input": {
        "location": "San Francisco",
        "unit": "fahrenheit"
      }
    }
  ],
  "stop_reason": "tool_use"
}
```

### Executing the Tool

```javascript
// Extract tool use from response
const toolUse = message.content.find(block => block.type === "tool_use");

if (toolUse) {
  // Execute the tool
  const toolResult = await executeWeatherTool(toolUse.input);
  
  // Send result back to Claude
  const followUp = await anthropic.messages.create({
    model: "claude-3-5-sonnet-20241022",
    max_tokens: 1024,
    tools: tools,
    messages: [
      { role: "user", content: "What's the weather like in San Francisco?" },
      { role: "assistant", content: message.content },
      {
        role: "user",
        content: [
          {
            type: "tool_result",
            tool_use_id: toolUse.id,
            content: JSON.stringify(toolResult)
          }
        ]
      }
    ]
  });
}
```

### Tool Implementation

```javascript
async function executeWeatherTool(input) {
  const { location, unit = "fahrenheit" } = input;
  
  try {
    // Call weather API
    const response = await fetch(
      `https://api.weather.com/v1/current?location=${location}&unit=${unit}`
    );
    const data = await response.json();
    
    return {
      location: data.location,
      temperature: data.temperature,
      conditions: data.conditions,
      humidity: data.humidity,
      wind_speed: data.wind_speed
    };
  } catch (error) {
    return {
      error: `Failed to get weather: ${error.message}`
    };
  }
}
```

## Tool Use Patterns

### Sequential Tool Calls

Claude can call multiple tools in sequence:

```
1. User: "Book a flight to NYC and get weather"
2. Claude: calls search_flights tool
3. App: returns flight options
4. Claude: calls get_weather tool
5. App: returns weather data
6. Claude: presents combined results
```

### Parallel Tool Calls

Claude can request multiple tools simultaneously:

```json
{
  "content": [
    {
      "type": "tool_use",
      "id": "toolu_1",
      "name": "get_weather",
      "input": {"location": "NYC"}
    },
    {
      "type": "tool_use",
      "id": "toolu_2",
      "name": "get_weather",
      "input": {"location": "LA"}
    }
  ]
}
```

Handle parallel calls:

```javascript
const toolCalls = message.content.filter(block => block.type === "tool_use");

// Execute all tools in parallel
const results = await Promise.all(
  toolCalls.map(async (toolUse) => ({
    type: "tool_result",
    tool_use_id: toolUse.id,
    content: JSON.stringify(await executeTool(toolUse))
  }))
);

// Send all results back
const followUp = await anthropic.messages.create({
  model: "claude-3-5-sonnet-20241022",
  max_tokens: 1024,
  tools: tools,
  messages: [
    ...previousMessages,
    { role: "user", content: results }
  ]
});
```

### Conditional Tool Use

Tools can be optional based on context:

```javascript
const tools = [
  {
    name: "get_user_data",
    description: "Get user data. Only use if user mentions their account or profile."
  },
  {
    name: "search_products", 
    description: "Search products. Use when user asks about products or shopping."
  }
];
```

## Best Practices

### Clear Tool Descriptions

Good:
```json
{
  "name": "search_database",
  "description": "Search the product database. Returns up to 10 products matching the query. Use when user asks about products, availability, or pricing. Required fields: query (what to search for). Optional: category (filter by category), max_price (filter by price)."
}
```

Bad:
```json
{
  "name": "search_database",
  "description": "Searches stuff"
}
```

### Descriptive Parameter Names

Good:
```json
{
  "properties": {
    "start_date": {
      "type": "string",
      "description": "Start date in YYYY-MM-DD format"
    },
    "end_date": {
      "type": "string",
      "description": "End date in YYYY-MM-DD format, must be after start_date"
    }
  }
}
```

Bad:
```json
{
  "properties": {
    "d1": {
      "type": "string"
    },
    "d2": {
      "type": "string"
    }
  }
}
```

### Error Handling

```javascript
async function executeTool(toolUse) {
  try {
    const result = await actualToolFunction(toolUse.input);
    return {
      success: true,
      data: result
    };
  } catch (error) {
    return {
      success: false,
      error: error.message,
      error_type: error.name
    };
  }
}
```

### Validation

```javascript
function validateToolInput(toolName, input) {
  const schemas = {
    get_weather: {
      location: (v) => typeof v === 'string' && v.length > 0,
      unit: (v) => ['celsius', 'fahrenheit'].includes(v)
    }
  };
  
  const schema = schemas[toolName];
  if (!schema) return { valid: false, error: "Unknown tool" };
  
  for (const [key, validator] of Object.entries(schema)) {
    if (input[key] !== undefined && !validator(input[key])) {
      return { valid: false, error: `Invalid ${key}` };
    }
  }
  
  return { valid: true };
}
```

## Advanced Patterns

### Tool Chaining

```javascript
class ToolChain {
  async execute(userMessage) {
    let messages = [{ role: "user", content: userMessage }];
    let maxIterations = 5;
    
    while (maxIterations-- > 0) {
      const response = await anthropic.messages.create({
        model: "claude-3-5-sonnet-20241022",
        max_tokens: 1024,
        tools: this.tools,
        messages: messages
      });
      
      messages.push({ role: "assistant", content: response.content });
      
      if (response.stop_reason !== "tool_use") {
        return response;
      }
      
      const toolResults = await this.executeTools(response.content);
      messages.push({ role: "user", content: toolResults });
    }
    
    throw new Error("Max iterations reached");
  }
}
```

### Tool Result Formatting

```javascript
function formatToolResult(result) {
  if (result.error) {
    return `Error: ${result.error}`;
  }
  
  if (Array.isArray(result.data)) {
    return `Found ${result.data.length} results:\n${
      result.data.map((item, i) => `${i + 1}. ${item.name}`).join('\n')
    }`;
  }
  
  return JSON.stringify(result.data, null, 2);
}
```

### Caching Tool Definitions

```javascript
const message = await anthropic.messages.create({
  model: "claude-3-5-sonnet-20241022",
  max_tokens: 1024,
  tools: tools,
  system: [
    {
      type: "text",
      text: "You are a helpful assistant with access to various tools.",
      cache_control: { type: "ephemeral" }
    }
  ],
  messages: messages
});
```

## Common Tools

### Database Query
```javascript
{
  name: "query_database",
  description: "Query the database with SQL",
  input_schema: {
    type: "object",
    properties: {
      query: {
        type: "string",
        description: "SQL query to execute"
      },
      limit: {
        type: "number",
        description: "Max number of results"
      }
    },
    required: ["query"]
  }
}
```

### API Call
```javascript
{
  name: "call_api",
  description: "Make HTTP API request",
  input_schema: {
    type: "object",
    properties: {
      endpoint: {
        type: "string",
        description: "API endpoint URL"
      },
      method: {
        type: "string",
        enum: ["GET", "POST", "PUT", "DELETE"]
      },
      body: {
        type: "object",
        description: "Request body for POST/PUT"
      }
    },
    required: ["endpoint", "method"]
  }
}
```

### File Operations
```javascript
{
  name: "read_file",
  description: "Read contents of a file",
  input_schema: {
    type: "object",
    properties: {
      path: {
        type: "string",
        description: "File path to read"
      }
    },
    required: ["path"]
  }
}
```

## Debugging

### Log Tool Calls

```javascript
console.log("Tool called:", {
  name: toolUse.name,
  input: toolUse.input,
  id: toolUse.id
});

const result = await executeTool(toolUse);

console.log("Tool result:", {
  name: toolUse.name,
  success: result.success,
  duration: Date.now() - startTime
});
```

### Monitor Tool Usage

```javascript
const toolMetrics = {
  calls: {},
  errors: {},
  latency: {}
};

function trackToolCall(name, duration, success) {
  if (!toolMetrics.calls[name]) {
    toolMetrics.calls[name] = 0;
    toolMetrics.errors[name] = 0;
    toolMetrics.latency[name] = [];
  }
  
  toolMetrics.calls[name]++;
  if (!success) toolMetrics.errors[name]++;
  toolMetrics.latency[name].push(duration);
}
```

## Resources

- [Anthropic Tool Use Documentation](https://docs.anthropic.com/claude/docs/tool-use)
- [Tool Use Examples](https://github.com/anthropics/anthropic-cookbook)
- Tool definitions in `prompts/` directory

## See Also

- MCP integration guide
- JIRA and Confluence tool use
- Custom tool development guide
