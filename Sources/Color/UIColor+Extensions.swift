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
    
    var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard getRed(&r, green: &g, blue: &b, alpha: &a) else {
            fatalError("Could not get RGBA")
        }
        return (r, g, b, a)
    }
    
    var brightness: CGFloat {
        return hsba.2
    }
    
    var saturation: CGFloat {
        return hsba.1
    }
    
    func darken(percentage: CGFloat) -> UIColor {
        assert(percentage >= 0, "Percentage must be positive")
        return adjust(percentage: -percentage)
    }
    
    func lighten(percentage: CGFloat) -> UIColor {
        assert(percentage >= 0, "Percentage must be positive")
        return adjust(percentage: percentage)
    }
    
    func mix(other: UIColor, pct: CGFloat) -> UIColor {
        let (r1, g1, b1, a1) = rgba
        let (r2, g2, b2, a2) = other.rgba
        let pI = 1 - pct
        
        let r = r1 * pI + r2 * pct
        let g = g1 * pI + g2 * pct
        let b = b1 * pI + b2 * pct
        let a = a1 * pI + a2 * pct
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    private func adjust(percentage: CGFloat) -> UIColor {
        var (h, s, b, a) = hsba
        b = min(max(b + percentage, 0), 1);
        return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    
}
