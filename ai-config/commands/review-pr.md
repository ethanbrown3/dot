Review PR #$ARGUMENTS with focused criteria.

## Setup

1. Fetch PR info:
   ```bash
   gh pr view $ARGUMENTS --json title,body,headRefName,files,url
   ```

2. Fetch diff:
   ```bash
   gh pr diff $ARGUMENTS
   ```

3. Check for project guidelines:
   - Read CLAUDE.md if it exists
   - Read .cursor/rules if it exists

4. Read PR description for implementation context (especially the Implementation Summary section)

## PR Review: #[number] - [title]

### Summary
[1-2 sentence overall assessment]

### Blocking Issues
[If none: "No blocking issues found ✅"]

**[file:line]** - [issue]
> Recommendation: [specific fix]

### Suggestions
[If none: "No additional suggestions"]

**[file:line]** - [observation]
> Consider: [suggestion]

### Questions
[If context from implementation summary is unclear]

Be respectful. Assume the author is competent. Ask before assuming something is wrong.
