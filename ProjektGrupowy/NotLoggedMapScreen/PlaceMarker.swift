//
// Created by Artur Sulinski on 2019-02-03.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import MapKit
import GoogleMaps
import CoreLocation
import UIKit

class PlaceMarker: GMSMarker {
    var monument: Monument!

    init(monument: Monument){
        super.init()
        self.monument = monument
        let coordinates = CLLocationCoordinate2D(latitude: monument.coordinates.latitude, longitude: monument.coordinates.longitude)
        self.position = coordinates
    }

}
