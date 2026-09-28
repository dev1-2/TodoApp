import Foundation

final class Persistence {
    static let shared = Persistence()
    private let key = "todos_v1"

    func load() -> [TodoItem] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return (try? decoder.decode([TodoItem].self, from: data)) ?? []
    }

    func save(_ todos: [TodoItem]) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? encoder.encode(todos) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
