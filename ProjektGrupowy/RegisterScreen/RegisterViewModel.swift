//
// Created by Artur Sulinski on 2019-02-02.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import RxSwift

class RegisterViewModel {

    private var userRepository: UserRepository!
    private let disposeBag = DisposeBag()

    init(userRepository: UserRepository = UserRepository.shared) {
        self.userRepository = userRepository
    }

    func registerUser(user: RegisterUser) {
        API.register(user: user).execute().subscribe {
            [unowned self](event: SingleEvent<User>) in
            switch event {
            case .success(let response):
                print("everything ok")
                self.userRepository.save(response)
                self.onUserLoggedIn()
            case .error(_):
                print("error")


            }
        }.disposed(by: self.disposeBag)
    }
//    func saveNewUser(_ user: User){
//        userRepository.save(user)
//
//    }

    var onUserLoggedIn: () -> () = { }
}
