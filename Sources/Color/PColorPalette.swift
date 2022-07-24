//  Created by Alexander Skorulis on 24/7/2022.

import Foundation
import SwiftUI

/// Protocol for generating color palettes
public protocol PColorPalette {
    
    var color: Color { get }
    
}

public extension PColorPalette {
    
    static var stops: Int { 1000 }
    
    /// Generate a step between 0 and 1000.
    /// 500 is the base color, 0 is black and 1000 is white
    func step(_ number: Int) -> Color {
        precondition(number >= 0 && number <= Self.stops)
        let stopHalf = Self.stops / 2
        let base = self.color
        let (h, s, b, a) = base.hsba
        
        if number < stopHalf {
            let downPct = CGFloat(stopHalf - number) / CGFloat(stopHalf)
            let mov = b * downPct
            return base.darken(percentage: mov)
        } else if number > stopHalf {
            let upPct = CGFloat(number - stopHalf) / CGFloat(stopHalf)
            let brightnessChange = (1 - b) * upPct
            let satChange = -s * upPct
            let uiColor = UIColor(hue: h, saturation: s + satChange, brightness: b + brightnessChange, alpha: a)
            return Color(uiColor: uiColor)
        } else {
            return base
        }
    }
    
}
