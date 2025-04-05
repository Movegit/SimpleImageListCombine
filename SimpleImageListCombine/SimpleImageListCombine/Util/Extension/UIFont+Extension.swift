//
//  UIFont+Extension.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import UIKit

enum CustomFont {
    case H1
    case H1_regular
    case H2
    case H3
    case Subtitle1
    case Subtitle2
    case Subtitle3
    case Body1
    case Body1_Bold
    case Body2
    case Body2_Bold
    case Caption1
    case Caption2
}

extension UIFont {
    static func customFont(_ name: CustomFont) -> UIFont {
        let (fontName, fontSize, weight) = fontProperties(for: name)
        return UIFont(name: fontName, size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }

    // swiftlint:disable:next cyclomatic_complexity large_tuple
    private static func fontProperties(for name: CustomFont) -> (String, CGFloat, UIFont.Weight) {
        switch name {
        case .H1:
            return ("AppleSDGothicNeo-Bold", 28, .bold)
        case .H1_regular:
            return ("AppleSDGothicNeo-Regular", 28, .regular)
        case .H2:
            return ("AppleSDGothicNeo-Bold", 24, .bold)
        case .H3:
            return ("AppleSDGothicNeo-Bold", 20, .bold)
        case .Subtitle1:
            return ("AppleSDGothicNeo-Bold", 18, .bold)
        case .Subtitle2:
            return ("AppleSDGothicNeo-Bold", 16, .bold)
        case .Subtitle3:
            return ("AppleSDGothicNeo-Bold", 14, .bold)
        case .Body1:
            return ("AppleSDGothicNeo-Regular", 16, .regular)
        case .Body1_Bold:
            return ("AppleSDGothicNeo-Bold", 16, .bold)
        case .Body2:
            return ("AppleSDGothicNeo-Regular", 14, .regular)
        case .Body2_Bold:
            return ("AppleSDGothicNeo-Bold", 14, .bold)
        case .Caption1:
            return ("AppleSDGothicNeo-Bold", 12, .bold)
        case .Caption2:
            return ("AppleSDGothicNeo-Light", 12, .light)
        }
    }
}
