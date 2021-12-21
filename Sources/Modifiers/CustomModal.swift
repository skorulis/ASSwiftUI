//
//  CustomModal.swift
//  
//
//  Created by Alexander Skorulis on 21/12/21.
//

import Foundation
import Introspect
import SwiftUI
import UIKit

// MARK: - Memory footprint

public struct CustomModal<Modal: View> {
 
    @Binding var isPresented: Bool
    let modal: Modal
    
    @State private var viewController: WeakWrapper<UIViewController>?
    
    public init(isPresented: Binding<Bool>,
                @ViewBuilder modal: () -> Modal
    ) {
        _isPresented = isPresented
        self.modal = modal()
    }
    
}

// MARK: - Rendering

extension CustomModal: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .introspectViewController { vc in
                self.viewController = WeakWrapper(vc)
            }
            .onChange(of: isPresented) { presented in
                if presented {
                    present()
                } else {
                    dismiss()
                }
            }
    }
}

// MARK: - Behaviors

private extension CustomModal {
    
    func present() {
        let modalVC = UIHostingController(rootView: modal)
        modalVC.modalPresentationStyle = .overFullScreen
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.view.backgroundColor = .clear
        viewController?.value?.present(modalVC, animated: true)
    }
    
    func dismiss() {
        viewController?.value?.dismiss(animated: true)
    }
    
}

// MARK: - View extensions

public extension View {
    
    func customModal<Modal: View>(isPresented: Binding<Bool>,
                                @ViewBuilder modal: () -> Modal
    ) -> some View {
        modifier(CustomModal(isPresented: isPresented, modal: modal))
    }
    
}

// MARK: - Previews

struct CustomModal_Previews: PreviewProvider {
    
    static var previews: some View {
        StatefulPreviewWrapper(false) { presented in
            VStack {
                Text("Content")
                Button(action: { presented.wrappedValue = true}) {
                    Text("Show")
                }
            }
            .customModal(isPresented: presented) {
                ZStack {
                    Color.black.opacity(0.5)
                        .onTapGesture {
                            presented.wrappedValue = false
                        }
                    Text("Modal")
                        .padding(20)
                        .background(Color.white)
                }
            }
                
        }
        
    }
}

