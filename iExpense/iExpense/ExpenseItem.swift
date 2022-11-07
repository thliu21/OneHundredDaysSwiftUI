import Foundation

enum ExpenseType: String, Identifiable, CaseIterable, Codable {
    case business = "Business"
    case personal = "Personal"
    var id: Self { self }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}
