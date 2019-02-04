//
// Created by Artur Sulinski on 2019-02-03.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

class AddMonumentViewModel {
    private var coordinates: CLLocationCoordinate2D
    private var address: Address!
    private var name: String!
    private var function: String!
    private var creationDone: String!
    private var archivalSource: String!
    private var monument: Monument!
    private let disposeBag = DisposeBag()
    private var response: Variable<Bool> = Variable(false)
    var responseObservable: Observable<Bool> = {
        return response.asObservable()
    }

    init(coordinates: CLLocationCoordinate2D){
        self.coordinates = coordinates
    }

    private func createMonument(){
        let newCoordinates = Coordinate(latitude: coordinates.latitude, longitude: coordinates.longitude)
        monument = AddMonument(name: name, function: function, creationDone: creationDone, archivalSource: archivalSource, coordinates: newCoordinates, address: address)
    }

    func setAddress(address: Address){
        self.address = address
    }

    func setName(name: String){
        self.name = name
    }

    func setFunction(function: String){
        self.function = function
    }

    func setCreationDone(creationDone: String){
        self.creationDone = creationDone
    }

    func setArchivalSource(archivalSource: String){
        self.archivalSource = archivalSource
    }

    func addMonument(monument: AddMonument) {
        API.addMonument(monument: monument).execute().subscribe {
            [unowned self](event: SingleEvent<User>) in
            switch event {
            case .success(let response):
                self.response.value = true
            case .error(_):
                self.response.value = false


            }
        }.disposed(by: self.disposeBag)
    }
}
