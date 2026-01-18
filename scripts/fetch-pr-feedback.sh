#!/usr/bin/env bash
set -euo pipefail

PR_NUMBER="${1:?Usage: fetch-pr-feedback.sh <pr-number>}"

echo "# PR #$PR_NUMBER Review Feedback"
echo ""

echo "## Comments"
gh pr view "$PR_NUMBER" --json comments --jq '.comments[] | "### \(.author.login) (\(.createdAt | split("T")[0]))\n\(.body)\n---\n"' 2>/dev/null || echo "_No comments_"

echo ""
echo "## Reviews"
gh api "repos/:owner/:repo/pulls/$PR_NUMBER/reviews" --jq '.[] | select(.body != "") | "### \(.user.login) - \(.state)\n\(.body)\n---\n"' 2>/dev/null || echo "_No reviews with comments_"

echo ""
echo "## Inline Comments"
gh api "repos/:owner/:repo/pulls/$PR_NUMBER/comments" --jq '.[] | "### \(.user.login) on `\(.path):\(.line // .original_line)`\n\(.body)\n---\n"' 2>/dev/null || echo "_No inline comments_"
