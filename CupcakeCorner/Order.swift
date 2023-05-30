//
//  Order.swift
//  CupcakeCorner
//
//  Created by Uriel Ortega on 27/05/23.
//

import SwiftUI

@dynamicMemberLookup
class SharedOrder: ObservableObject {
    static let types = ["Vainilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = Order()
    
    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T { // Handle any dynamic property, as long as it is one that exists on Order.
        data[keyPath: keyPath]                        // The T (generic type) makes it possible to use, for example, order.name (a String), order.addSprinkles (a Bool), etc.
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keyPath]
        }
        set {
            data[keyPath: keyPath] = newValue
        }
    }
}

struct Order: Codable {
    enum CodingKeys: CodingKey {  // Properties we want to save.
    case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isPureWhitespace || streetAddress.isPureWhitespace || city.isPureWhitespace || zip.isPureWhitespace {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // Complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for extra sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
