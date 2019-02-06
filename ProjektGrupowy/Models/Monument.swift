//
// Created by Artur Sulinski on 2019-02-03.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct Monument: Mappable {
    private(set) var address: Address = Address()
    private(set) var approved: Bool = false
    private(set) var archivalSource: String = ""
    private(set) var author: Author = Author()
    private(set) var coordinates: Coordinate = Coordinate()
    private(set) var creationDate: String = ""
    private(set) var function: String = ""
    private(set) var id: Int = Int.max
    private(set) var name: String = ""
    private(set) var status: String = ""
    private(set) var type: String = ""

    init?(map: Map) {

    }
    init(){

    }

    mutating func mapping(map: Map) {
        address <- map["address"]
        approved <- map["approved"]
        archivalSource <- map["archivalSource"]
        author <- map["author"]
        coordinates <- map["coordinates"]
        creationDate <- map["creationDate"]
        function <- map["function"]
        id <- map["id"]
        name <- map["name"]
        status <- map["status"]
        type <- map["type"]
    }

}
