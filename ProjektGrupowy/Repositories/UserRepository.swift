//
// Created by Artur Sulinski on 02/12/2018.
// Copyright (c) 2018 Artur Sulinski. All rights reserved.
//

import Foundation

class UserRepository {
    private var user: User?
    private var appKeychain: AppKeychain

    static let shared = UserRepository()

    init(appKeychain: AppKeychain = DefaultAppKeychain.shared) {
        self.appKeychain = appKeychain
    }

    func save(_ user: User) {
        self.user = user
        appKeychain.save(user)
    }

    func readUser() -> User? {
        if user == nil {
            let keychainUser = appKeychain.readUser()
            self.user = keychainUser
        }
        return user
    }

    func removeUser() {
        self.user = nil
        appKeychain.removeUser()
    }
}
