//
//  AppColors.swift
//  ApiDemoSwiftUI
//
//  Created by Chetan Hedamba on 07/01/25.
//

import Foundation
import SwiftUI

struct AppColors {
//    static let primary = Color("Primary") // Color from Assets
//    static let secondary = Color("Secondary") // Color from Assets
//    static let background = Color("Background") // Color from Assets
    
    // Directly defined colors
//    static let black = Color.black
//    static let white = Color.white
//    static let customGray = Color(red: 0.9, green: 0.9, blue: 0.9)
    static let primary = Color(hex: "#C67C4E") // Using a custom hex initializer
    static let secondary = Color(hex: "#EDD6C8")
    static let secondaryLight = Color(hex: "#F9F2ED")
    static let black = Color(hex: "#313131")
    static let gray = Color(hex: "#E3E3E3")
}

// Optional: Add an initializer for Hex colors
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // Remove the `#` if present
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
