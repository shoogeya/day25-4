//
//  LoginVC.swift
//  day25
//
//  Created by Abdullah Ayyad on 19/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SVProgressHUD
class LoginVC: UIViewController {

    
    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.text = "myMail@gmail.com"
        passwordTF.text = "123456"
        // Do any additional setup after loading the view.

        print("viewDidLoad")

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    

    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func startLogin(_ sender :UIButton){
        MBProgressHUD.showAdded(to: sender, animated: true)

        if emailTF.text!.isEmpty ||  passwordTF.text!.isEmpty{
            //
            showAlert(title: "", message: "الرجاء ادخال اسم المستخدم وكلمة المرور بشكل صحيح")
        }else{
            startLoginRequest()

        }
        
    }
    
    
    func startLoginRequest(){
//        SVProgressHUD.show()
        var params = [String:String]()
        params["username"] = emailTF.text!
        params["password"] = passwordTF.text!

        AF.request(Config.LOGIN,method:.post, parameters : params,encoder:JSONParameterEncoder.default).responseJSON { response in
                        debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
//            SVProgressHUD.dismiss()

                        switch response.result {
                        case .success(let data):
                            let dic = data as! [String:Any]
                            let status = dic["status"] as? Bool ?? false
                            if status {
                                
                                
                            let userData = try! JSONSerialization.data(withJSONObject: dic["results"], options: [])
                            var user = try! JSONDecoder().decode(User.self, from: userData)
                                                       
                                
                                UserDefaultHelper.saveUser(user: user)
                    
                                
                                    //self.showAlert(title: "", message: "تم تسجيل الدخول")

                                self.dismiss(animated: true, completion: nil)
                            }else{
                             let message = dic["message"] as? String ?? ""
                                self.showAlert(title: "خطا", message: message)
                         }
                         
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.showAlert(title: "خطا", message: error.localizedDescription)

                            break
                        }
                    }
         
        
    }
    
}
