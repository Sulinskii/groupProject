//
// Created by Artur Sulinski on 2019-02-03.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct Author: Mappable {
    private(set) var id: Int = Int.max
    private(set) var login: String = ""
    private(set) var name: String = ""
    private(set) var password: String = ""
    private(set) var surname: String = ""

    init?(map: Map) {

    }
    init(){

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        login <- map["login"]
        name <- map["name"]
        password <- map["password"]
        surname <- map["surname"]

    }
}
