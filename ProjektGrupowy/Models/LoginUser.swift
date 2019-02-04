//
// Created by Artur Sulinski on 2019-02-04.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import ObjectMapper

struct LoginUser: Mappable {
    private(set) var login: String = ""
    private(set) var password: String = ""

    init?(map: Map) {

    }

    init(login: String, password: String){
        self.login = login
        self.password = password
    }

    mutating func mapping(map: Map) {
        login <- map["login"]
        password <- map["password"]
    }
}
