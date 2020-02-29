//
//  File.swift
//  Wasfa
//
//  Created by Abdullah Ayyad on 2/14/19.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import Foundation

extension String {
  
    
    var isValidEamil :Bool {
        get{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        
        }
    }
    
    
    
    
    var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return NSAttributedString() }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return NSAttributedString()
            }
        }
    
    
    
        var htmlToString: String {
            return htmlToAttributedString?.string ?? ""
        }
    
}
