# Claude Code Auto Workflow Plugin

Automate: **specs → stories → issues → GitHub → code**

## Quick Start

### For Plugin Users (Installed via Marketplace)
After installing the plugin, run the setup skill to initialize your project:
```bash
/cc-auto-workflow:setup
```

Or initialize manually using the setup script:
```bash
curl https://raw.githubusercontent.com/nxhung2304/cc-auto-workflow-plugin/main/setup.sh | bash
```

Or manually initialize:
```bash
# 1. Create specs directory
mkdir -p specs/{rules,issues,designs,comments}

# 2. Create your PRD and stories
code specs/prd.md    # Write requirements
code specs/story.md  # Format: - [ ] [#]. [title]

# 3. Start using commands
/cc-auto-workflow:generate-issues all
```

[View setup script →](https://github.com/nxhung2304/cc-auto-workflow-plugin/blob/main/setup.sh)

### For Local Development
```bash
bash setup.sh
```
## Workflow

**1️⃣ Create PRD & Stories**
```bash
code specs/prd.md    # Requirements
code specs/story.md  # Format: - [ ] [#]. [title]
```
**2️⃣ Generate Issues**
```bash
/cc-auto-workflow:generate-issues all
```
**3️⃣ Review & Approve**
Edit `specs/issues/*.md`, change `pending` → `approved`

**4️⃣ Sync to GitHub**
```bash
/cc-auto-workflow:sync-github-issues
```
**5️⃣ Implement**
```bash
/cc-auto-workflow:implement-issue 1
```

## Commands

| Command | Purpose |
|---------|---------|
| `/cc-auto-workflow:generate-issues all` | Create issues from stories |
| `/cc-auto-workflow:sync-github-issues` | Push approved issues to GitHub |
| `/cc-auto-workflow:implement-issue [#]` | Implement a specific issue |
| `/cc-auto-workflow:review-specs [#]` | Review issue spec |
| `/cc-auto-workflow:review-code [#]` | Review implementation |

## Requirements

**Before `/generate-issues`:**
- `specs/prd.md` ✅
- `specs/story.md` ✅

**Before `/sync-github-issues`:**
- Issues marked `approved` ✅
- `gh auth login` ✅

**Before `/implement-issue [#]`:**
- Issue file exists ✅
- Status `approved` ✅

## Setup

Auto-detects framework:
- Rails (Gemfile) → `specs/rules/rails.md`
- Flutter (pubspec.yaml) → `specs/rules/flutter.md`

**GitHub (required):**
```bash
gh auth login
```
**Slack (optional):**
```bash
export SLACK_BOT_TOKEN=xoxb-xxxxx
export SLACK_CHANNEL_ID=C0AGTJ0EE6B
```

## Coding Standards

Follow `specs/rules/clean_code.md`:
- Clear, intention-revealing names
- Small, focused functions
- Validate inputs early
- Comments explain **why**
- No magic numbers or dead code

## Troubleshooting

| Problem | Solution |
|---------|----------|
| setup.sh fails | Check: `ls -l specs/` |
| /generate-issues fails | Verify story.md format |
| Can't sync | Run: `gh auth login` |
| Issue "pending" | Edit → change to `approved` |

## Directory

```
specs/
├── prd.md          # Requirements
├── story.md        # Tasks
├── issues/         # Generated
├── designs/        # Wireframes
├── comments/       # Reviews
└── rules/          # Standards
```

## More Info

- [INSTALL.md](./INSTALL.md) — Setup guide
- [FRAMEWORKS.md](./FRAMEWORKS.md) — Framework rules
- `specs/rules/clean_code.md` — Code standards
