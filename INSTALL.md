# Installation Guide

## Prerequisites

- Claude Code installed
- Git (for version control)
- GitHub CLI (`gh`) — optional but recommended for `sync-github-issues` and `implement-issue`

## Setup Instructions

### 1. Run Setup Script

```bash
bash setup.sh
```

The setup script **automatically detects your framework**:

| Framework | Detection | Rules File |
|-----------|-----------|-----------|
| **Rails** | Looks for `Gemfile` | `specs/rules/rails.md` |
| **Flutter** | Looks for `pubspec.yaml` | `specs/rules/flutter.md` |
| **React/Next** | Looks for `package.json` with React | `specs/rules/react.md` (if available) |
| **Django** | Looks for `manage.py` | `specs/rules/django.md` (if available) |
| **Other** | Not detected | Asks you to choose or skip |

This initializes your project with:
- ✅ Directory structure (`specs/issues`, `specs/designs`, `specs/comments`)
- ✅ Template files (`specs/prd.md`, `specs/story.md`)
- ✅ Coding standards (`specs/rules/clean_code.md`, `specs/rules/coding.md`, `specs/rules/design.md`)

### 2. Configure Your Project

**Edit Product Requirements:**
```bash
code specs/prd.md
```
- Write your product vision and goals
- Define features and success criteria

**Edit Story Breakdown:**
```bash
code specs/story.md
```
- Break down PRD into numbered tasks
- Use format: `- [ ] [number]. [title]`

### 3. Customize Coding Standards (Optional)

Edit rules files for your project:

```bash
code specs/rules/coding.md      # Language-specific standards
code specs/rules/design.md      # UI/UX guidelines
code specs/rules/flutter.md     # If using Flutter (create if needed)
```

### 4. Set Up GitHub (Required for sync & implement)

```bash
# Authenticate with GitHub
gh auth login

# Verify repository
gh repo view
```

### 5. Set Up Slack (Optional, for notifications)

If you want Slack notifications during implementation:

```bash
export SLACK_BOT_TOKEN=xoxb-your-token-here
export SLACK_CHANNEL_ID=C0AGTJ0EE6B
```

---

## First Run

Once setup is complete:

```bash
# 1. Generate issues from your story
/generate-issues all

# 2. Review and approve issues in specs/issues/
#    Change status from "pending" to "approved"

# 3. Sync approved issues to GitHub
/sync-github-issues

# 4. Implement an issue
/implement-issue 1
```

See `README.md` for detailed workflow documentation.

---

## Troubleshooting

**Q: Setup script fails?**
- Ensure you have write permissions in the project directory
- Check that `bash` is available: `which bash`

**Q: `/generate-issues` fails?**
- Verify `specs/prd.md` and `specs/story.md` exist
- Check story.md format: `- [ ] [number]. [title]`

**Q: Cannot sync to GitHub?**
- Run: `gh auth login`
- Verify your repository is created on GitHub

**Q: Don't see issue files created?**
- Check: `ls specs/issues/`
- Verify story.md has tasks in correct format

---

## What's Next?

1. Read `README.md` for complete workflow guide
2. Check `specs/rules/clean_code.md` for code standards
3. Customize `specs/rules/` files for your project
4. Start with `/generate-issues all`

Happy coding! 🚀
