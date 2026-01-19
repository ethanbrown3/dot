# AI Coding Tools Guide

A practical guide to getting the most out of your AI coding assistants (Claude Code, Cursor, Codex).

---

## Quick Reference

| Command | What it does |
|---------|--------------|
| `/impl-summary` | Wrap up changes, generate summary, create draft PR |
| `/review-pr 123` | Review a PR with focused criteria |
| `/address-feedback 123` | Fetch and address PR review comments |
| `/log-decision` | Record an architectural decision |
| `/sync-config` | Commit AI config changes back to dotfiles |

| Alias | What it does |
|-------|--------------|
| `cc` | Launch Claude Code |
| `ccr` | Resume last Claude Code session |
| `ai-status` | Show changed AI config files |
| `ai-diff` | Show AI config diffs |
| `ai-commit` | Commit AI config changes |
| `ai-sync` | Sync shared config to all tools |

---

## Workflow: Making Changes

### 1. Start Work

```bash
# Create a branch (Linear ticket format auto-detected)
git checkout -b ABC-123-add-feature

# Or for personal projects
git checkout -b add-feature

# Start Claude Code
cc
# Or resume previous session
ccr
```

### 2. During Development

Just code normally. Claude Code will:
- Follow the coding standards automatically
- Reference ticket IDs when it sees Linear-style branch names
- Detect OpenSpec projects and adjust accordingly

**Phantom org repos**: Claude will remind you about GPG signing. When you see a commit happening, be ready to touch your YubiKey.

### 3. Wrap Up Changes

When you're ready to create a PR:

```
/impl-summary
```

This will:
1. Check if you're in a Phantom org repo (GPG signing, draft PR)
2. Detect your project context (Linear/OpenSpec)
3. Gather all commits and changes
4. Generate an implementation summary
5. Commit any remaining changes
6. Push and create a draft PR (or regular PR for non-Phantom repos)

---

## Workflow: Reviewing PRs

### Review Someone Else's PR

```
/review-pr 123
```

This will:
1. Fetch PR info and diff
2. Check for project-specific guidelines (CLAUDE.md, .cursor/rules)
3. Read the implementation summary
4. Provide a focused review with:
   - Blocking issues (security, correctness, breaking changes)
   - Suggestions (non-blocking improvements)
   - Questions (clarifications needed)

### Address Feedback on Your PR

```
/address-feedback 123
```

This will:
1. Fetch all comments, reviews, and inline feedback
2. Categorize each piece of feedback
3. Implement fixes for valid items
4. Run tests/linters
5. Commit with a summary of what was addressed
6. Push the changes

---

## Phantom Org Specifics

When working in `phantom/*` repos, these rules apply automatically:

### GPG Signing Required
- All commits must be signed
- You'll need to touch your YubiKey for each commit
- Claude will remind you before commits happen

### Draft PRs Only
- PRs are always created as drafts
- Mark as "Ready for Review" manually when appropriate

### How Claude Detects This

```bash
# Claude runs this to check
gh repo view --json owner -q '.owner.login'
# If result is "phantom", special rules apply
```

---

## Context Detection

Commands automatically detect your project management context:

### Linear (Work)
Detected when:
- Branch name matches `ABC-123` pattern (e.g., `ENG-456-add-feature`)
- `.linear/` directory exists

Effect:
- Ticket IDs are extracted and linked
- Linear URL format used in PR descriptions

### OpenSpec (Personal)
Detected when:
- `.openspec/` directory exists
- `openspec.yaml` or `openspec.json` exists

Effect:
- OpenSpec references used instead of Linear tickets

### Manual Override

Set in `~/.claude/settings.local.json`:
```json
{
  "env": {
    "CLAUDE_WORK_CONTEXT": "linear"
  }
}
```

Or export in your shell:
```bash
export CLAUDE_WORK_CONTEXT=openspec
```

---

## Recording Decisions

When you make an architectural or technical decision worth documenting:

```
/log-decision
```

Claude will ask for:
1. **Title**: Short description
2. **Context**: What problem were you solving?
3. **Decision**: What did you decide?
4. **Rationale**: Why this approach?
5. **Alternatives Rejected**: What else was considered?

This gets added to `CLAUDE.md` in the project root (created if needed).

---

## Customizing Commands

### Edit Existing Commands

Commands are symlinked to your dotfiles, so edits flow back:

```bash
# Edit directly
vim ~/.claude/commands/impl-summary.md

# See what changed
ai-status

# Commit
ai-commit
```

Or use Claude:
```
/sync-config
```

### Add New Commands

1. Create the file:
   ```bash
   vim ~/dotfiles/ai-config/commands/my-command.md
   ```

2. Sync (or restart Claude Code):
   ```bash
   ai-sync
   ```

3. Use it:
   ```
   /my-command
   ```

### Command File Format

Commands are markdown files. Claude reads them as instructions.

```markdown
Brief description of what this command does.

## Step 1: Do Something

Explanation of the step.

\`\`\`bash
# Commands Claude should run
git status
\`\`\`

## Step 2: Generate Output

Tell Claude what format to use for output.
```

---

## Multi-Tool Setup

Your config works across multiple AI tools:

| Tool | Config Location | How It Works |
|------|-----------------|--------------|
| Claude Code | `~/.claude/` | Symlinks to dotfiles, live editing |
| Cursor | `~/.cursorrules` | Generated from `ai-config/rules/` |
| Codex | `~/dotfiles/codex/AGENTS.md` | Generated from `ai-config/` |

### Sync After Editing Shared Config

If you edit files in `ai-config/rules/` or `ai-config/agents/`:

```bash
ai-sync
```

This regenerates Cursor and Codex configs. Claude Code uses symlinks, so no sync needed for commands.

---

## Permissions

Claude Code has pre-approved permissions for common dev tools in `~/.claude/settings.json`:

- **Git**: `git:*`, `gh:*`
- **Node**: `npm:*`, `npx:*`, `pnpm:*`, `yarn:*`, `node:*`
- **Python**: `python:*`, `pip:*`, `uv:*`
- **Infra**: `terraform:*`, `aws:*`, `docker:*`
- **Utils**: `cat`, `ls`, `find`, `grep`, `jq`, etc.

Add custom permissions to `~/.claude/settings.local.json` (gitignored).

---

## Machine-Specific Config

For settings that shouldn't be committed (API keys, local paths):

`~/.claude/settings.local.json`:
```json
{
  "env": {
    "CLAUDE_WORK_CONTEXT": "linear",
    "MY_API_KEY": "secret"
  },
  "mcpServers": {
    "my-local-server": {
      "command": "/path/to/server"
    }
  }
}
```

This file is gitignored.

---

## Tips for Best Results

### Be Specific
Instead of "fix the bug", say "fix the null pointer exception in UserService.getUser when the user ID is not found"

### Provide Context
- Mention the ticket ID if relevant
- Reference specific files or functions
- Explain the "why" behind your request

### Let Claude Read First
Before asking for changes, let Claude read the relevant files. It makes better decisions with context.

### Use Resume
If you need to continue work later:
```bash
ccr  # Resume last session with full context
```

### Check the Rules
If Claude is doing something unexpected, check:
- `~/dotfiles/ai-config/rules/coding-standards.md`
- Project-specific `CLAUDE.md`

---

## Troubleshooting

### Commands Not Showing Up
```bash
# Restart Claude Code, or:
ai-sync
```

### GPG Signing Failing
- Make sure your YubiKey is plugged in
- Check `gpg --card-status`
- Verify `git config commit.gpgsign` is `true` for Phantom repos

### Wrong Context Detected
Set explicitly:
```bash
export CLAUDE_WORK_CONTEXT=linear  # or openspec
```

### Changes Not Flowing to Dotfiles
Check symlinks are correct:
```bash
ls -la ~/.claude/commands
# Should show -> /path/to/dotfiles/ai-config/commands
```

---

## File Locations

```
~/dotfiles/
├── ai-config/                    # Shared source (edit here)
│   ├── commands/                 # Slash commands
│   ├── agents/                   # Agent definitions
│   ├── rules/                    # Coding standards
│   └── prompts/                  # Reusable prompts
├── claude/.claude/               # Claude Code (stowed)
│   ├── settings.json             # Permissions
│   ├── commands -> ai-config     # Symlink
│   └── agents -> ai-config       # Symlink
├── cursor/.cursorrules           # Generated
└── codex/AGENTS.md               # Generated

~/.claude/                        # Active config (symlinked)
├── settings.json                 # From dotfiles
├── settings.local.json           # Machine-specific (gitignored)
├── commands/                     # Symlink to ai-config
└── agents/                       # Symlink to ai-config
```
