import Foundation
import Combine

final class TodoViewModel: ObservableObject {
    @Published private(set) var todos: [TodoItem] = []

    init() {
        todos = Persistence.shared.load()
    }

    func add(title: String, dueDate: Date?) {
        var item = TodoItem(title: title, dueDate: dueDate)
        if let due = dueDate {
            let notifId = UUID().uuidString
            item.notificationId = notifId
            NotificationManager.shared.scheduleNotification(id: notifId, title: title, date: due)
        }
        todos.insert(item, at: 0)
        persist()
    }

    func toggle(_ item: TodoItem) {
        guard let idx = todos.firstIndex(of: item) else { return }
        todos[idx].isCompleted.toggle()
        persist()
    }

    func update(_ item: TodoItem, title: String, dueDate: Date?) {
        guard let idx = todos.firstIndex(where: { $0.id == item.id }) else { return }
        // remove old notification
        if let oldId = todos[idx].notificationId {
            NotificationManager.shared.removeNotification(id: oldId)
        }

        todos[idx].title = title
        todos[idx].dueDate = dueDate
        if let due = dueDate {
            let notifId = UUID().uuidString
            todos[idx].notificationId = notifId
            NotificationManager.shared.scheduleNotification(id: notifId, title: title, date: due)
        } else {
            todos[idx].notificationId = nil
        }

        persist()
    }

    func remove(at offsets: IndexSet) {
        for i in offsets {
            if let id = todos[i].notificationId {
                NotificationManager.shared.removeNotification(id: id)
            }
        }
        todos.remove(atOffsets: offsets)
        persist()
    }

    private func persist() {
        Persistence.shared.save(todos)
    }
}
