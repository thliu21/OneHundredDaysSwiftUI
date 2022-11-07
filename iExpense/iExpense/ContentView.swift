//
//  ContentView.swift
//  iExpense
//
//  Created by Tianhao Liu on 11/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var expenses = Expenses()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type.rawValue)
                        }
                        
                        Spacer()
                        Text(AdaptedCurrencyFormatter().string(for: item.amount) ?? "")
                    }
                }
                .onDelete(perform: removeItems)
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
