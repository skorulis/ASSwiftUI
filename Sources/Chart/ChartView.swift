//
//  ChartView.swift
//  Crypto
//
//  Created by Alexander Skorulis on 17/5/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct ChartView {
    
    private let xScale: ChartViewScale
    private let yScale: ChartViewScale
    private var elements: [AnyView]
    
    private let xZoom: ChartZoomLevel
    private let yZoom: ChartZoomLevel
    
    public init(
        xScale: ChartViewScale,
        yScale: ChartViewScale,
        elements: [AnyView] = [],
        xZoom: ChartZoomLevel = .init(),
        yZoom: ChartZoomLevel = .init()
    ) {
        self.xScale = xScale
        self.yScale = yScale
        self.xZoom = xZoom
        self.yZoom = yZoom
        self.elements = elements
    }
    
}

// MARK: - Rendering

extension ChartView: View {
    
    public var body: some View {
        GeometryReader { proxy in
            ForEach(Array(elements.indices), id: \.self) { index in
                elements[index]
            }
            .environment(\.xScale,
                         xScale.bind(displaySize: proxy.size.width, zoom: xZoom))
            .environment(\.yScale,
                         yScale.bind(displaySize: proxy.size.height, zoom: yZoom).invert())
        }
        .clipped()
    }
   
}

extension ChartView {
    
    func line(points: [CGPoint]) -> ChartView {
        var chart = self
        chart.elements.append(AnyView(ChartViewLine(points: points)))
        return chart
    }
    
    func add<T: View>(_ view: T) -> ChartView {
        return ChartView(
            xScale: xScale,
            yScale: yScale,
            elements: elements + [AnyView(view)],
            xZoom: xZoom,
            yZoom: yZoom
        )
    }
    
}

// MARK: - Environment variables

private struct ChartXScaleKey: EnvironmentKey {
    static let defaultValue = ChartViewBoundScale.def
}

private struct ChartYScaleKey: EnvironmentKey {
    static let defaultValue = ChartViewBoundScale.def
}

public extension EnvironmentValues {
    var xScale: ChartViewBoundScale {
        get { self[ChartXScaleKey.self] }
        set { self[ChartXScaleKey.self] = newValue }
    }
}

public extension EnvironmentValues {
    var yScale: ChartViewBoundScale {
        get { self[ChartYScaleKey.self] }
        set { self[ChartYScaleKey.self] = newValue }
    }
}

// MARK: - Previews

struct ChartView_Previews: PreviewProvider {
    
    static var previews: some View {
        let xScale = ChartViewScale(min: 0, max: 10)
        let yScale = ChartViewScale(min: 20, max: 50)
        
        ChartView(xScale: xScale, yScale: yScale)
            .line(points: [
                CGPoint(x: 1, y: 1),
                CGPoint(x: 2, y: 3),
                CGPoint(x: 3, y: 1),
                CGPoint(x: 4, y: 4),
                CGPoint(x: 5, y: 2)
            ])
    }
}

