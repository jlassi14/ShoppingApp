import Foundation

struct ShoppingItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var quantity: Int
    var isCompleted: Bool
    var category: String

    init(name: String, quantity: Int, category: String) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.category = category
        self.isCompleted = false
    }
}