//
// Created by Artur Sulinski on 2019-02-02.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import RxSwift

class NotLoggedMapViewModel {
    private let disposeBag = DisposeBag()
    private var monuments: Variable<[Monument]> = Variable([])
    var monumentsObservable: Observable<[Monument]> {
        return monuments.asObservable()
    }

    init() {
        loadMonuments()
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
                print(self.monuments.value)
            case .error(_):
                print("error")
                break
            }
        }.disposed(by: disposeBag)
    }

    var onLoginSelected: () -> () = {
    }
}
