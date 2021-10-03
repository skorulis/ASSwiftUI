//
//  Colors.swift
//  
//
//  Created by Alexander Skorulis on 3/10/21.
//

import SwiftUI

public extension Color {
    
    // MARK: - Primaries
    
    static let primary100 = Color("Primary100", bundle: .module)
    
    static let primary500 = Color("Primary500", bundle: .module)
    
    static let primary900 = Color("Primary900", bundle: .module)
    
    // MARK: - Success
    
    static let success500 = Color("Success500", bundle: .module)
    
    // MARK: - Danger
    
    static let danger500 = Color("Danger500", bundle: .module)
    
    // MARK: - Warning
    
    static let warning500 = Color("Warning500", bundle: .module)
    
    // MARK: - Neutrals
    
    static let neutral100 = Color("Neutral100", bundle: .module)
    
    
    
    
}

// MARK: - Previews

struct Colors_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            primary
            success
            danger
            neutral
            
        }
    }
    
    private static var neutral: some View {
        VStack {
            row(.neutral100, "Neutral 100")
        }
    }
    
    private static var danger: some View {
        VStack {
            row(.danger500, "Danger 500")
        }
    }
    
    private static var success: some View {
        VStack {
            row(.success500, "Success 500")
        }
    }
    
    private static var primary: some View {
        VStack {
            row(.primary100, "Primary 100")
            row(.primary500, "Primary 500")
            row(.primary900, "Primary 900")
        }
    }
    
    static func row(_ color: Color, _ name: String) -> some View {
        HStack {
            Text(name)
                .frame(width: 100, alignment: .leading)
                .padding()
            color
        }
        .frame(height: 40)
    }
}

