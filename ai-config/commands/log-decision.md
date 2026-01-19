Record an architectural or technical decision in the project's CLAUDE.md.

## Gather Information

I need the following. Ask if not provided:

1. **Title**: Short description (e.g., "Use PostgreSQL advisory locks for distributed locking")
2. **Context**: What problem were we solving?
3. **Decision**: What did we decide?
4. **Rationale**: Why this approach?
5. **Alternatives Rejected**: What else was considered and why not?

## Locate or Create CLAUDE.md

Check if CLAUDE.md exists in project root. If not, create it with basic structure:

```markdown
# Project Guidelines

## Decisions Log
<!-- Newest first. Keep last 15 entries. -->
```

## Add Entry

Prepend to the `## Decisions Log` section:

```markdown
### YYYY-MM-DD: [Title]
- **Context**: [Problem being solved]
- **Decision**: [What was decided]
- **Rationale**: [Why this over alternatives]
- **Rejected alternatives**: [What else was considered]
```

Use today's date. Keep only the 15 most recent entries (remove oldest if needed).

## Commit

```bash
git add CLAUDE.md
git commit -m "docs: record decision - [short title]"
```
