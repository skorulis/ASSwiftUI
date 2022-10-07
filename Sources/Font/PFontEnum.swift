//  Created by Alexander Skorulis on 7/10/2022.

import Foundation

/// An enumeration for a font
public protocol PFontEnum: CaseIterable {
    
    /// Name of the font
    var name: String { get }
    
    /// File extension
    var ext: String { get }
    
}
