//  Created by Alexander Skorulis on 24/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public enum BarButtonItem {
    
    case back(_ action: () -> Void)
    
}

// MARK: - Rendering

extension BarButtonItem: View {
    
    @ViewBuilder
    public var body: some View {
        switch self {
        case .back(let action):
            backButton(action)
        }
    }
    
    private func backButton(_ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.black)
        }
        .frame(width: 40, height: 40)
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

