//
//  Commerce.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 29/10/25.
//

import Foundation

struct Commerce: Decodable {
    
    let name: String?
    let category: Category?
    let location: [Double]?
    let address: [String:String]?
}

enum Category: String, Decodable, CaseIterable {
    case beauty = "BEAUTY"
    case directSales = "DIRECT_SALES"
    case electricStation = "ELECTRIC_STATION"
    case food = "FOOD"
    case gasStation = "GAS_STATION"
    case leisure = "LEISURE"
    case shopping = "SHOPPING"
}
