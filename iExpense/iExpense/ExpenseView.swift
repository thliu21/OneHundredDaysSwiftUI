import SwiftUI

struct ExpenseView: View {
    @StateObject private var expenses = Expenses()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ExpenseType.allCases) { c in
                    if let items = expenses.items.filter({ $0.type == c }),
                       items.count > 0 {
                        Section(header: Text(c.rawValue)) {
                            ForEach(items) {    
                                ExpenseItemView(item: $0)
                            }
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            AddView(isPresented: $showingSheet, expenses: expenses)
        }
    }
    
    func removeItems(at index: IndexSet) {
        expenses.items.remove(atOffsets: index)
    }
}
