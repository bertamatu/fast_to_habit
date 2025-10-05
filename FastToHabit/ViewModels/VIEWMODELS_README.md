# ViewModels

Observable ViewModels for the Fast To Habit app.

## Purpose
Contains business logic and state management for views.

## Guidelines
- Use `@Observable` macro (not `ObservableObject`)
- Keep business logic in ViewModels, not Views
- Handle SwiftData operations here
- Write unit tests for all ViewModels

## Planned ViewModels
- `FastingViewModel` - Fasting timer logic
- `SupplementViewModel` - Supplement CRUD operations

[Rule: MVVM Architecture - ViewModels Layer]
