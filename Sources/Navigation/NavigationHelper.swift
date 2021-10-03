//  Created by Alexander Skorulis on 3/10/21.

import Foundation
import SwiftUI

public struct NavigationHelper {
    
    public static func invisible<V, D: View>(selection: Binding<V?>, destination: @escaping (V) -> D) -> some View {
        let activeBinding = Binding {
            return selection.wrappedValue != nil
        } set: { value in
            if !value {
                selection.wrappedValue = nil
            }
        }
        
        let dest = Wrapper(selection: selection, destination: destination)

        return NavigationLink("", destination: dest, isActive: activeBinding)
            .hidden()
    }
    
}

// MARK: - Inner types

private extension NavigationHelper {
    
    struct Wrapper<V, D: View>: View {
        
        @Binding var selection: V?
        var builder: (V) -> D
        
        init(selection: Binding<V?>, destination: @escaping (V) -> D) {
            _selection = selection
            self.builder = destination
        }
        
        var body: some View {
            if let value = selection {
                builder(value)
            }
        }
        
        
    }
}
