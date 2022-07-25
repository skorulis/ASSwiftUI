//  Created by Alexander Skorulis on 24/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public enum BarButtonItem {
    
    case back(_ action: (() -> Void)? = nil)
    case title(_ text: String)
    
}

// MARK: - Rendering

extension BarButtonItem: View {
    
    @ViewBuilder
    public var body: some View {
        switch self {
        case .back(let action):
            BackButton(action: action)
        case .title(let text):
            title(text)
        }
    }
    
    private func title(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.primary)
    }
}

// MARK: - Inner types

private extension BarButtonItem {
    
    struct BackButton: View {
        
        let action: (() -> Void)?
        @Environment(\.as_presentation) private var presentation
        
        init(action: (() -> Void)? ) {
            self.action = action
        }
        
        var body: some View {
            Button(action: back) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            }
            .frame(width: 40, height: 40)
        }
        
        private func back() {
            if let action = action {
                action()
            } else {
                presentation.dismiss()
            }
        }
    }
}

// MARK: - Previews

struct BarButtonItem_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            BarButtonItem.back({})
        }
        
    }
}

