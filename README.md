# Clean Todo (SwiftUI)

Minimal, very clean Todo app implemented in SwiftUI with local persistence and notifications.

How to use
- Open Xcode and create a new iOS project (App) using SwiftUI and Swift.
- Replace the default `ContentView.swift` and `App` files with the files from this folder, or add the files into your project:
  - TodoApp.swift
  - Models/TodoItem.swift
  - ViewModels/TodoViewModel.swift
  - Views/ContentView.swift
  - Views/AddTodoView.swift
  - Services/NotificationManager.swift
  - Persistence/Persistence.swift

- Build and run on an iPhone 14 simulator or device.

Notes
- The app asks for notification permission on first launch. If you schedule reminders, allow notifications.
- Persistence uses `UserDefaults` with JSON encoding for simplicity; it is sufficient for a small Todo list.

Design
- Clean, minimal SwiftUI design with `insetGrouped` list style, subtle typography, and lightweight interactions (tap to toggle, swipe to delete).
