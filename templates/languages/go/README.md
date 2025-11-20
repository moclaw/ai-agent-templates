# Go Template

This template provides a starting point for Go projects with Claude AI integration.

## Quick Start

```bash
go mod tidy
go run main.go
```

## Project Structure

```
.
├── cmd/
│   └── main.go          # Main entry point
├── internal/
│   ├── claude/          # Claude AI integration
│   │   ├── client.go    # Anthropic client
│   │   └── tools.go     # Custom tools
│   ├── services/        # Business logic
│   └── utils/           # Utilities
├── go.mod
├── go.sum
└── .env
```

## Example Code

### Basic Claude Integration

```go
// internal/claude/client.go
package claude

import (
    "context"
    "os"
    
    anthropic "github.com/anthropics/anthropic-sdk-go"
)

type Client struct {
    client *anthropic.Client
}

func NewClient() *Client {
    apiKey := os.Getenv("ANTHROPIC_API_KEY")
    client := anthropic.NewClient(
        anthropic.WithAPIKey(apiKey),
    )
    
    return &Client{client: client}
}

func (c *Client) Chat(ctx context.Context, message string) (string, error) {
    response, err := c.client.Messages.Create(ctx, &anthropic.MessageCreateParams{
        Model:     anthropic.ModelClaude_3_5_Sonnet_20241022,
        MaxTokens: 4096,
        Messages: []anthropic.MessageParam{
            anthropic.NewUserMessage(anthropic.NewTextBlock(message)),
        },
    })
    
    if err != nil {
        return "", err
    }
    
    return response.Content[0].Text, nil
}
```

### Main Application

```go
// cmd/main.go
package main

import (
    "context"
    "fmt"
    "log"
    
    "your-module/internal/claude"
    "github.com/joho/godotenv"
)

func main() {
    // Load environment variables
    if err := godotenv.Load(); err != nil {
        log.Fatal("Error loading .env file")
    }
    
    // Create Claude client
    client := claude.NewClient()
    
    // Send message
    ctx := context.Background()
    response, err := client.Chat(ctx, "Hello, Claude!")
    if err != nil {
        log.Fatal(err)
    }
    
    fmt.Println(response)
}
```

## Best Practices

1. **Error Handling**: Always check errors
2. **Context**: Use context for cancellation
3. **Interfaces**: Design with interfaces
4. **Testing**: Write table-driven tests
5. **Modules**: Use Go modules

## Resources

- [Go Documentation](https://go.dev/doc/)
- [Effective Go](https://go.dev/doc/effective_go)
