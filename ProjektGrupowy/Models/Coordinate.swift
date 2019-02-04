//
// Created by Artur Sulinski on 2019-02-03.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct Coordinate: Mappable {
    private(set) var latitude: Double = 0.0
    private(set) var longitude: Double = 0.0

    init?(map: Map) {

    }
    init(latitude: Double = 0, longitude: Double = 0){
        self.latitude = latitude
        self.longitude = longitude
    }

    mutating func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
