//
//  NeumorphicFieldModifier.swift
//  
//
//  Created by Alexander Skorulis on 3/10/21.
//

import Foundation
import SwiftUI
import Neumorphic

// MARK: - Memory footprint

public struct NeumorphicFieldModifier {
    
    public init() {
        
    }
}

// MARK: - Rendering

extension NeumorphicFieldModifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .padding(10)
            .textFieldStyle(PlainTextFieldStyle())
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.neutral100)
                    .softOuterShadow(
                        darkShadow: .darkShadow,
                        lightShadow: .lightShadow,
                        offset: 1.0,
                        radius: 2
                    )
            )
            
            
    }
}

// MARK: - Previews

struct NeumorphicFieldModifier_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            TextField("TextField", text: .constant("Text"))
                .modifier(NeumorphicFieldModifier())
            
            TextField("TextField", text: .constant("Text"))
                .frame(height: 200)
                .modifier(NeumorphicFieldModifier())
            
            RoundedRectangle(cornerRadius: 10)
                .modifier(NeumorphicFieldModifier())
                
        }
        .padding(20)
        .background(Color.neutral100)
    }
}

