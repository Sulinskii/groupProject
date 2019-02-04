//
// Created by Artur Sulinski on 2019-02-04.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct RegisterUser: Mappable {
    private(set) var login: String = ""
    private(set) var password: String = ""
    private(set) var name: String = ""
    private(set) var surname: String = ""

    init?(map: Map) {

    }

    init(login: String, password: String, name: String, surname: String){
        self.login = login
        self.password = password
        self.name = name
        self.surname = surname
    }

    mutating func mapping(map: Map) {
        login <- map["login"]
        password <- map["password"]
        name <- map["name"]
        surname <- map["surname"]
    }
}
