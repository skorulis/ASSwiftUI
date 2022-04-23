//
//  ChartZoomView.swift
//  CryptoTests
//
//  Created by Alexander Skorulis on 28/5/21.
//

import Foundation

import SwiftUI

// MARK: - Memory footprint

public struct ChartZoomView {
    
    @State private var finalDrag: CGSize = .zero
    @State private var finalZoom: CGFloat = 1
    
    @Binding var xZoom: ChartZoomLevel
    @Binding var yZoom: ChartZoomLevel
    
    @State var offset = CGSize.zero
    
}

// MARK: - Rendering

extension ChartZoomView: View {
    
    public var body: some View {
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { value in
                xZoom.offset = finalDrag.width + value.translation.width
                yZoom.offset = finalDrag.height + value.translation.height
            }
            .onEnded { (value) in
                finalDrag = CGSize(width: xZoom.offset, height: yZoom.offset)
            }
        
        let pinchGesture = MagnificationGesture()
            .onChanged { (value) in
                xZoom.zoom = max(value * finalZoom, 1)
                yZoom.zoom = max(value * finalZoom, 1)
            }
            .onEnded { (value) in
                finalZoom = xZoom.zoom
            }
        
        Color.clear
            .allowsHitTesting(true)
            .contentShape(Rectangle())
            .gesture(dragGesture)
            .gesture(pinchGesture)
            .onChange(of: xZoom) { newValue in
                if newValue.offset == .zero && newValue.zoom == 1 {
                    finalDrag = .zero
                    finalZoom = 1
                }
            }
    }
    
}

// MARK: - Inner types

public struct ChartZoomLevel: Equatable {
    
    var offset: CGFloat = 0
    var zoom: CGFloat = 1
    
    public init() {
        
    }
    
    func toView(_ value: CGFloat) -> CGFloat {
        return value * zoom + offset
    }
    
    func fromView(_ value: CGFloat) -> CGFloat {
        return (value - offset) / zoom
    }
    
    public static func == (a: ChartZoomLevel, b: ChartZoomLevel) -> Bool {
        return a.offset == b.offset && a.zoom == b.zoom
    }
}

// MARK: - Previews

struct ChartZoomView_Previews: PreviewProvider {
    
    static var previews: some View {
        StatefulPreviewWrapper(ChartZoomLevel()) { (xZoom) in
            StatefulPreviewWrapper(ChartZoomLevel()) { (yZoom) in
                ZStack {
                    ChartZoomView(xZoom: xZoom, yZoom: yZoom)
                    Rectangle()
                        .frame(
                            width: 20 * xZoom.wrappedValue.zoom,
                            height: 20 * yZoom.wrappedValue.zoom
                        )
                        .offset(
                            x: xZoom.wrappedValue.offset,
                            y: yZoom.wrappedValue.offset
                        )
                }
            }
        }
    }
}

