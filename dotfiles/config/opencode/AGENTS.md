## Using @ask Agent

When you need to quickly answer questions or find information:

- Use `@ask` to invoke the research agent
- It has access to `websearch` and `gh_grep` for finding answers
- It's read-only (no file edits or bash commands)

## Using @debug Agent

When troubleshooting an issue — invoke `@debug` instead of guessing.

- **Searches online first**: GitHub Issues, web search, documentation — before proposing any fix
- **Reads local state**: Can read config files and run diagnostic commands (`journalctl`, `systemctl status`, `hyprctl`, `pacman -Q`, etc.)
- **Read-only**: Cannot edit or create files — only reports findings with cited sources
- **Use when**: Something is broken, misbehaving, or you need to understand why a tool/config isn't working

## Using @scout Agent

When exploring ideas, evaluating libraries, or researching approaches — invoke `@scout`.

- **Searches broadly then deeply**: Finds latest libraries, compares options, checks real-world usage on GitHub
- **Opinionated**: Doesn't just list options — recommends one and explains why
- **Checks recency and health**: Flags stale repos, compares star counts, looks at recent activity
- **Read-only**: Cannot edit or create files — reports findings with links and recommendations
- **Use when**: "What's the best library for X?", "Is there a better way to do Y?", "What are people using for Z these days?"

## Using @designer Agent

When you need UI/UX guidance, layout decisions, or visual improvements — invoke `@designer`.

- **Reads existing styles**: Understands your current theme, colors, spacing before proposing changes
- **Delivers specifics**: Exact hex colors, pixel values, CSS/config snippets — not vague suggestions
- **Accessibility-aware**: Checks contrast ratios, flags WCAG issues
- **Read-only**: Cannot edit or create files — provides implementable code/config for you to apply
- **Use when**: "How should I style this panel?", "Redesign the login screen", "What colors work with Catppuccin Mocha?"

## Using @xposter Agent

When you want to post on X/Twitter — invoke `@xposter`.

- **Drafts first, posts after approval**: Shows you the tweet before posting — never auto-posts
- **Respects character limits**: Counts characters, proposes threads if needed
- **Posts via MCP**: Uses `agent-twitter-client-mcp` to post (requires auth cookies or API keys)
- **Use when**: "Tweet about this feature I just shipped", "Post a thread about my new setup"

## Hermes — Git Workflow Agent

**Purpose:** Specialized agent for complex git operations including atomic commits, rebase/squash workflows, history search (blame, bisect, log -S), and branch management.

**Skill:** `git-master` (built-in)

**Scope: CAN Do**
- Atomic commits with conventional commit style (references Commit Guidelines section)
- Rebase, squash, cherry-pick operations
- History search: `git log -S`, `git blame`, `git bisect`
- Branch strategy enforcement (no force push to main/master)
- Complex merge conflict resolution
- Tag management and version workflows

**Scope: CANNOT Do**
- Create pull requests (use `gh pr create` via bash tool or dedicated PR agent)
- Modify remote repository settings
- Manage repository permissions or access control
- Perform administrative tasks beyond commit/history operations

**Safety Guardrails**
- **Force push discipline:** ONLY use `--force-with-lease` (never bare `--force`); NEVER force push to main/master shared branches
- **No hard resets on shared history:** Prevent `git reset --hard` on commits already pushed
- **Never rebase published branches:** Require explicit confirmation before rebasing any branch that may be checked out elsewhere
- **Hook respect:** NEVER use `--no-verify` unless explicitly requested by user
- **Pre-operation checks:** Always run `git status` and `git log --oneline -n 5` before destructive operations
- **Push verification:** Check if commits are pushed before rebasing (warn user if unpushed changes exist on other branches)

**Commit Style Reference**
- Follow the Commit Guidelines section (types, emojis, conventional format)
- Always validate staged files before committing
- Group related changes into single atomic commits

**Staging Override**
- **Hermes MAY stage new files** when performing batch git operations that require staging (e.g., preparing commits, rebase workflows)—this is an exception to the global "never stage new files" rule
- User must still approve staged content before final commit
