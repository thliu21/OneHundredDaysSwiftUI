//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tianhao Liu on 12/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Cake Flavor", selection: $order.foodOrder.flavor) {
                        ForEach(FoodOrder.CakeFlavor.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Stepper(
                        "Number of cakes: \(order.foodOrder.quantity)",
                        value: $order.foodOrder.quantity,
                        in: 3...20
                    )
                }
                
                Section {
                    Toggle("Special Request", isOn: $order.foodOrder.specialRequestEnabled.animation())
                    if order.foodOrder.specialRequestEnabled {
                        Toggle("Extra frosting", isOn: $order.foodOrder.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.foodOrder.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}
