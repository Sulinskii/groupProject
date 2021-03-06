//
// Created by Artur Sulinski on 2019-02-03.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

class AddMonumentViewModel {
    private var coordinates: CLLocationCoordinate2D!
    private var address: Address!
    private var name: String!
    private var function: String!
    private var monument: Monument!
    private var creationDone: String!
    private var archivalSource: String!
    private let disposeBag = DisposeBag()
    private var responseError: Variable<Bool> = Variable(false)
    var responseObservable: Observable<Bool> {
        return responseError.asObservable()
    }

    private var responseManageError: Variable<Bool> = Variable(false)
    var responseManageObservable: Observable<Bool> {
        return responseManageError.asObservable()
    }

    init(monument: Monument = Monument()){
        self.monument = monument
    }

//    private func createMonument(){
//        let newCoordinates = Coordinate(latitude: coordinates.latitude, longitude: coordinates.longitude)
//        monument = AddMonument(name: name, function: function, creationDone: creationDone, archivalSource: archivalSource, coordinates: newCoordinates, address: address)
//    }

    func getMonument() -> Monument{
        return monument
    }

    func addMonument(monument: AddMonument) {
        print(monument.address)
        print(monument.name)
        API.addMonument(monument: monument).execute().subscribe {
            [unowned self](event: SingleEvent<Monument>) in
            switch event {
            case .success(let response):
                self.responseError.value = false

            case .error(_):
                self.responseError.value = true
            }
        }.disposed(by: self.disposeBag)
    }

    func setMonumentActive(id: Int) {
        API.updateMonument(id: id).execute().subscribe {
            [unowned self](event: SingleEvent<Monument>) in
            switch event {
            case .success(let response):
                self.responseManageError.value = false
            case .error(_):
                self.responseManageError.value = true
            }
        }.disposed(by: self.disposeBag)
    }
}
