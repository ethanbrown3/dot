# Review Criteria Reference

## Blocking Issues (must fix)
- SQL injection, XSS, command injection
- Authentication/authorization bypass
- Secrets or credentials in code
- Data exposure or privacy violations
- Logic errors that cause incorrect behavior
- Unhandled null/undefined that will crash
- Breaking API contract changes
- Database migrations that lose data

## Suggestions (non-blocking)
- N+1 query patterns
- Unbounded loops or recursion
- Missing test coverage for new paths
- Undocumented public API changes
- Error messages that leak internal details

## Ignore (handled elsewhere)
- Formatting (prettier/black handle this)
- Import order (linters handle this)
- Variable naming style preferences
- "Clever" vs "readable" style debates
