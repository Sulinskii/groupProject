//
// Created by Artur Sulinski on 2019-02-04.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct AddMonument: Mappable {
    private(set) var name: String = ""
    private(set) var function: String = ""
    private(set) var creationDate: String = ""
    private(set) var archivalSource: String = ""
//    private(set) var type: String = ""
//    private(set) var status: String = ""
    private(set) var coordinates: Coordinate = Coordinate()
    private(set) var address: Address = Address()

    init?(map: Map) {

    }

    init(name: String = "", function: String = "",  creationDone: String = "", archivalSource: String = "",
         coordinates: Coordinate = Coordinate(), address: Address = Address()){
        self.name = name
        self.function = function
        self.creationDate = creationDone
        self.archivalSource = archivalSource
        self.coordinates = coordinates
        self.address = address
    }

    mutating func mapping(map: Map) {
        name <- map["name"]
        function <- map["function"]
        creationDate <- map["creationDate"]
        archivalSource <- map["archivalSource"]
//        type <- map["type"]
//        status <- map["status"]
        coordinates <- map["coordinates"]
        address <- map["address"]
    }
}
