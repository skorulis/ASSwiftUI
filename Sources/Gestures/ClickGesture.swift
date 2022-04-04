//
//  ClickGesture.swift
//  
//
//  Created by Alexander Skorulis on 4/4/2022.
//

import SwiftUI

public struct ClickGesture: UIViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)
    
    public init(tappedCallback: @escaping ((CGPoint) -> Void)) {
        self.tappedCallback = tappedCallback
    }

    public func makeUIView(context: UIViewRepresentableContext<ClickGesture>) -> UIView {
        let v = UIView(frame: .zero)
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        v.addGestureRecognizer(gesture)
        return v
    }

    public class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        @objc func tapped(gesture:UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point)
        }
    }

    public func makeCoordinator() -> ClickGesture.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }

    public func updateUIView(_ uiView: UIView,
                       context: UIViewRepresentableContext<ClickGesture>) {
    }

}
