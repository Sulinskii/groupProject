//
// Created by Artur Sulinski on 2019-02-02.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import RxSwift

class RegisterViewModel {

    private var userRepository: UserRepository!
    private let disposeBag = DisposeBag()
    private var responseError: Variable<Bool> = Variable(false)
    var responseObservable: Observable<Bool> {
        return responseError.asObservable()
    }

    init(userRepository: UserRepository = UserRepository.shared) {
        self.userRepository = userRepository
    }

    func registerUser(user: RegisterUser) {
        API.register(user: user).execute().subscribe {
            [unowned self](event: SingleEvent<User>) in
            switch event {
            case .success(let response):
                print("everything ok")
                print(response)
                self.userRepository.save(response)
                self.onUserLoggedIn()
                DefaultAppKeychain.shared.save(token: response.token)
                self.responseError.value = false
            case .error(_):
                self.responseError.value = true
                print("error")


            }
        }.disposed(by: self.disposeBag)
    }

    var onUserLoggedIn: () -> () = { }
}
