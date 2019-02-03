//
// Created by Artur Sulinski on 2019-02-03.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct Coordinate: Mappable {
    private(set) var id: Int = Int.max
    private(set) var latitude: Double = 0.0
    private(set) var longitude: Double = 0.0

    init?(map: Map) {

    }
    init(){

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
