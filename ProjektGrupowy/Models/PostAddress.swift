//
// Created by Artur Sulinski on 2019-02-04.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostAddress: Mappable {
    private(set) var city: String = ""
    private(set) var country: String = ""
    private(set) var flatNumber: String = ""
    private(set) var houseNumber: String = ""
    private(set) var postCode: String = ""
    private(set) var street: String = ""

    init?(map: Map) {

    }
    init(){

    }

    mutating func mapping(map: Map) {
        city <- map["city"]
        country <- map["country"]
        flatNumber <- map["flatNumber"]
        houseNumber <- map["houseNumber"]
        postCode <- map["postCode"]
        street <- map["street"]
    }
}
