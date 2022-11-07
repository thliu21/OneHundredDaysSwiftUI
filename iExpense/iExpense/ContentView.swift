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
                    Text(item.name)
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
            AddView(isPresented: $showingSheet)
        }
    }
    
    func removeItems(at index: IndexSet) {
        expenses.items.remove(atOffsets: index)
    }
}
