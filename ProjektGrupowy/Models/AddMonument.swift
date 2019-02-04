//
// Created by Artur Sulinski on 2019-02-04.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct AddMonument: Mappable {
    private(set) var name: String = ""
    private(set) var function: String = ""
    private(set) var creationDone: String = ""
    private(set) var archivalSource: String = ""
    private(set) var coordinates: Coordinate = Coordinate()
    private(set) var address: Address = Address()

    init?(map: Map) {

    }

    init(name: String, function: String, creationDone: String, archivalSource: String, coordinates: Coordinate, address: Address){
        self.name = name
        self.function = function
        self.creationDone = creationDone
        self.archivalSource = archivalSource
        self.coordinates = coordinates
        self.address = address
    }

    mutating func mapping(map: Map) {
        name <- map["name"]
        function <- map["function"]
        creationDone <- map["creationDone"]
        archivalSource <- map["archivalSource"]
        coordinates <- map["coordinates"]
        address <- map["address"]
    }
}
