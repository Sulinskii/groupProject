//
// Created by Artur Sulinski on 02/12/2018.
// Copyright (c) 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MainFlowController {
    private var onboardingFlowController: OnBoardingFlowController?
    private var afterLoginFlowController: AfterLoginFlowController?
    private let rootNavigationController: UINavigationController
    private let disposeBag = DisposeBag()

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    func startFlow() {
        rootNavigationController.setNavigationBarHidden(true, animated: false)
        startOnboardingFlow()
    }

    private func startOnboardingFlow() {
        onboardingFlowController = OnBoardingFlowController(rootNavigationController: rootNavigationController)

        onboardingFlowController?.action.subscribe(onNext: {
            [unowned self] action in
            switch action {
            case .onLogin: self.startAfterLoginFlow()
            }
        }).disposed(by: disposeBag)
        onboardingFlowController?.startFlow()
    }

    private func startAfterLoginFlow() {
        afterLoginFlowController = AfterLoginFlowController(rootNavigationController: rootNavigationController)
        afterLoginFlowController?.startFlow()

        afterLoginFlowController?.action.subscribe(onNext: {
            [unowned self] action in
            switch action {
            case .onLogout: self.startOnboardingFlow()
            }
        }).disposed(by: disposeBag)
    }
}
