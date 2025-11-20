# JIRA and Confluence Tool Use with MCP

This guide covers integration with JIRA and Confluence using the Model Context Protocol (MCP).

## Overview

MCP (Model Context Protocol) allows Claude to interact with JIRA and Confluence directly, enabling:
- Reading and creating JIRA tickets
- Querying project status
- Accessing Confluence documentation
- Updating workflows
- Managing sprints

## Setup

### Install MCP Server

```bash
npm install @modelcontextprotocol/server-jira
```

### Configure MCP

Create `.mcp.json` in project root:

```json
{
  "mcpServers": {
    "jira": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-jira"
      ],
      "env": {
        "JIRA_URL": "https://your-domain.atlassian.net",
        "JIRA_EMAIL": "your-email@example.com",
        "JIRA_API_TOKEN": "your-api-token"
      }
    },
    "confluence": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-confluence"
      ],
      "env": {
        "CONFLUENCE_URL": "https://your-domain.atlassian.net/wiki",
        "CONFLUENCE_EMAIL": "your-email@example.com",
        "CONFLUENCE_API_TOKEN": "your-api-token"
      }
    }
  }
}
```

### Get API Token

1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Create API token
3. Copy token to `.mcp.json`

## JIRA Integration

### Query Tickets

```
@engineer PROJ-123
```

Claude will:
1. Fetch ticket details from JIRA
2. Load requirements and acceptance criteria
3. Check linked tickets and dependencies
4. Start implementation

### Create Tickets

```
Create a JIRA ticket for implementing user authentication
```

Claude can create tickets with:
- Title and description
- Story points
- Priority
- Labels
- Assignee

### Update Status

```
Move PROJ-123 to In Progress
```

Claude updates ticket status in JIRA automatically.

### Add Comments

```
Add comment to PROJ-123: Implementation complete, ready for review
```

### Sprint Management

```
List all tickets in current sprint
```

```
Add PROJ-125 to current sprint
```

## Confluence Integration

### Read Documentation

```
Show me the API documentation from Confluence
```

Claude can access and reference Confluence pages.

### Create Documentation

```
Create a Confluence page documenting the new authentication flow
```

### Update Pages

```
Update the deployment guide in Confluence with the new process
```

### Search Content

```
Search Confluence for database migration guides
```

## Usage Patterns

### Sprint Planning

```
@tech-manager --plan-sprint

# Claude will:
# 1. Fetch backlog from JIRA
# 2. Analyze team capacity
# 3. Suggest sprint composition
# 4. Create sprint plan
# 5. Update JIRA sprint
```

### Ticket Workflow

```
@engineer PROJ-123

# Claude will:
# 1. Load ticket from JIRA
# 2. Check linked documentation in Confluence
# 3. Implement feature
# 4. Update ticket status
# 5. Add comments with progress
```

### Documentation Updates

```
After implementing feature, update documentation

# Claude will:
# 1. Find related Confluence pages
# 2. Update with new information
# 3. Add examples and screenshots
# 4. Link to JIRA ticket
```

## Advanced Features

### JQL Queries

```
Find all high priority bugs assigned to me

# Claude executes JQL:
# project = PROJ AND 
# type = Bug AND 
# priority = High AND 
# assignee = currentUser()
```

### Bulk Operations

```
Update all tickets in epic EPIC-10 to include testing checklist
```

### Cross-Reference

```
Link all related Confluence pages to PROJ-123
```

## Configuration in specs/

### Project Management Integration

See `specs/project-management.md` for:
- JIRA workflow configuration
- Custom fields setup
- Automation rules
- Integration patterns

### Project Plan

See `specs/project_plan.md` for:
- Epic and story structure
- Sprint planning guidelines
- Ticket linking conventions
- Documentation standards

## Security

### API Token Storage

- Store in `.mcp.json` (gitignored)
- Use environment variables in production
- Rotate tokens regularly
- Limit token permissions

### Access Control

- Configure JIRA permissions appropriately
- Limit API access to required projects
- Monitor API usage
- Audit access logs

## Best Practices

1. **Structure Tickets**: Use clear titles and descriptions
2. **Link Tickets**: Connect related work
3. **Update Status**: Keep status current
4. **Document**: Link to Confluence docs
5. **Use Labels**: Tag appropriately
6. **Estimate**: Add story points
7. **Comment**: Provide updates

## Troubleshooting

### Connection Issues

```
Error: Cannot connect to JIRA

Check:
- API token is valid
- URL is correct
- Network connectivity
- Token permissions
```

### Permission Errors

```
Error: Insufficient permissions

Solution:
- Check JIRA user permissions
- Verify API token scope
- Contact JIRA administrator
```

## Resources

- [MCP Documentation](https://modelcontextprotocol.io/)
- [JIRA API Reference](https://developer.atlassian.com/cloud/jira/platform/rest/v3/)
- [Confluence API Reference](https://developer.atlassian.com/cloud/confluence/rest/v1/)

## See Also

- `specs/project-management.md` - Project management system
- `specs/project_plan.md` - Project plan with JIRA references
- `.mcp.json` - MCP configuration
