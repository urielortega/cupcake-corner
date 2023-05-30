//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Uriel Ortega on 27/05/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order // Using the same order, already created in ContentView.
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

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
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("CheckOut")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Ok") {  }
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // Handle the result:
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            alertTitle = "Thank you!"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
            print("Checkout failed")
            
            alertTitle = "Something went wrong"
            alertMessage = "Please check your connection and try again."
            showingAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
