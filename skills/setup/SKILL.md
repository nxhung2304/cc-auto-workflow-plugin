---
description: Initialize project structure for auto-workflow plugin
disable-model-invocation: true
---

Run the project setup script to initialize specs directory and configuration:

```bash
curl https://raw.githubusercontent.com/nxhung2304/cc-auto-workflow-plugin/main/setup.sh | bash
```

This creates:
- `specs/` directory with subdirectories (prd, story, issues, designs, comments, rules)
- `specs/rules/clean_code.md` coding standards
- Basic `specs/prd.md` and `specs/story.md` templates

After setup, you're ready to:
1. Edit specs/prd.md with your requirements
2. Edit specs/story.md with your tasks
3. Run `/cc-auto-workflow:generate-issues all`
