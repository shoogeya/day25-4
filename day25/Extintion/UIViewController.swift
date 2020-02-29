//
//  UIViewController.swift
//  Wasfa
//
//  Created by Abdullah Ayyad on 2/12/19.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    
    
    
    func showAlert(title :String , message :String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            print("button cancel pressed")
        }))
        
         
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            print("button cancel pressed")
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openSignInVC(){
        let vc  = self.storyboard!.instantiateViewController(identifier: "LoginVC")
        
        self.present(vc, animated: true){
            print("from closures")
        }
    }
}
 
