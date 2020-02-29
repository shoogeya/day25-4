//
//  RecipeTVC.swift
//  day25
//
//  Created by Abdullah Ayyad on 14/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeTVC: UITableViewCell {

    //0 news //1 Recipe
    var index = -1
    
    @IBOutlet weak var lbl :UILabel!
    @IBOutlet weak var cv :UICollectionView!

    
    var news = [News]() {
        didSet{
            cv.reloadData()
        }
    }
    
    
    var filterNews :[News]{
        get{
            return news.filter { (news) -> Bool in
                news.mainImage != nil
            }
        }
    }
    
    
    
    
    var recipes = [Recipe](){
        didSet{
                  cv.reloadData()

            }
        }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerNibCell()
        
        cv.dataSource = self
    }
    
    
    func registerNibCell(){
        let nib = UINib(nibName: RecipeDataCVC.identifier, bundle: nil)

        cv.register(nib, forCellWithReuseIdentifier: RecipeDataCVC.identifier)
        
        
        let nib2 = UINib(nibName: NewsDataCVC.identifier, bundle: nil)

        cv.register(nib2, forCellWithReuseIdentifier: NewsDataCVC.identifier)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RecipeTVC :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if index == 0 {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDataCVC.identifier, for: indexPath) as! NewsDataCVC
        
        let new = filterNews[indexPath.row]
        
        cell.imageView.sd_setImage(with: URL(string: new.mainImage ?? ""), completed: nil)
        return cell
            
            
            
        }else{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDataCVC.identifier, for: indexPath) as! RecipeDataCVC
            
            let recipe = recipes[indexPath.row]
            cell.recipe = recipe
 
            return cell
                
                
        }
    }
    
    
}
