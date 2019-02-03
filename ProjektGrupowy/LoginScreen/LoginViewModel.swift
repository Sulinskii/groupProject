//
//  LoginViewModel.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 02/12/2018.
//  Copyright © 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import RxSwift

enum LoginViewModelAction {
    case onLogin(user: User)
}

class LoginViewModel {
    let action: PublishSubject<LoginViewModelAction> = PublishSubject()
    private let userRepository: UserRepository


    init(userRepository: UserRepository = UserRepository.shared) {
        self.userRepository = userRepository
    }

    func onUserLoggedIn(_ user: User) {
        userRepository.save(user)
        action.onNext(.onLogin(user: user))
    }

    
}
