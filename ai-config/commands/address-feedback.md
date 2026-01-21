Fetch and address review feedback for PR #$ARGUMENTS.

## Fetch Feedback

```bash
PR=$ARGUMENTS

echo "=== PR Comments ==="
gh pr view $PR --json comments --jq '.comments[] | "[\(.author.login)] \(.body)\n---"'

echo ""
echo "=== Review Comments ==="
gh api repos/:owner/:repo/pulls/$PR/reviews \
  --jq '.[] | select(.state != "APPROVED") | "[\(.user.login) - \(.state)]\n\(.body)\n---"'

echo ""
echo "=== Inline Comments ==="
gh api repos/:owner/:repo/pulls/$PR/comments \
  --jq '.[] | "[\(.user.login)] \(.path):\(.line // .original_line)\n\(.body)\n---"'
```

## Process Each Item

For each piece of feedback:
1. **Valid & Clear** → Implement the fix
2. **Valid but Unclear** → Note what clarification is needed
3. **Disagree** → Note reasoning (will discuss with reviewer)
4. **Already Addressed** → Note if fixed in another commit

## Implement Fixes

1. Make the necessary code changes

2. Detect and run tests:
   ```bash
   # Auto-detect test runner
   if [ -f "package.json" ]; then
       # Node.js project - check for test script
       if grep -q '"test"' package.json; then
           npm test
       fi
   elif [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "pytest.ini" ]; then
       # Python project
       if command -v pytest &> /dev/null; then
           pytest
       elif command -v python &> /dev/null; then
           python -m pytest
       fi
   elif [ -f "Cargo.toml" ]; then
       # Rust project
       cargo test
   elif [ -f "go.mod" ]; then
       # Go project
       go test ./...
   fi
   ```

3. Run linter if available:
   ```bash
   # Auto-detect linter
   if [ -f "package.json" ]; then
       if grep -q '"lint"' package.json; then
           npm run lint
       fi
   elif [ -f "pyproject.toml" ]; then
       if command -v ruff &> /dev/null; then
           ruff check .
       elif command -v flake8 &> /dev/null; then
           flake8
       fi
   fi
   ```

## Commit

```bash
git add -A
git commit -m "address review feedback

Addressed:
- [list items fixed]

Needs discussion:
- [list items needing clarification]

Declined:
- [list items with reasoning]"
```

## Push

```bash
git push
```

## Output

Provide a summary suitable for posting as a PR comment:
- What was addressed
- What needs clarification
- What you'd like to discuss
