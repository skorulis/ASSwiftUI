//
//  ChartViewLine.swift
//  Crypto
//
//  Created by Alexander Skorulis on 17/5/21.
//

import Foundation
import SwiftUI

// Example of a line chart. May need to be removed
public struct ChartViewLine {
    
    private let points: [CGPoint]
    @Environment(\.xScale) var xScale
    @Environment(\.yScale) var yScale
    
    public init(points: [CGPoint]) {
        self.points = points
    }
    
}

// MARK: - Rendering

extension ChartViewLine: View {
    
    public var body: some View {
        var isFirst = true
        Path { path in
            path.move(to: .zero)
            for p in points {
                let x = xScale.toView(v: p.x)
                let y = yScale.toView(v: p.y)
                if isFirst {
                    path.move(to: CGPoint(x: x, y: y))
                    isFirst = false
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }   
            }
        }
        .stroke()
    }
}

struct ChartViewLine_Previews: PreviewProvider {
    
    static var testPoints: [CGPoint] {
        return [
            CGPoint(x: 0, y: 1),
            CGPoint(x: 1, y: 8),
            CGPoint(x: 4, y: 4),
            CGPoint(x: 5, y: 4),
            CGPoint(x: 8, y: 8),
        ]
    }
    
    static var previews: some View {
        let axes = ChartViewScale.xyAxis(points: testPoints)
        StatefulPreviewWrapper(ChartZoomLevel()) { (xZoom) in
            StatefulPreviewWrapper(ChartZoomLevel()) { (yZoom) in
                ZStack {
                    ChartView(
                        xScale: axes.xAxis,
                        yScale: axes.yAxis,
                        elements: [AnyView(ChartViewLine(points: testPoints))],
                        xZoom: xZoom.wrappedValue,
                        yZoom: yZoom.wrappedValue
                    )
                    
                    ChartZoomView(xZoom: xZoom, yZoom: yZoom)
                }
                
            }
        }
        
        
    }
}
