//
//  ChartViewScale.swift
//  Crypto
//
//  Created by Alexander Skorulis on 17/5/21.
//

import Foundation
import SwiftUI

///
public struct ChartViewScale {
    
    fileprivate let min: CGFloat
    fileprivate let max: CGFloat
    fileprivate let gap: CGFloat
    
    public init(min: CGFloat, max: CGFloat) {
        assert(max >= min, "Bad chart")
        self.min = min
        self.max = max
        self.gap = max - min
    }
    
    public init(from: [CGFloat]) {
        let m1 = from.min() ?? 0
        let m2 = from.max() ?? 0
        self.init(min: m1, max: m2)
    }
    
    func bind(displaySize: CGFloat,
              zoom: ChartZoomLevel
    ) -> ChartViewBoundScale {
        return ChartViewBoundScale(axis: self, displaySize: displaySize, zoom: zoom)
    }
    
    static func xyAxis(points: [CGPoint]) -> (xAxis: ChartViewScale, yAxis: ChartViewScale) {
        let xVals = points.map { $0.x }
        let yVals = points.map { $0.y }
        return (
            xAxis: ChartViewScale(from: xVals),
            yAxis: ChartViewScale(from: yVals)
            )
    }
}

/// An axis that is bound to a view frame
public struct ChartViewBoundScale {
    
    private let axis: ChartViewScale
    let displaySize: CGFloat
    let zoom: ChartZoomLevel
    let inverted: Bool
    
    init(axis: ChartViewScale,
        displaySize: CGFloat,
        zoom: ChartZoomLevel,
        inverted: Bool = false
    ) {
        self.axis = axis
        self.displaySize = displaySize
        self.zoom = zoom
        self.inverted = inverted
    }
    
    var offset: CGFloat {
        return zoom.offset
    }
    
    static var def: ChartViewBoundScale {
        let axis = ChartViewScale(min: 0, max: 10)
        return ChartViewBoundScale(
            axis: axis,
            displaySize: 100,
            zoom: ChartZoomLevel()
        )
    }
    
    public func toView(v: CGFloat) -> CGFloat {
        let pct = (v - axis.min) / axis.gap
        if inverted {
            return zoom.toView((1 - pct) * displaySize)
        } else {
            return zoom.toView(pct * displaySize)
        }
    }
    
    #warning("Not handling zooming yet")
    public func fromView(v: CGFloat) -> CGFloat {
        let pct = zoom.fromView(v) / displaySize
        if inverted {
            return axis.gap * (1 - pct) + axis.min
        } else {
            return axis.gap * pct + axis.min
        }
        
    }
    
    public func invert() -> ChartViewBoundScale {
        return ChartViewBoundScale(
            axis: axis,
            displaySize: displaySize,
            zoom: zoom,
            inverted: !inverted)
    }
    
}
