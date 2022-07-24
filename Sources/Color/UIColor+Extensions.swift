//  Created by Alexander Skorulis on 24/7/2022.

import Foundation
import UIKit

extension UIColor {
    
    var hsba: (CGFloat, CGFloat, CGFloat, CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else {
            fatalError("Could not get hue")
        }
        return (h,s,b,a)
    }
    
    var brightness: CGFloat {
        return hsba.2
    }
    
    var saturation: CGFloat {
        return hsba.1
    }
    
    func darken(percentage: CGFloat) -> UIColor {
        assert(percentage > 0, "Percentage must be positive")
        return adjust(percentage: -percentage)
    }
    
    func lighten(percentage: CGFloat) -> UIColor {
        assert(percentage > 0, "Percentage must be positive")
        return adjust(percentage: percentage)
    }
    
    private func adjust(percentage: CGFloat) -> UIColor {
        var (h, s, b, a) = hsba
        b = min(max(b + percentage, 0), 1);
        return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    
}
