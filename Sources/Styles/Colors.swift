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
    
    static let success100 = Color("Success100", bundle: .module)
    static let success300 = Color("Success300", bundle: .module)
    static let success500 = Color("Success500", bundle: .module)
    
    // MARK: - Danger
    
    static let danger100 = Color("Danger100", bundle: .module)
    static let danger300 = Color("Danger300", bundle: .module)
    static let danger500 = Color("Danger500", bundle: .module)
    
    // MARK: - Warning
    
    static let warning500 = Color("Warning500", bundle: .module)
    
    // MARK: - Neutrals
    
    static let neutral100 = Color("Neutral100", bundle: .module)
    static let neutral500 = Color("Neutral500", bundle: .module)
    static let neutral900 = Color("Neutral900", bundle: .module)
    
    
    static var darkShadow: Color { .neutral900.opacity(0.5) }
    static var lightShadow: Color { .neutral100.opacity(0.5) }
    
    
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
        VStack(spacing: 0) {
            row(.neutral100, "Neutral 100")
            row(.neutral500, "Neutral 500")
            row(.neutral900, "Neutral 900")
        }
    }
    
    private static var danger: some View {
        VStack(spacing: 0) {
            row(.danger100, "Danger 100")
            row(.danger300, "Danger 300")
            row(.danger500, "Danger 500")
        }
    }
    
    private static var success: some View {
        VStack(spacing: 0) {
            row(.success100, "Success 100")
            row(.success300, "Success 300")
            row(.success500, "Success 500")
        }
    }
    
    private static var primary: some View {
        VStack(spacing: 0) {
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

