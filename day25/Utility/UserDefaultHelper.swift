//
//  UserDefaultHelper.swift
//  day25
//
//  Created by Abdullah Ayyad on 19/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import Foundation
import UIKit
class UserDefaultHelper{
    
    
    static func isLogin()->Bool{
        return loadUser() != nil
    }
    
    //save user defalt
    
    static func saveUser(user :User){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            UserDefaults.standard.set(encoded, forKey: "user")
        }
    }
    
    
    static func loadUser() -> User?{
          if let userData = UserDefaults.standard.object(forKey: "user") as? Data {
              let decoder = JSONDecoder()
              if let loadedPerson = try? decoder.decode(User.self, from: userData) {
                  return loadedPerson
              }
          }
        
        return nil
      }
      
}
