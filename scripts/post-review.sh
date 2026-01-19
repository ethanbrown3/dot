#!/usr/bin/env bash
set -euo pipefail

PR_NUMBER="${1:?Usage: post-review.sh <pr-number> <review-file>}"
REVIEW_FILE="${2:?Usage: post-review.sh <pr-number> <review-file>}"

if [ ! -f "$REVIEW_FILE" ]; then
    echo "Error: Review file not found: $REVIEW_FILE"
    exit 1
fi

echo "📝 Posting review to PR #$PR_NUMBER..."
gh pr review "$PR_NUMBER" --comment --body-file "$REVIEW_FILE"
echo "✅ Review posted!"
