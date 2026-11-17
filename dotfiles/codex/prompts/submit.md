---
description: Submit code - prep a branch, commit, and open a draft PR
argument-hint: [TICKET="<id-or-url>"]
---

Create a branch named `md/<feature_name>` for the currently unstaged changes, if $TICKET is provided use the ticket number (e.g. `IDT-1234`) as the branch name instead.
Stage the unstaged files under the current directory or that have been modified during the conversation.
Commit the staged changes with a clear and concise message. Use semantic commits conventions. Use imperative form.
If $TICKET was provided, add `Ref: $TICKET` footer to the commit.
Open a draft PR on the same branch and fill it with the first commit message. Use: `gh pr create --fill-first --draft`
