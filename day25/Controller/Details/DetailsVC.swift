//
//  DetailsVC.swift
//  day25
//
//  Created by Abdullah Ayyad on 26/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit
import Alamofire
class DetailsVC: UIViewController {
    
    
    
    @IBOutlet weak var componentLbl :UILabel!
    @IBOutlet weak var descriptionLbl :UILabel!
    @IBOutlet weak var tv :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRequestForRecipeDetails(byId: 93)
        // Do any additional setup after loading the view.
 
    }
    
    
    
    
    func startRequestForRecipeDetails(byId id: Int){
        let user = UserDefaultHelper.loadUser()
        var header = [String:String]()
        header["Authorization"] = "Bearer \(user?.token ?? "")"
        AF.request("http://sadeemapp.com/?json=get_recipe_details&id=\(id)",method:.get ,headers :HTTPHeaders(header) ).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                let dic = data as! [String:Any]
                
                let status = dic["status"] as? Bool ?? false
                if status {
                    let result = dic["results"] as! [String:Any]
                    
                    let recipeData = try! JSONSerialization.data(withJSONObject: result, options: [])
                    var recipe = try! JSONDecoder().decode(Recipe.self, from: recipeData)
                    self.initRecipeRequest(recipe :recipe)
                    
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
    
    
    func initRecipeRequest(recipe :Recipe){
        //descriptionLbl.text =  recipe.content
        descriptionLbl.attributedText = recipe.content?.htmlToAttributedString
        descriptionLbl.font = UIFont(name: "system", size: 18)
        var data :String = ""
        
        recipe.components?.forEach({ (component) in
            data +=  component + "\n"
        })
        
        
        
        componentLbl.text = data
        
        tv.layoutIfNeeded()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let header = tv.tableHeaderView // 300 - 500
        
        let size  =  header?.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize) //300 , 700
        
        header?.frame.size.height = size!.height
        
        tv.tableHeaderView = header
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
