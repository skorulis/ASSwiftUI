//
//  FlatButtonStyle.swift
//  
//
//  Created by Alexander Skorulis on 3/10/21.
//

import SwiftUI

public struct FlatButtonStyle {
    
    private let flavor: Flavor
    private let size: Size
    
    public init(_ flavor: Flavor, _ size: Size) {
        self.flavor = flavor
        self.size = size
    }
}

extension FlatButtonStyle: ButtonStyle {
    
    @ViewBuilder
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, size.padding)
            .frame(height: size.height)
            .background(backgroundColor(config: configuration))
            .foregroundColor(flavor.foregroundColor)
    }
    
    private func backgroundColor(config: Configuration) -> Color {
        if config.isPressed {
            return flavor.pressColor
        } else {
            return flavor.normalColor
        }
    }

    
}

// MARK: - Inner types

public extension FlatButtonStyle {
    
    enum Size {
        case small
        case medium
        case large
        
        fileprivate var height: CGFloat {
            switch self {
            case .small: return 32
            case .medium: return 44
            case .large: return 60
            }
        }
        
        fileprivate var padding: CGFloat {
            switch self {
            case .small: return 16
            case .medium: return 16
            case .large: return 32
            }
        }
            
    }
    
    enum Flavor {
        case danger
        case success
        
        fileprivate var normalColor: Color {
            switch self {
            case .danger: return .danger500
            case .success: return .success500
            }
        }
        
        fileprivate var pressColor: Color {
            switch self {
            case .danger: return .danger300
            case .success: return .success300
            }
        }
        
        fileprivate var foregroundColor: Color {
            switch self {
            case .danger: return .white
            case .success: return .white
            }
        }
    }
    
}

// MARK: - Previewss

struct FlatButtonStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            Button(action: {}) {
                Text("Small")
                    .bold()
            }
            .buttonStyle(FlatButtonStyle(.success, .small))
            
            Button(action: {}) {
                Text("Medium")
                    .bold()
            }
            .buttonStyle(FlatButtonStyle(.success, .medium))
            
            Button(action: {}) {
                Text("Large")
                    .bold()
            }
            .buttonStyle(FlatButtonStyle(.success, .large))
            
            Button(action: {}) {
                Text("Danger")
                    .bold()
            }
            .buttonStyle(FlatButtonStyle(.danger, .large))
        }
        .padding()
    }
}
