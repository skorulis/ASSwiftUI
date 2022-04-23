//
//  HorizontalAxis.swift
//  Crypto
//
//  Created by Alexander Skorulis on 18/5/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct HorizontalAxis {
    
    @Environment(\.xScale) var xScale
    
    let ticks: Int
    var formatValue: ((CGFloat) -> String)?
    
    init(ticks: Int, formatValue: ((CGFloat) -> String)? = nil) {
        self.ticks = ticks
        self.formatValue = formatValue
    }
}

// MARK: - Rendering

extension HorizontalAxis: View {
    
    public var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(0..<ticks+1) { tick in
                    Text(text(tick: tick))
                        .offset(x: xPosition(tick: tick))
                }
            }
        }
    }
    
    private func text(tick: Int) -> String {
        let value = xValue(tick: tick)
        if let format = formatValue {
            return format(value)
        } else {
            return "\(value)"
        }
    }
    
    private func xPosition(tick: Int) -> CGFloat {
        let fraction = CGFloat(tick)/CGFloat(ticks)
        return fraction * xScale.displaySize
    }
    
    private func xValue(tick: Int) -> CGFloat {
        return xScale.fromView(v: xPosition(tick: tick))
    }
}

// MARK: - Previews

struct HorizontalAxis_Previews: PreviewProvider {
    
    static var previews: some View {
        let axes = ChartViewScale.xyAxis(points: ChartViewLine_Previews.testPoints)
        GeometryReader { proxy in
            HorizontalAxis(ticks: 5)
                .environment(\.xScale, axes.yAxis.bind(displaySize: proxy.size.height, zoom: .init()))
        }
        
    }
}

