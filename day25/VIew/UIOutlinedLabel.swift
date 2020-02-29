//
//  File.swift
//  Wasfaa
//
//  Created by Abdullah Ayyad on 1/26/19.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import Foundation
import UIKit

class UIOutlinedLabel: UILabel {
    
    var outlineWidth: CGFloat = 1
    var outlineColor: UIColor = UIColor.white
    
    override func drawText(in rect: CGRect) {
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : outlineColor,
            NSAttributedString.Key.strokeWidth : -1 * outlineWidth,
            ] as [NSAttributedString.Key : Any]
        
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
        super.drawText(in: rect)
    }
}
