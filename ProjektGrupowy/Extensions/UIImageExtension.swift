//
// Created by Artur Sulinski on 2019-02-02.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init!(identifier: ImageIdentifier) {
        self.init(named: identifier.rawValue)
    }
}
