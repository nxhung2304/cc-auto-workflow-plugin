# Framework-Specific Coding Rules

This plugin includes framework-specific coding standards that are automatically copied during setup.

## Auto-Detection

When you run `bash setup.sh`, the script automatically detects your framework:

```
Rails Project     → copies templates/rails.md     → specs/rules/rails.md
Flutter Project   → copies templates/flutter.md   → specs/rules/flutter.md
React Project     → copies templates/react.md     → specs/rules/react.md (if available)
Django Project    → copies templates/django.md    → specs/rules/django.md (if available)
Other/Unknown     → asks you to select or skip
```

---

## Available Frameworks

### Rails

**Detection:** Looks for `Gemfile` or `config/environment.rb`

**Rules:** `templates/rails.md` → `specs/rules/rails.md`

**Coverage:**
- Controllers (thin controllers, strong params, delegation)
- Models (domain logic, scopes, delegates)
- Service Objects (business logic, error handling)
- Query Optimization (N+1 prevention, includes/preload)
- Background Jobs (ActiveJob patterns)
- Validations & Callbacks
- JSON API structure
- Error Handling
- Constants & Magic Numbers
- Testing

---

### Flutter

**Detection:** Looks for `pubspec.yaml` or `lib/main.dart`

**Rules:** `templates/flutter.md` → `specs/rules/flutter.md`

**Coverage:**
- Naming Conventions (PascalCase, camelCase)
- Project Structure (features-based organization)
- Widgets (size limits, const constructors, extraction)
- State Management (provider pattern)
- Data Layer (repositories, data sources)
- Models & DTOs
- Error Handling
- Async Code & Futures
- Constants & Magic Numbers
- Navigation
- Performance (const, ListView.builder)
- Testing

---

## Using Framework Rules

### 1. Automatic (Recommended)

Just run:
```bash
bash setup.sh
```

The appropriate rules file will be copied automatically.

### 2. Manual Selection

If `bash setup.sh` doesn't detect your framework:

```bash
# Copy Rails rules
cp templates/rails.md specs/rules/rails.md

# Copy Flutter rules
cp templates/flutter.md specs/rules/flutter.md
```

### 3. Customize

Each framework rules file is a starting point. You can:
- Add project-specific patterns
- Remove sections that don't apply
- Extend with additional standards

Example:
```bash
# Edit and customize for your project
code specs/rules/rails.md
```

---

## For Code Review & Implementation

The skills use these rules:

- **`/review-code [issue-number]`** — Checks code against all rules in `specs/rules/`
- **`/implement-issue [number]`** — Follows all rules when implementing
- **`/review-specs [issue-number]`** — References rules when reviewing specs

---

## Adding New Framework Templates

To add a new framework (e.g., Django, Node.js):

1. Create `templates/framework-name.md`
2. Document your standards (see Rails & Flutter as examples)
3. Run `bash setup.sh` — it will auto-detect and ask which template to use

---

## Foundation Rules

All frameworks build on **`specs/rules/clean_code.md`**, which covers:
- Naming & Readability
- Functions & Methods
- Comments & Documentation
- Error Handling

**Framework-specific rules SUPPLEMENT, not replace** the universal principles in `clean_code.md`.

---

## Tips

✅ **Keep rules focused** — only include what's relevant to your project

✅ **Document with examples** — show good and bad patterns

✅ **Update as you evolve** — rules should reflect your team's practices

✅ **Reference in code** — link to rule numbers when reviewing code

Example in code review:
> "This violates `rails.md` — Controllers rule #2: business logic should be in Service Objects"

---

## Questions?

See `README.md` for workflow overview and `INSTALL.md` for setup details.
