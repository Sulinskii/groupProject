//
//  MapViewModel.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 03/12/2018.
//  Copyright © 2018 Artur Sulinski. All rights reserved.
//

import Foundation
import RxSwift

class MapViewModel {
    private let disposeBag = DisposeBag()
    private var userRepository: UserRepository!
    private var monuments: Variable<[Monument]> = Variable([])
    var monumentsObservable: Observable<[Monument]> {
        return monuments.asObservable()
    }

    init(userRepository: UserRepository = UserRepository.shared) {
        self.userRepository = userRepository
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadMonuments() {
        API.getAllMonuments.execute().subscribe {
            [unowned self](event: SingleEvent<[Monument]>) in
            switch event {
            case .success(let response):
                self.monuments.value = response
//                print(self.monuments.value)
            case .error(_):
                print("error")
                break
            }
        }.disposed(by: disposeBag)
    }

    var onLogoutTapped: () -> () = {}

    func logout(){
        userRepository.removeUser()
        DefaultAppKeychain.shared.removeToken()
    }
}
