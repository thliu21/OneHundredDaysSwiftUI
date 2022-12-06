//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Tianhao Liu on 12/5/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Street Address", text: $order.address.streetAddress)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
            }

            Section {
                NavigationLink {
                    EmptyView()
                } label: {
                    Text("Check out")
                        .foregroundColor(order.address.isValid ? .red : .gray)
                }
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
