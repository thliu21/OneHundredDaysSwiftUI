//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by Tianhao Liu on 11/7/22.
//

import SwiftUI

struct ExpenseItemView: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.rawValue)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Text(AdaptedCurrencyFormatter().string(for: item.amount) ?? "")
        }
    }
}
