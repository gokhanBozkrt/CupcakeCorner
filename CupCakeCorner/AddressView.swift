//
//  AddressView.swift
//  CupCakeCorner
//
//  Created by Gokhan Bozkurt on 8.05.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order:Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAdress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check Out")
                }

            }.disabled(order.hasValidAddress == false)
        }.navigationTitle("Delivery Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
