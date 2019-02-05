//
// Created by Artur Sulinski on 02/12/2018.
// Copyright (c) 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

enum OnboardingFlowAction {
    case onLogin
}

class OnBoardingFlowController {

    private let rootNavigationController: UINavigationController?
    private let disposeBag = DisposeBag()
    let action: PublishSubject<OnboardingFlowAction> = PublishSubject()
    private let userRepository: UserRepository

    init(rootNavigationController: UINavigationController, userRepository: UserRepository = UserRepository.shared) {
        self.rootNavigationController = rootNavigationController
        self.userRepository = userRepository
    }

    func startFlow() {
        rootNavigationController!.setNavigationBarHidden(true, animated: false)
        beforeShowLoginScreen()
    }

    private func beforeShowLoginScreen() {
        guard let _ = UserRepository.shared.readUser() else {
            showNotLoggedMapScreen()
            return
        }
        onNext()
    }

    private func onNext(){
        action.onNext(.onLogin)
    }

    private func showNotLoggedMapScreen(){
        let notLoggedMapViewModel: NotLoggedMapViewModel = NotLoggedMapViewModel()
        let notLoggedMapViewController: NotLoggedMapViewController = NotLoggedMapViewController(viewModel: notLoggedMapViewModel)
        rootNavigationController?.setViewControllers([notLoggedMapViewController], animated: false)
        notLoggedMapViewModel.onLoginSelected = {
            self.showRegisterOrLoginScreen()
        }
    }

    private func showRegisterOrLoginScreen(){
        let registerOrLoginViewController: RegisterOrLoginViewController = RegisterOrLoginViewController()
        rootNavigationController?.pushViewController(registerOrLoginViewController, animated: true)
        registerOrLoginViewController.loginButtonTapped = {
            self.showLoginScreen()
        }
        registerOrLoginViewController.registerButtonTapped = {
            self.showRegisterScreen()
        }
    }

    private func showRegisterScreen() {
        let registerViewModel = RegisterViewModel()
        let registerViewController = RegisterViewController(viewModel: registerViewModel)
        rootNavigationController?.pushViewController(registerViewController, animated: true)
        registerViewModel.onUserLoggedIn = {
            self.onNext()
        }
    }

    private func showLoginScreen() {
        let loginViewModel = LoginViewModel()
        let loginViewController: LoginViewController = LoginViewController(viewModel: loginViewModel)

        rootNavigationController?.pushViewController(loginViewController, animated: true)
        loginViewModel.onUserLoggedIn = {
            self.onNext()
        }
    }
}
