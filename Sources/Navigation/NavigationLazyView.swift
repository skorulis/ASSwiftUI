//
//  NavigationLazyView.swift
//  Crypto
//
//  Created by Alexander Skorulis on 15/5/21.
//

import SwiftUI

public struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}
