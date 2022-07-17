//  Created by Alexander Skorulis on 3/10/21.

import Foundation
import SwiftUI

public struct NavigationHelper {
    
    public static func invisible<V, D: View>(selection: Binding<V?>, destination: @escaping (V) -> D) -> some View {
        let activeBinding = Binding<Bool> {
            return selection.wrappedValue != nil
        } set: { value in
            if !value {
                selection.wrappedValue = nil
            }
        }
        
        let dest = Wrapper(selection: selection, destination: destination)
            .environment(\.as_presentation, Presentation(activeBinding: activeBinding))

        return NavigationLink("", destination: dest, isActive: activeBinding)
            .hidden()
    }
    
    public static func invisible<D: View>(selection: Binding<Bool>, destination: @escaping () -> D) -> some View {
        let dest = BoolWrapper(selection: selection, destination: destination)
            .environment(\.as_presentation, Presentation(activeBinding: selection))

        return NavigationLink("", destination: dest, isActive: selection)
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
    
    struct BoolWrapper<D: View>: View {
        
        @Binding var selection: Bool
        var builder: () -> D
        
        init(selection: Binding<Bool>, destination: @escaping () -> D) {
            _selection = selection
            self.builder = destination
        }
        
        var body: some View {
            if selection {
                builder()
            }
        }
    }
}

public extension NavigationHelper {
    
    struct Presentation {
        let activeBinding: Binding<Bool>
        
        static var empty: Presentation {
            return Presentation(activeBinding: .constant(false))
        }
        
        public func dismiss() {
            activeBinding.wrappedValue = false
        }
    }
    
}

// MARK: - Environment key

public struct InvisibleNavigationPresentation: EnvironmentKey {
    public static let defaultValue = NavigationHelper.Presentation.empty
}

public extension EnvironmentValues {
  var as_presentation: NavigationHelper.Presentation {
    get { self[InvisibleNavigationPresentation.self] }
    set { self[InvisibleNavigationPresentation.self] = newValue }
  }
}
