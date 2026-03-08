# Flutter Code Rules

## General Principles

- Follow Flutter's official style guide and Dart conventions
- Prefer readability over clever code
- Keep widgets small and focused
- Separate UI from business logic
- Prefer explicit code over implicit behavior
- Avoid unnecessary abstractions

---

## Naming Conventions

- Classes: `PascalCase`
- Variables, methods, parameters: `camelCase`
- Constants: `camelCase` (Dart convention, not SCREAMING_SNAKE)
- Files: `snake_case`
- Use descriptive names, avoid abbreviations

Good
```dart
final currentUser = ref.watch(currentUserProvider);
```

Bad
```dart
final u = ref.watch(prov);
```

---

## Project Structure

Organize by feature, not by type.

```
lib/
  features/
    auth/
      data/
      domain/
      presentation/
    profile/
      data/
      domain/
      presentation/
  shared/
    widgets/
    utils/
    constants/
  main.dart
```

---

## Widgets

Rules
- Keep widgets small — extract when a widget exceeds ~50 lines
- Prefer `StatelessWidget` unless local UI state is needed
- Do not place business logic inside widgets
- Avoid deeply nested widget trees — extract sub-widgets or use helper methods
- Prefer `const` constructors wherever possible

Bad
```dart
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 200 lines of nested widgets
      ],
    );
  }
}
```

Good
```dart
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UserHeader(),
        const UserPostList(),
      ],
    );
  }
}
```

---

## State Management

- Do not manage business state inside widgets
- Separate UI state from domain state when needed
- Use a dedicated state management solution (project-specific)
- Avoid passing state down through many widget layers — use providers or equivalent

---

## Data Layer

Rules
- Repositories abstract data sources from the rest of the app
- Do not call APIs or databases directly from widgets or view models
- Return domain models, not raw API responses
- Handle errors at the repository or service layer

```
Widget → Provider/ViewModel → Repository → Data Source (API / DB)
```

---

## Models

Rules
- Domain models should be immutable when possible
- Use `copyWith` for updates
- Avoid putting business logic inside models
- Separate API response models (DTOs) from domain models when needed

---

## Error Handling

Rules
- Never silently swallow exceptions
- Surface errors to the UI layer explicitly
- Use typed exceptions or sealed result types when complexity warrants it

Bad
```dart
try {
  await repository.fetchUser();
} catch (_) {}
```

Good
```dart
try {
  await repository.fetchUser();
} catch (e) {
  state = AsyncError(e, StackTrace.current);
}
```

---

## Async Code

Rules
- Always `await` futures — never fire and forget unless intentional
- Mark intentional fire-and-forget with a comment
- Handle loading and error states explicitly in the UI

---

## Constants

Avoid magic numbers or strings.

Bad
```dart
SizedBox(height: 16)
```

Good
```dart
// shared/constants/spacing.dart
class Spacing {
  static const double md = 16;
}

SizedBox(height: Spacing.md)
```

---

## Navigation

- Do not use `BuildContext` for navigation inside business logic or providers
- Navigation belongs in the UI layer or a dedicated router
- Use a navigation solution (project-specific)

---

## Performance

Rules
- Use `const` widgets wherever possible
- Avoid rebuilding large widget trees unnecessarily
- Use `ListView.builder` for long lists — never `ListView` with a large children array
- Avoid doing heavy work inside `build()`

---

## Testing

Rules
- Test repositories and domain logic thoroughly
- Widget tests for critical UI flows
- Avoid testing implementation details
- Use fakes/mocks for external dependencies

---

## AI Coding Instructions

When generating Flutter/Dart code:
- Follow all rules defined in this document
- Prefer simple and readable implementations
- Avoid unnecessary packages
- Do not introduce architecture not already used in the project
- Keep widgets small and focused
- Separate business logic from UI
- Always handle loading and error states
- Use `const` constructors wherever applicable
- Never swallow exceptions silently
