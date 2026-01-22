Enter code review mode. Load and follow the code-reviewer agent guidelines for this session.

## Load Agent Guidelines

Read the code-reviewer agent definition:

```bash
cat ~/.claude/agents/code-reviewer.md
```

## Apply Guidelines

For the remainder of this session, follow those guidelines when reviewing code:

1. **Philosophy**: Assume competence, read PR descriptions first, fewer high-quality comments over nitpicks
2. **Must Check**: Security, correctness, breaking changes, error handling
3. **Should Check**: Performance issues, test coverage, public API docs
4. **Must Ignore**: Code style (linters handle it), import ordering, naming preferences
5. **Comment Style**: Be specific, constructive, respectful, indicate severity

Confirm you've loaded the guidelines and are ready to review code.
