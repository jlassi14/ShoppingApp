import Foundation

class PersistenceManager {
    func saveItems(_ items: [ShoppingItem], for username: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(items) {
            UserDefaults.standard.set(data, forKey: "items_\(username)")
        }
    }

    func loadItems(for username: String) -> [ShoppingItem] {
        guard let data = UserDefaults.standard.data(forKey: "items_\(username)") else { return [] }
        let decoder = JSONDecoder()
        return (try? decoder.decode([ShoppingItem].self, from: data)) ?? []
    }
}
