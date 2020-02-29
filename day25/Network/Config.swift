//
//  Config.swift
//  day25
//
//  Created by Abdullah Ayyad on 19/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import Foundation
class Config {
    
    static let BASE_URL :String = "http://sadeemapp.com/"
    
    //sub domain
    static let MAIN :String = Config.BASE_URL + "?json=get_main_screen"
    static let LOGIN :String = Config.BASE_URL + "?json=do_login"
    static let REGIESTER :String = Config.BASE_URL + "?json=do_register"
    static let FAV :String = Config.BASE_URL + "?json=getFavourite"
    static let DETAILS :String = Config.BASE_URL + "?json=get_recipe_details&id=93"
}
