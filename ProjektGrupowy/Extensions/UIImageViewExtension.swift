//
// Created by Artur Sulinski on 2019-02-02.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    convenience init(imageIdentifier: ImageIdentifier) {
        let image = UIImage(identifier: imageIdentifier)
        self.init(image: image)
    }
}
