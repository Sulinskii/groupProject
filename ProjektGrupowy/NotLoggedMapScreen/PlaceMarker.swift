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
    init(coordinates: Coordinate){
        super.init()
        let coordinates = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        self.position = coordinates
    }

}
