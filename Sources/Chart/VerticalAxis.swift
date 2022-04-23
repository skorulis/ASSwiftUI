//
//  VerticalAxis.swift
//  Crypto
//
//  Created by Alexander Skorulis on 18/5/21.
//

import Foundation

import SwiftUI

// MARK: - Memory footprint

public struct VerticalAxis {
    
    @Environment(\.yScale) var yScale
    
    let ticks: Int
    var formatValue: ((CGFloat) -> String)?
    
    public init(ticks: Int, formatValue: ((CGFloat) -> String)? = nil) {
        self.ticks = ticks
        self.formatValue = formatValue
    }
    
}

// MARK: - Rendering

extension VerticalAxis: View {
    
    public var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                ForEach(0..<ticks) { tick in
                    Text(text(tick: tick))
                        .offset(y: yPosition(tick: tick))
                }
            }
            Spacer()
        }
    }
    
    private func text(tick: Int) -> String {
        let value = yValue(tick: tick)
        if let format = formatValue {
            return format(value)
        } else {
            return "\(value)"
        }
    }
    
    private func yPosition(tick: Int) -> CGFloat {
        let fraction = CGFloat(tick)/CGFloat(ticks)
        return fraction * yScale.displaySize
    }
    
    private func yValue(tick: Int) -> CGFloat {
        return yScale.fromView(v: yPosition(tick: tick))
    }
}

// MARK: - Previews

struct VerticalAxis_Previews: PreviewProvider {
    
    static var previews: some View {
        let axes = ChartViewScale.xyAxis(points: ChartViewLine_Previews.testPoints)
        GeometryReader { proxy in
            VerticalAxis(ticks: 5)
                .environment(\.yScale, axes.yAxis.bind(displaySize: proxy.size.height, zoom: .init()).invert())
        }
        
    }
}

