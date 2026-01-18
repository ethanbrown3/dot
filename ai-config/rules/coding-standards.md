# Coding Standards

These standards apply across all projects unless overridden by project-specific CLAUDE.md.

## General
- Write clear, self-documenting code
- Handle errors explicitly, don't swallow exceptions
- Prefer composition over inheritance
- Keep functions focused and small

## Git
- Write meaningful commit messages (imperative mood)
- Reference ticket IDs in commits when applicable
- Keep PRs focused on a single change

## Security
- Never commit secrets, API keys, or credentials
- Validate and sanitize all user input
- Use parameterized queries for database access
- Follow principle of least privilege

## Testing
- Write tests for new functionality
- Test edge cases and error conditions
- Keep tests focused and independent
