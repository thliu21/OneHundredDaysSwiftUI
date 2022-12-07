//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Tianhao Liu on 12/5/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { context in
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) {
                        $0.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: context.size.width)
                    
                    Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                        .font(.title)

                    Button("Place Order", action: {
                        Task {
                            await placeOrder()
                        }
                    })
                        .padding()
                }
            }
            .alert("Thank you!", isPresented: $showingConfirmation) {
                Button("OK") { }
            } message: {
                Text(confirmationMessage)
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func placeOrder() async {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(order)
        else { return }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.foodOrder.quantity) \(decodedOrder.foodOrder.flavor.rawValue.lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
        }
    }
}
