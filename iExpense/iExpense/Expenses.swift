import Foundation

class Expenses: ObservableObject {
    static private let dataKey = "expense_items"
    
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: Self.dataKey)
            }
        }
    }
    
    init() {
        guard let saved = UserDefaults.standard.data(forKey: Self.dataKey),
              let decoded = try? JSONDecoder().decode(type(of: items), from: saved)
        else {
            items = []
            return
        }
        items = decoded
    }
    
    func addItem(_ item: ExpenseItem) {
        items.append(item)
    }
}
