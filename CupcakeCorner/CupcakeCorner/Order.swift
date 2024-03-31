//
//  Order.swift
//  CupcakeCorner
//
//  Created by saliou seck on 27/03/2024.
//

import Foundation

struct Address : Codable {
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"

    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

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
    var address = Address() {
        didSet {
            if let encodedAddress = try? JSONEncoder().encode(address) {
                UserDefaults.standard.setValue(encodedAddress, forKey: "address")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        if let savedAddress = UserDefaults.standard.data(forKey: "address"){
            if let decodedAddress = try? decoder.decode(Address.self, from: savedAddress){
                address = decodedAddress
            }
        }
    }
    
//    var name = ""
//    var streetAddress = ""
//    var city = ""
//    var zip = ""
    var hasValidAddress: Bool {
        if address.name.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.city.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }

        return true
    }
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
