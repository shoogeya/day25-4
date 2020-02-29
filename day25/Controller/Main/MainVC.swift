//
//  ViewController.swift
//  day25
//
//  Created by Abdullah Ayyad on 14/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import UIKit
import Alamofire
import ImageSlideshow
import MBProgressHUD
class MainVC: UIViewController {
    @IBOutlet weak var tv :UITableView!

      @IBOutlet weak var sliderView :ImageSlideshow!
    
    let refreshControl = UIRefreshControl()
    var news :[News] = []
    var recipes :[Recipe] = []
    var slider : [Slider] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //getData()
     
        registerNib()
        tv.dataSource = self
        
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        tv.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "pull to refresh")
        refreshControl.tintColor = UIColor.red
        startRequest()

        
        
        
  
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
              NotificationCenter.default.addObserver(self, selector: #selector(removeFav), name: NSNotification.Name("removeFav"), object: nil)
          
          
          
          NotificationCenter.default.addObserver(self, selector: #selector(addFav), name: NSNotification.Name("addFav"), object: nil)
          
    }
  
    
    @objc func removeFav(){
        
    }
    
    
    
    @objc func addFav(_ notification: NSNotification){
        print("any data \(notification.userInfo!["id_fav"]!) ")
     }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("removeFav"), object: nil )
        
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("addFav"), object: nil)
    }
    
    @objc func refreshData(){
        startRequest()
    }
    
    
    func registerNib(){
        let nib = UINib(nibName: "RecipeTVC", bundle: nil)
        tv.register(nib, forCellReuseIdentifier: "RecipeTVC")
    }
    
    
    
    func initSlider(){
        //let localSource = [BundleImageSource(imageString: "1"), BundleImageSource(imageString: "2"), BundleImageSource(imageString: "3"), ]
        
        
        var imageSource  :[SDWebImageSource] = []
        for slid in slider {
            imageSource.append(SDWebImageSource(urlString: slid.mainImage!)!)
        }

        sliderView.slideshowInterval = 3.0
        sliderView.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 16))
        sliderView.contentScaleMode = UIViewContentMode.scaleAspectFill

        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.white
        //pageControl.sizeThatFits()
        
        sliderView.pageIndicator = pageControl

        
        sliderView.setImageInputs(imageSource)
    }
    
    
    func getData(){
        let params = ["postId":"2"]
         
        AF.request("https://jsonplaceholder.typicode.com/",method:.get ,parameters:  params).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                let dic = data as! [[String:Any]]

            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
    }


    
    
    func startRequest(){
        
        let user = UserDefaultHelper.loadUser()
              var header = [String:String]()
              header["Authorization"] = "Bearer \(user?.token ?? "")"
        
        
        AF.request(Config.MAIN,method:.post,headers :HTTPHeaders(header)).responseJSON { response in
                   debugPrint(response)
                   switch response.result {
                   case .success(let data):
                       let dic = data as! [String:Any]
                        
                       let status = dic["status"] as? Bool ?? false
                       if status {
                        let result = dic["results"] as! [String:Any]
                        
                        let news  = result["news"] as! [Any]
                        let newsData = try! JSONSerialization.data(withJSONObject: news, options: [])
                        self.news = try! JSONDecoder().decode([News].self, from: newsData)
                        
                        
                        
                       let slider  = result["slider"] as! [Any]
                        let sliderData = try! JSONSerialization.data(withJSONObject: slider, options: [])
                        self.slider = try! JSONDecoder().decode([Slider].self, from: sliderData)
                      
                        
                        
                                           let recipeDic  = result["recipe"] as! [Any]
                                            let recipeData = try! JSONSerialization.data(withJSONObject: recipeDic, options: [])
                                            self.recipes = try! JSONDecoder().decode([Recipe].self, from: recipeData)
                                                                 
                                                                 
                        
                                             
                        self.tv.refreshControl!.endRefreshing()
                        self.tv.reloadData()
                        self.initSlider()
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

extension MainVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTVC") as! RecipeTVC
        cell.index = indexPath.row
        cell.news = news
        cell.recipes = recipes
        return cell
        
    }
    
    
}
