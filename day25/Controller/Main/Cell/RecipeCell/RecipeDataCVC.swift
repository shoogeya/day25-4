//
//  RecipeDataCVC.swift
//  day25
//
//  Created by Abdullah Ayyad on 14/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit
import SDWebImage
class RecipeDataCVC: UICollectionViewCell {
    public static let identifier = "RecipeDataCVC"
    
    @IBOutlet weak var checkFav : UICheckBox!
    @IBOutlet weak var imageView : UIImageView!
    
    
    
    var recipe :Recipe? {
         didSet{
            checkFav.isChecked = recipe?.isFavourite ?? false
            imageView.sd_setImage(with: URL(string: recipe?.mainImage ?? ""), completed: nil)

          }
     }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    }
    
    
    
    @IBAction func favClick(_ sender :UICheckBox){
        
        if sender.isChecked {
        NotificationCenter.default.post(name: NSNotification.Name("addFav"), object: nil,userInfo: ["id_fav": recipe!.id.description ] )
        }else{
            NotificationCenter.default.post(name: NSNotification.Name("removeFav"), object: nil,userInfo: ["id_fav": recipe!.id.description ] )
        }
    }

}
