import Foundation
import SwiftUI
@testable import ASSwiftUI
import XCTest

final class ColorExtensionTests: XCTestCase {
    
    func test_rgbConversion() {
        let rgba = Color.white.components
        
        XCTAssertEqual(rgba.0, 1, accuracy: 0.0001)
        XCTAssertEqual(rgba.1, 1, accuracy: 0.0001)
        XCTAssertEqual(rgba.2, 1, accuracy: 0.0001)
        XCTAssertEqual(rgba.3, 1)
    }
    
    func test_hexConversion() {
        let color = Color("#AABBCC")
        XCTAssertNotNil(color)
        
        XCTAssertEqual(color?.hexString, "#AABBCC")
    }
    
    func test_luminance() {
        XCTAssertEqual(Color.white.luminance, 1, accuracy: 0.00001)
        XCTAssertEqual(Color.black.luminance, 0)
    }
}
