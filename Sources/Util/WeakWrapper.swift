//
//  WeakWrapper.swift
//  
//
//  Created by Alexander Skorulis on 21/12/21.
//

import Foundation

public final class WeakWrapper<T: AnyObject> {
    
    weak var value: T?
    
    public init(_ value: T?) {
        self.value = value
    }
}
