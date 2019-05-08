//
//  ColorPicker.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/8/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit


struct ColorPicker {
    func colorPicker(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let myColor = UIColor(displayP3Red: r/255, green: g/255, blue: b/255, alpha: 1.0)
        return myColor
    }
}
