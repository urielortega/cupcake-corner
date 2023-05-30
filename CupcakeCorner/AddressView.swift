//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Uriel Ortega on 27/05/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: SharedOrder // Using the same order, already created in ContentView.
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddressView(order: SharedOrder())
        }
    }
}
