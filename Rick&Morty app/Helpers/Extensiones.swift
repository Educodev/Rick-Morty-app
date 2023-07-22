//
//  Extenciones.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 20/7/23.
//

import SwiftUI

extension Color {
    static func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}
