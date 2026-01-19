Commit changes to AI tool configuration back to the dotfiles repo.

## Check for Changes

```bash
cd ~/dotfiles
echo "=== Changed files ==="
git status --porcelain ai-config/ claude/ cursor/ codex/
```

If no changes, report "No AI config changes to commit" and stop.

## Show Diff

```bash
git diff ai-config/ claude/ cursor/ codex/
```

## Get Commit Message

Ask user for a commit message. Suggest format:
- "ai-config: add new review-pr command"
- "ai-config: update coding standards"
- "claude: adjust permissions"

## Commit

```bash
cd ~/dotfiles
git add ai-config/ claude/ cursor/ codex/
git commit -m "[message]"
```

## Optionally Push

Ask if user wants to push to remote:

```bash
git push origin main
```

## Sync to Other Tools

If changes were in ai-config/, ask if user wants to sync to other tools:

```bash
~/dotfiles/scripts/sync-ai-config.sh
```
