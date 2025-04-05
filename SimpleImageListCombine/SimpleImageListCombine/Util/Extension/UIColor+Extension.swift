//
//  UIColor+Extension.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import UIKit

enum CustomColor: String {
    case background = "Background"
    case pink50 = "pink50"
    case pink100 = "pink100"
    case pink200 = "pink200"
    case pink300 = "pink300"
    case pink400 = "pink400"
    case pink500 = "pink500"
    case pink600 = "pink600"
    case pink700 = "pink700"
    case gray50 = "Gray50"
    case gray100 = "Gray100"
    case gray200 = "Gray200"
    case gray300 = "Gray300"
    case gray400 = "Gray400"
    case gray500 = "Gray500"
    case gray600 = "Gray600"
    case gray700 = "Gray700"
    case gray800 = "Gray800"
    case red = "SysRed"
    case blue = "SysBlue"
    case green = "SysGreen"
    case yellow = "SysYellow"
}

extension UIColor {
    static func customColor(_ name: CustomColor) -> UIColor {
        return UIColor(named: name.rawValue) ?? .clear
    }

    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
