//
//  UIImageExtension.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import Foundation
import UIKit

extension UIImage {
    func createTabItemLabelFromImage() -> UIImage? {
        let imageSize = CGSize(width: 25, height: 25)
        
        return UIGraphicsImageRenderer(size: imageSize).image { context in
            let rect = CGRect(origin: .init(x: 0, y: 0), size: imageSize)
            let clipPath = UIBezierPath(ovalIn: rect)
            clipPath.addClip()
            self.draw(in: rect)
        }
        .withRenderingMode(.alwaysOriginal)
    }
}
