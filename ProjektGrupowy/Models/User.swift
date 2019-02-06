//
// Created by Artur Sulinski on 02/12/2018.
// Copyright (c) 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    private(set) var login: String = ""
    private(set) var name: String = ""
    private(set) var superUser: Bool = false
    private(set) var surname: String = ""
    private(set) var token: String = ""

    init() { }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        login <- map["login"]
        name <- map["name"]
        superUser <- map["superUser"]
        surname <- map["surname"]
        token <- map["token"]
    }
}
