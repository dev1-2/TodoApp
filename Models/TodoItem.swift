import Foundation

struct TodoItem: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var notificationId: String?

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil, notificationId: String? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.notificationId = notificationId
    }
}
