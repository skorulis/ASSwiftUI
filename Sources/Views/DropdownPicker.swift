//
//  DropdownPicker.swift
//  
//
//  Created by Alexander Skorulis on 24/12/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct DropdownPicker<T: Identifiable, RowType: View> where T: Titleable {
    
    private let label: String
    @Binding private var selection: T?
    private let options: [T]
    private let row: (T) -> RowType
    
    @State private var isPresenting: Bool = false
    @State private var optionsSize: CGSize = .zero
    
    public init(label: String,
                selection: Binding<T?>,
                options: [T],
                row: @escaping (T) -> RowType
    ) {
        self.label = label
        _selection = selection
        self.options = options
        self.row = row
    }
    
}

// MARK: - Rendering

extension DropdownPicker: View {
    
    public var body: some View {
        DropdownButton(label: label, value: selection?.title, isOpen: isPresenting)
            .onTapGesture {
                isPresenting = true
            }
            .customModal(isPresented: $isPresenting) {
                overlay
            }
            
    }
    
    private var overlay: some View {
        ZStack {
            
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresenting = false
                }
            picker
        }
    }
    
    private var picker: some View {
        VStack(spacing: 0) {
            DropdownButton(label: label, value: selection?.title, isOpen: true)
                .onTapGesture {
                    isPresenting = false
                }
            
            optionList
                .padding(.vertical, 4)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: CornerSize.medium))
        .padding(.horizontal, 16)
    }
    
    private var optionList: some View {
        VStack(spacing: 4) {
            ForEach(options) { item in
                Button(action: { selected(item) }) {
                    row(item)
                }
            }
        }
    }
    
    private var optionListContainer: some View {
        ScrollView {
            ChildSizeReader(size: $optionsSize) {
                optionList
            }
        }
        .frame(height: maxHeight)
    }
    
}

// MARK: - Logic

private extension DropdownPicker {
    
    var maxHeight: CGFloat {
        return min(optionsSize.height, UIScreen.main.bounds.size.height)
    }
    
}

// MARK: - Behaviors

private extension DropdownPicker {
 
    func selected(_ option: T) {
        selection = option
        self.isPresenting = false
    }
    
}


// MARK: - Previews

struct DropdownPicker_Previews: PreviewProvider {
    
    private struct Item: Identifiable, Titleable {
        let text: String
        
        var id: String { text }
        var title: String { text }
    }
    
    static var previews: some View {
        let options: [Item] = [
            Item(text: "Hello"),
            Item(text: "Work damn you"),
            Item(text: "Hooray"),
            Item(text: "More stuff")
        ]
        
        StatefulPreviewWrapper(nil as Item?) { selection in
            StatefulPreviewWrapper(false) { isOpen in
                VStack {
                    DropdownPicker(
                        label: "Dropdown",
                        selection: selection,
                        options: options
                    ) { item in
                        Text("\(item.text)")
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

