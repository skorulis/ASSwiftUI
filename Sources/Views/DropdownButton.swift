//
//  Dropdown.swift
//  
//
//  Created by Alexander Skorulis on 21/12/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct DropdownButton {
    
    private let label: String
    private let value: String?
    private var isOpen: Bool
    
    public init(label: String,
                value: String?,
                isOpen: Bool
    ) {
        self.label = label
        self.value = value
        self.isOpen = isOpen
    }
}

// MARK: - Rendering

extension DropdownButton: View {
    
    public var body: some View {
        button
            .contentShape(Rectangle())
    }
    
    private var button: some View {
        innerContent
            .padding(8)
            .background(maybeBorder)
    }
    
    private var innerContent: some View {
        HStack {
            if let value = value {
                Text(value)
                    .foregroundColor(Color.black)
            } else {
                Text(label)
                    .foregroundColor(Color.neutral500)
            }
            
            Spacer()
            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(isOpen ? 180 : 0))
                .animation(.easeInOut(duration: 0.2), value: isOpen)
        }
    }
    
    @ViewBuilder
    private var maybeBorder: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(Color.neutral500)
    }
}

// MARK: - Previews

struct DropdownButton_Previews: PreviewProvider {
    
    static var previews: some View {
        StatefulPreviewWrapper(false) { isOpen in
            VStack {
                DropdownButton(label: "Dropdown", value: nil, isOpen: isOpen.wrappedValue)
            }
            .padding(.horizontal, 16)
        }
    }
}

