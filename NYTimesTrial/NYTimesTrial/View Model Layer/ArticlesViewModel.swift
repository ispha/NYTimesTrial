//
//  ListViewModel.swift
//  NYTimesTrial
//
//  Created by ispha on 7/18/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MBProgressHUD
class ArticlesViewModel: NSObject {
    
    
    //  var home : Variable<Home>?
    var arrayOfItems = [Item]()
    
    var article : Item?
    var totalCount = 0
    let isLoading = BehaviorRelay(value: false)
    
    func getData() {
        
        ServicesManager().getMostViewed(completionHandler: { (array) in
            if let _ = array {
                
                // sorting results A-Z
                self.arrayOfItems = array ?? []
                
                self.isLoading.accept(true)
                
                
            }else{
                self.arrayOfItems =  []
                self.isLoading.accept(false)
                
            }
            
        })
    }
    func getDetails(id:Int) {
        
        ServicesManager().getDetails(id: id, completionHandler: { (mov) in
            if let _ = mov {
                
                
                self.article = mov
                
                self.isLoading.accept(true)
                
                
            }else{
                self.article = nil
                self.isLoading.accept(false)
                
            }
            
        })
    }
    /*
     func postRating(id:Int,rate:Int,v:UIView) {
     showLoadingSign(view: v)
     ServicesManager().postRating(id: id, rate: rate,  completionHandler: { (mov) in
     if let _ = mov {
     
     
     self.article = mov
     
     self.isLoading.accept(true)
     
     
     }else{
     self.arrayOfItems =  []
     self.isLoading.accept(false)
     
     }
     DispatchQueue.main.async {
     self.hideLoadingSign(view: v)
     }
     })
     }*/
    func showLoadingSign(view:UIView)
    {
        MBProgressHUD.showAdded(to: view, animated: true)
        
    }
    func hideLoadingSign(view:UIView)
    {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
