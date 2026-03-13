Never add Co-authored-by trailers to git commits.

## Shell Commands

This system aliases `rm`, `cp`, and `mv` to require interactive confirmation (`-i` flag). When running these commands — especially in subagents — pass the `-f` flag to override the confirmation prompt, otherwise the command will hang waiting for input. For example: `rm -rf`, `cp -f`, `mv -f`. Only use `-f` when the action is necessary for the current task, the files are within a git repo, and they are tracked (i.e., recoverable via git).

## Code Quality

Never justify a bad pattern by pointing to existing bad code. If you encounter a broken window, fix it or propose it as tech debt — don't propagate it.

## Slack

I frequently need to post updates and announcements in slack. I'll ask for you to draft messages based on the context of the work. The style and audience will vary but I will always prefer it in slack compatible markup. 
- *bold* _italics_ 
- DO NOT USE HEADERS ie. `#` 
