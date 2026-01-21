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
- **Phantom org repos require GPG-signed commits** - never commit unsigned to `phantom/*` repos (user will need to touch YubiKey)
  - Check with: `gh repo view --json owner -q '.owner.login'`
  - If owner is `phantom`, ensure commits are signed (git config commit.gpgsign should be true for these repos)
- **Phantom org repos: always create PRs as drafts** - use `gh pr create --draft` for `phantom/*` repos; other repos can use regular PRs

## Security
- Never commit secrets, API keys, or credentials
- Validate and sanitize all user input
- Use parameterized queries for database access
- Follow principle of least privilege

## Testing
- Write tests for new functionality
- Test edge cases and error conditions
- Keep tests focused and independent
