//
//  UICheckBox.swift
//  SmartSafety
//
//  Created by Abdullah Ayyad on 07/09/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit


class UICheckBox: UIButton {
        // Images
      var checkedImageValue = UIImage(named: "ic_fav")!
      var uncheckedImageValue = UIImage(named: "ic_fav_uncheck")! as UIImage
    
    
    
    
    
    @IBInspectable var checkedImage :UIImage {
        get{
           return checkedImageValue
        }
        set{
            checkedImageValue = newValue
        }
    }
    
    
    @IBInspectable var uncheckedImage :UIImage {
        get{
            return uncheckedImageValue
        }
        set{
            uncheckedImageValue = newValue
        }
    }
    
    
    
    
        // Bool property
        var isChecked: Bool = false {
            didSet{
                if isChecked == true {
                    self.setImage(checkedImageValue, for: UIControl.State.normal)
                } else {
                    self.setImage(uncheckedImageValue, for: UIControl.State.normal)
                }
            }
        }
        
        override func awakeFromNib() {
            self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
            self.isChecked = false
  

        }
        
        @objc func buttonClicked(sender: UIButton) {
            if sender == self {
                isChecked = !isChecked
            }
        }
}
