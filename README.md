# 🛒 Shopping List App – UIKit

> ⚠️  I completed this project without access to a macOS device or Xcode, simply because I currently don’t own one.
Despite that, I wanted to demonstrate my skills and commitment by manually writing all the code, structuring the app fully with UIKit, and following the test instructions precisely — from UI layout to app logic and architecture .
---

## 🎯 Objective

Create an iOS app that allows users to manage a shopping list, fulfill the required MVP features, and implement one bonus feature of choice.

---

## ✅ MVP Features Completed

| Feature                                 | Implemented |
|----------------------------------------|-------------|
| Display a list of items (`UITableView`)| ✅          |
| Text field to enter item names         | ✅          |
| Quantity selector using a `UIStepper`  | ✅          |
| Button to add items                    | ✅          |
| Swipe to delete an item                | ✅          |
| Tap to mark an item as completed       | ✅          |

---

## 🌟 Bonus Feature Implemented: **Categorization + Filtering**

| Feature                                | Implemented |
|----------------------------------------|-------------|
| Add a category per item                | ✅           |
| Store and filter items by category     | ✅           |
| Filtering UI using `UISegmentedControl`| ✅           |

---

## 🔐 Additional Feature Added: **Mock Login + Per-user Data Persistence**

Although not required for the selected bonus, I also implemented:

- A basic **login screen** (mock authentication)
- Separate local data storage **per user**
- Simulated user-specific sessions with persistent storage

> ⚠️ Due to not having access to macOS/Xcode, `CoreData` could not be implemented. I used `UserDefaults` to simulate multi-user persistence, encoding data with `Codable`. In a real project, I would migrate to `CoreData`.

---
