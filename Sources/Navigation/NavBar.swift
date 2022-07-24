//  Created by Alexander Skorulis on 24/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct NavBar<Left: View, Mid: View, Right: View> {
    
    private let left: Left
    private let mid: Mid
    private let right: Right
    
    public init(left: Left, mid: Mid, right: Right) {
        self.left = left
        self.mid = mid
        self.right = right
    }
}

extension NavBar where Mid == EmptyView, Right == EmptyView {
    
    public init(left: Left) {
        self.init(left: left, mid: EmptyView(), right: EmptyView())
    }
}

extension NavBar where Right == EmptyView {
    
    public init(left: Left, mid: Mid) {
        self.init(left: left, mid: mid, right: EmptyView())
    }
}

// MARK: - Rendering

extension NavBar: View {
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            items
                .frame(height: 44)
            Divider()
        }
    }
    
    private var items: some View {
        HStack {
            self.left
            Spacer()
            self.mid
            Spacer()
            self.right
            
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Previews

struct NavBar_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            NavBar(left: BarButtonItem.back({}))
            
            NavBar(left: BarButtonItem.back({}), mid: Text("Center me here"))
            
            NavBar(left: BarButtonItem.back({}),
                   mid: Text("Center me here").multilineTextAlignment(.center),
                   right: BarButtonItem.back({}))
            
            NavBar(left: BarButtonItem.back({}),
                   mid: Text("Center me here").multilineTextAlignment(.center),
                   right: Text("Right text"))
            Spacer()
        }
        
    }
}

