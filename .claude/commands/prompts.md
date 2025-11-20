# Prompt Writer Assistant

This command helps you write effective prompts for Claude and other AI models.

## Purpose

The Prompt Writer assists in crafting high-quality prompts by:
- Analyzing prompt effectiveness
- Suggesting improvements
- Providing templates
- Testing prompt variations
- Optimizing for specific use cases

## Usage

```
@prompts <your-task-description>
```

### Examples

```
@prompts Help me write a prompt for code review
@prompts Improve this prompt: [paste your prompt]
@prompts Create a system prompt for a customer service bot
```

## Prompt Engineering Principles

### Clarity
- Be specific and explicit
- Avoid ambiguity
- Define success criteria
- Provide examples

### Structure
- Use clear sections
- Leverage XML tags
- Organize information hierarchically
- Separate instructions from data

### Context
- Provide relevant background
- Include constraints
- Specify output format
- Define tone and style

## Prompt Templates

### Code Generation
```xml
<task>
Generate a [language] [component-type] that [functionality]
</task>

<requirements>
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]
</requirements>

<constraints>
- [Constraint 1]
- [Constraint 2]
</constraints>

<examples>
[Provide 1-2 examples of desired output]
</examples>
```

### Code Review
```xml
<task>
Review the following code for [specific-concerns]
</task>

<code>
[Your code here]
</code>

<review-criteria>
- Code quality and readability
- Performance considerations
- Security vulnerabilities
- Best practices adherence
- [Additional criteria]
</review-criteria>

<output-format>
Provide:
1. Overall assessment
2. Specific issues found
3. Suggested improvements
4. Priority ranking
</output-format>
```

### Documentation
```xml
<task>
Write comprehensive documentation for [component/feature]
</task>

<context>
[Background information]
</context>

<audience>
[Target audience: beginners, advanced users, etc.]
</audience>

<structure>
Include:
- Overview
- Usage examples
- API reference
- Common pitfalls
- FAQs
</structure>
```

### Debugging
```xml
<task>
Help debug this [issue-description]
</task>

<error>
[Error message or unexpected behavior]
</error>

<code>
[Relevant code]
</code>

<context>
- Environment: [details]
- Steps to reproduce: [steps]
- Expected behavior: [description]
- Actual behavior: [description]
</context>

<investigation-approach>
1. Analyze error message
2. Check common causes
3. Suggest debugging steps
4. Provide solution
</investigation-approach>
```

## Advanced Techniques

### Multi-Shot Prompting
Provide multiple examples:
```
Example 1:
Input: [input1]
Output: [output1]

Example 2:
Input: [input2]
Output: [output2]

Now process:
Input: [actual-input]
```

### Chain of Thought
Ask for step-by-step reasoning:
```
Think through this step by step:
1. First, analyze [aspect 1]
2. Then, consider [aspect 2]
3. Finally, conclude [result]
```

### Role-Based Prompting
Set specific expertise:
```
You are an expert [role] with [years] of experience in [domain].
Your task is to [specific-task].
Apply your expertise in [specific-areas].
```

### Constrained Generation
Specify exact output format:
```
Generate [output] following these exact constraints:
- Format: [JSON/Markdown/etc]
- Length: [word count/character limit]
- Style: [formal/casual/technical]
- Structure: [specific-structure]
```

## Optimization Strategies

### Token Efficiency
- Remove redundancy
- Use concise language
- Leverage references
- Apply prompt caching

### Clarity Enhancement
- Break complex prompts into steps
- Use formatting (bold, lists, code blocks)
- Define technical terms
- Provide concrete examples

### Context Management
- Prioritize critical information
- Use XML tags for structure
- Separate instructions from data
- Reference external docs when needed

## Testing Prompts

### A/B Testing
```
@prompts --test
Prompt A: [version 1]
Prompt B: [version 2]
```

### Iteration
```
@prompts --iterate
Original: [prompt]
Feedback: [what didn't work]
Goal: [desired improvement]
```

### Validation
```
@prompts --validate
Prompt: [your prompt]
Test Cases: [expected behaviors]
```

## Common Patterns

### Information Extraction
```
Extract [specific-data] from the following [source-type]:

[Content]

Return as [format] with fields:
- [Field 1]
- [Field 2]
- [Field 3]
```

### Summarization
```
Summarize the following [content-type] in [length]:

[Content]

Focus on:
- [Key point 1]
- [Key point 2]

Target audience: [audience]
```

### Translation/Transformation
```
Transform the following [source-format] to [target-format]:

[Input]

Requirements:
- Preserve [what-to-preserve]
- Enhance [what-to-enhance]
- Follow [standard/convention]
```

## Anti-Patterns to Avoid

❌ **Vague Instructions**
```
Make this better
Fix this code
```

✅ **Specific Instructions**
```
Refactor this code to improve readability by:
- Extracting long functions
- Adding descriptive variable names
- Removing code duplication
```

❌ **Overloading**
```
Write code, test it, document it, deploy it, and monitor it
```

✅ **Focused Tasks**
```
First, write the core implementation.
Then I'll ask you to add tests.
```

❌ **Assuming Context**
```
Use the standard approach
```

✅ **Explicit Context**
```
Use React hooks following the patterns in our codebase:
- useState for local state
- useEffect for side effects
- Custom hooks for shared logic
```

## Prompt Library

Access pre-built prompts:
```
@prompts --library code-review
@prompts --library documentation
@prompts --library testing
@prompts --library refactoring
```

## Integration

### Save Prompts
```
@prompts --save my-prompt-name
```

### Load Prompts
```
@prompts --load my-prompt-name
```

### Share Prompts
```
@prompts --export my-prompt-name.md
```

## Best Practices

1. **Start Simple**: Begin with basic prompt, iterate
2. **Test Variations**: Try different phrasings
3. **Use Examples**: Show, don't just tell
4. **Be Specific**: Explicit > implicit
5. **Iterate**: Refine based on results
6. **Document**: Save successful prompts
7. **Share**: Build team prompt library

## Metrics

Evaluate prompt quality:
- Accuracy of responses
- Consistency across runs
- Token efficiency
- Time to satisfactory result
- Generalization to edge cases

## Resources

- [Anthropic Prompt Engineering Guide](https://docs.anthropic.com/claude/docs/prompt-engineering)
- Prompt library in `prompts/`
- Team prompt database
- Example gallery

## See Also

- `specs/code-standards.md` - For code prompt requirements
- `ai_docs/anthropic-tool-use.md` - For tool-use prompts
- `@prime` - For context optimization
