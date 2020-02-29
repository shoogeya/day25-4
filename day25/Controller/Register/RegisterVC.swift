//
//  LoginVC.swift
//  day25
//
//  Created by Abdullah Ayyad on 19/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit
import Alamofire
class RegisterVC: UIViewController {

    
//    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var imgProfile : UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageClick(_ sender: Any) {
        openGallary()
    }
    
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func openGallary(){
        let gallaryVC = UIImagePickerController()
        gallaryVC.sourceType = .photoLibrary
        gallaryVC.delegate = self
        
        present(gallaryVC, animated: true, completion: nil)
    }
    
    @IBAction func startRegister(_ sender :UIButton){
    
        let imageData:Data = (imgProfile.image?.jpegData(compressionQuality: 0.3))!
        
        
        let encodeBase64 :String = imageData.base64EncodedString()
        
        print("data:image/jpeg;base64,\(encodeBase64)")
        
        startRigisterRequest(image :encodeBase64)

    }
    
    
    func startRigisterRequest(image: String){
        var params = [String:String]()
        params["username"] = "Abedalla Ayyad"
        params["email"] = "myMail@gmail.com"
        params["password"] = "123456"
        params["confirm_password"] = "123456"
        params["image"] = image

        AF.request(Config.REGIESTER,method:.post, parameters : params,encoder:JSONParameterEncoder.default).responseJSON { response in
                        debugPrint(response)
                        switch response.result {
                        case .success(let data):
                            let dic = data as! [String:Any]
                            let status = dic["status"] as? Bool ?? false
                            if status {
                                
                                
                            let userData = try! JSONSerialization.data(withJSONObject: dic["results"], options: [])
                            var user = try! JSONDecoder().decode(User.self, from: userData)
                                                       
                                
                                UserDefaultHelper.saveUser(user: user)
                    
                                
                                self.showAlert(title: "", message: "تم تسجيل الدخول")

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



extension RegisterVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil  )
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard var image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        
        
        imgProfile.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
