//
// Created by Artur Sulinski on 02/12/2018.
// Copyright (c) 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?


    init(id: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        phone <- map["phone"]
    }
}
