//
// Created by Artur Sulinski on 02/12/2018.
// Copyright (c) 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

enum AfterLoginFlowControllerAction {
    case onLogout
}

class AfterLoginFlowController {
    private let rootNavigationController: UINavigationController!
    private let disposeBag = DisposeBag()
    let action: PublishSubject<AfterLoginFlowControllerAction> = PublishSubject()

    init(rootNavigationController: UINavigationController){
        self.rootNavigationController = rootNavigationController
    }

    func startFlow(){
        rootNavigationController.setNavigationBarHidden(false, animated: false)
        let viewModel = MapViewModel()
        let viewController = MapViewController(viewModel: viewModel)
        viewController.navigationController?.navigationBar.backgroundColor = .brown
        rootNavigationController.navigationBar.backgroundColor = .blue
        rootNavigationController.navigationBar.barTintColor = .brown
        rootNavigationController.setViewControllers([viewController], animated: false)
        viewModel.onLogoutTapped = {
            self.rootNavigationController.popToRootViewController(animated: false)
            UserRepository.shared.removeUser()
            self.action.onNext(.onLogout)
        }
    }

//    private func createMapNavigationController() -> UINavigationController {
//        let navigationController = UINavigationController(rootViewController: viewController)
//        self.mapNavigationController = navigationController
//        return navigationController
//    }

}
