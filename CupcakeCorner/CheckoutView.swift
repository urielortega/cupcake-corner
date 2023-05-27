//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Uriel Ortega on 27/05/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order // Using the same order, already created in ContentView.

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233) // To save the space for the image and the progress indicator.
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order", action: {})
                    .padding()
            }
        }
        .navigationTitle("CheckOut")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
