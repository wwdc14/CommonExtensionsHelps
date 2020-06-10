//
//  BundleExtenstions.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/5/9.
//  Copyright © 2020 Hy. All rights reserved.
//

import UIKit

extension Bundle {
    class func imagePickerControllerBundle() -> Bundle {
        let assetPath = Bundle(for: Console.self).resourcePath!
        return Bundle(path: (assetPath as NSString).appendingPathComponent("PhotosBundle.bundle"))!
    }
}
