Generate an implementation summary for the current changes to include in a PR description.

## Detect Context

First, determine the project management context:

1. Check for OpenSpec:
   ```bash
   if [ -d ".openspec" ] || [ -f "openspec.yaml" ] || [ -f "openspec.json" ]; then
       echo "CONTEXT: openspec"
   fi
   ```

2. Check for Linear (branch naming or config):
   ```bash
   BRANCH=$(git branch --show-current 2>/dev/null)
   if [[ "$BRANCH" =~ [A-Z]+-[0-9]+ ]] || [ -d ".linear" ]; then
       echo "CONTEXT: linear"
   fi
   ```

3. Check environment override: `$CLAUDE_WORK_CONTEXT`

## Implementation Summary

**Ticket:** [Linear ticket ID with link, OR OpenSpec reference, OR "N/A"]

**Key Decisions:**
- [Decision]: [Why this approach over alternatives]

**Intentional Omissions:**
- [What's not included and why]

**Known Tradeoffs:**
- [Compromises made, technical debt accepted]

**Review Focus Areas:**
- [Where reviewer attention is needed]

Keep it concise. Focus on "why" not "what" - the diff shows what changed.
