//
//  LeftMenuVC.swift
//  day25
//
//  Created by Abdullah Ayyad on 23/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit

class LeftMenuVC: UIViewController {

    
    @IBOutlet weak var imgProfile :UIImageView!
    @IBOutlet weak var usernameLbl  :UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        guard let user = UserDefaultHelper.loadUser() else{
            return
        }
        
        imgProfile.sd_setImage(with: URL(string: user.image!)!, completed: nil)
        
        usernameLbl.text = user.name
    }

    
    
    @IBAction func showFav(_ sender :UIButton){
        if UserDefaultHelper.isLogin() {
            //go to fave]
            let vc = self.storyboard!.instantiateViewController(identifier: "MyFavVC")
                 self.present(vc, animated: true)
        }else{
            openSignInVC()
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
