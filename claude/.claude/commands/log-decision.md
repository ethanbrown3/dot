Capture and format an architectural or technical decision.

## Gather Information

Ask for the following if not provided:

1. **Title**: Short description (e.g., "Use PostgreSQL advisory locks for distributed locking")
2. **Context**: What problem were we solving?
3. **Decision**: What did we decide?
4. **Rationale**: Why this approach?
5. **Alternatives Rejected**: What else was considered and why not?

## Format the Decision

Generate a formatted decision record:

```markdown
### YYYY-MM-DD: [Title]

**Context**: [Problem being solved]

**Decision**: [What was decided]

**Rationale**: [Why this over alternatives]

**Rejected alternatives**: [What else was considered]
```

Use today's date.

## Output

Present the formatted decision to the user and ask:

> Here's the formatted decision. Where would you like me to save it?
>
> Common locations:
> - `docs/decisions/` (ADR style)
> - `CLAUDE.md` or `DECISIONS.md` in project root
> - A specific doc you name
> - Or I can just output it here for you to paste elsewhere

Wait for the user to specify the location before writing anything.

If they specify a location:
1. Write/append to that file
2. Commit with message: `docs: record decision - [short title]`
