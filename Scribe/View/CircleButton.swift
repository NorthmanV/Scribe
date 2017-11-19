//
//  CircleButton.swift
//  Scribe
//
//  Created by Руслан Акберов on 19.11.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit

@IBDesignable class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}
