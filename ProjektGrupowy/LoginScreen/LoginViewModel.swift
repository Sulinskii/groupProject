//
//  LoginViewModel.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 02/12/2018.
//  Copyright © 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    private let userRepository: UserRepository
    private let disposeBag = DisposeBag()
    private var responseError: Variable<Bool> = Variable(false)
    var responseObservable: Observable<Bool> {
        return responseError.asObservable()
    }

    init(userRepository: UserRepository = UserRepository.shared) {
        self.userRepository = userRepository
    }

    func loginUser(user: LoginUser) {
        API.login(user: user).execute().subscribe {
            [unowned self](event: SingleEvent<User>) in
            switch event {
            case .success(let response):
                print("everything ok")
                print(response)
                self.userRepository.save(response)
                self.onUserLoggedIn()
                print(response.token)
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
