//
//  Extensions.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit


// Settings
let windowWidth = UIScreen.main.bounds.width
let windowHeight = UIScreen.main.bounds.height

let heroColor = UIColor.fromRGB(0x487b8e)
let offGrey = UIColor.fromRGB(0xf4f4f4)
let ashGrey = UIColor.fromRGB(0x555555)
let borderGrey = UIColor.fromRGB(0xdfdedf)

let transparent = UIColor.black.withAlphaComponent(0)
let halfTransparent = UIColor.black.withAlphaComponent(0.5)
let mostlyTransparent = UIColor.black.withAlphaComponent(0.3)

// ====================================================================
//
// EXTENSION - UIColor
//
// ====================================================================
extension UIColor {
    static func fromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
