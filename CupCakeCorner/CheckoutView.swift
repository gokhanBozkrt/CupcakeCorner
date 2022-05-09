//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Gokhan Bozkurt on 8.05.2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order:Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var alertMessage = ""
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string:"https://hws.dev/img/cupcakes@3x.jpg"),scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                withAnimation {
                    Text("Your total cost \(order.cost, format: .currency(code: "USD"))")
                        .font(.title)
                }
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertMessage, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode data")
            return
        }
       let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertMessage = "Thank You!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed")
            alertMessage = "Connection Error!"
            confirmationMessage = "Please Check your network"
            showingConfirmation = true
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}



