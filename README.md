# Claude Code Auto Workflow Plugin

Automate: **specs → stories → issues → GitHub → code**

## Quick Start
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
/generate-issues all
```
**3️⃣ Review & Approve**
Edit `specs/issues/*.md`, change `pending` → `approved`

**4️⃣ Sync to GitHub**
```bash
/sync-github-issues
```
**5️⃣ Implement**
```bash
/implement-issue 1
```

## Commands

| Command | Purpose |
|---------|---------|
| `/generate-issues all` | Create issues |
| `/sync-github-issues` | Push to GitHub |
| `/implement-issue [#]` | Implement |
| `/review-specs [#]` | Review spec |
| `/review-code [#]` | Review code |

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
