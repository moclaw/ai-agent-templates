# Infinite Mode Command

This command enables continuous autonomous operation mode for Claude.

## Purpose

Infinite mode allows Claude to work autonomously on complex, multi-step tasks without constant user intervention. Perfect for:
- Long-running refactoring tasks
- Batch processing operations
- Multi-file code generation
- Comprehensive testing cycles

## Usage

```
@infinite <task-description>
```

## Example

```
@infinite Refactor the entire authentication system to use JWT tokens instead of sessions, update all related tests, and document the changes
```

## How It Works

1. **Task Analysis**: Claude breaks down the task into manageable subtasks
2. **Execution Plan**: Creates a detailed execution plan with checkpoints
3. **Autonomous Execution**: Executes each step with validation
4. **Progress Tracking**: Reports progress at each checkpoint
5. **Error Recovery**: Automatically handles errors and retries when possible
6. **Completion Report**: Provides comprehensive summary when done

## Configuration

Edit in `.claude/settings.json`:

```json
{
  "infinite_mode": {
    "enabled": true,
    "max_iterations": 100,
    "checkpoint_frequency": 10,
    "auto_commit": false,
    "require_confirmation": true
  }
}
```

## Safety Features

- **Iteration Limit**: Prevents infinite loops (default: 100)
- **Checkpoints**: Regular progress saves
- **Confirmation Gates**: Optional user approval at key points
- **Rollback Support**: Can revert to previous checkpoint

## Best Practices

1. **Clear Objectives**: Provide specific, measurable goals
2. **Scope Definition**: Define what's in/out of scope
3. **Success Criteria**: Specify how to validate completion
4. **Break Points**: Identify logical stopping points

## Example Tasks

### Large-Scale Refactoring
```
@infinite Migrate all class components to functional components with hooks, preserving all functionality and tests
```

### Documentation Generation
```
@infinite Generate comprehensive JSDoc comments for all functions in src/ directory, including examples and type definitions
```

### Test Coverage
```
@infinite Achieve 90% test coverage for the services/ directory by writing unit tests for all uncovered functions
```

## Monitoring

Watch for progress updates:
- ✅ Checkpoint reached
- 🔄 Task in progress
- ⚠️ Warning/issue detected
- ✓ Task completed
- ❌ Error encountered

## Stopping Infinite Mode

- Use `@stop` command to halt gracefully
- Ctrl+C for emergency stop
- Automatically stops at iteration limit

## Troubleshooting

### Mode Won't Start
- Check `infinite_mode.enabled` in settings
- Verify API rate limits
- Ensure clear task description

### Stuck in Loop
- Review iteration count
- Check for blocking errors
- Reduce scope of task

### Unexpected Results
- Review checkpoint logs
- Validate intermediate outputs
- Adjust success criteria
