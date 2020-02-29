//
//  MyFavVC.swift
//  day25
//
//  Created by Abdullah Ayyad on 23/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit
import Alamofire

class MyFavVC: UIViewController {

    
    @IBOutlet weak var tv :UITableView!
    var favoratis = [Recipe]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        startRequestForFav()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func startRequestForFav(){
        let user = UserDefaultHelper.loadUser()
        var header = [String:String]()
        header["Authorization"] = "Bearer \(user?.token ?? "")"
        
        AF.request(Config.FAV,method:.get ,headers :HTTPHeaders(header) ).responseJSON { response in
                   debugPrint(response)
                   switch response.result {
                   case .success(let data):
                       let dic = data as! [String:Any]
                        
                       let status = dic["status"] as? Bool ?? false
                       if status {
                        let result = dic["results"] as! [[String:Any]]
 
                         let sliderData = try! JSONSerialization.data(withJSONObject: result, options: [])
                        self.favoratis = try! JSONDecoder().decode([Recipe].self, from: sliderData)

                        
                        self.tv.reloadData()
                         
                       }else{
                        let message = dic["message"] as? String ?? ""
                        print(message)
                    }
                    
                   case .failure(let error):
                       print(error.localizedDescription)
                       break
                   }
               }
    }
    
    
    
    
}



extension MyFavVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoratis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = favoratis[indexPath.row].title
        return cell
    }
    
    
}
