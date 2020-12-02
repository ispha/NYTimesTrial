//
//  ServicesManager.swift
//  NYTimesTrial
//
//  Created by ispha on 7/18/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireActivityLogger


class ServicesManager {
    static let instance = ServicesManager()
    
    
    /* -------------------Start call for Articles --------------- */
    
    func getMostViewed(completionHandler: @escaping (_ arrayOfItems:[Item]?) -> Void) {
        
        self.makeApiRequest(params: nil, urlString: ServicesURls.get_MostViewed(page: 1, lang: .en), httpMethod: .get, headers: [:], completionHandler:
                                
                                { (response) in
                                    
                                    
                                    switch response.result{
                                    case .failure(let error):
                                        HelpingMethods.showAlert(title: "", messgae: "\(error.localizedDescription)", delegate: UIApplication.topViewController()!)
                                        
                                        
                                        completionHandler(nil)
                                    case .success(let value):
                                        
                                        
                                        do {
                                            
                                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                                            let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                                            print("response data branches› =\(String(describing: json))")
                                            if response.response?.statusCode == 200
                                            {
                                                let decodedModel = try JSONDecoder().decode(NYTimesResponseModel.self, from: jsonData)
                                                // Storage.store(decodedModel.teams , to: .documents, as: Constants.TeamsOffline)
                                                completionHandler(decodedModel.results)
                                                
                                                
                                                
                                            }
                                            else{
                                                
                                                HelpingMethods.showAlert(title:  "\( response.response?.statusCode ?? 0000)", messgae: response.response.debugDescription , delegate: UIApplication.topViewController()!)
                                                completionHandler(nil)
                                                
                                            }
                                            
                                            
                                        }catch let error {
                                            HelpingMethods.showAlert(title: "", messgae: "\(error)", delegate: UIApplication.topViewController()!)
                                            HelpingMethods.showAlert(title:  "", messgae:  "Something wnet wrong!", delegate: UIApplication.topViewController()!)
                                            completionHandler(nil)
                                            
                                            HelpingMethods.printStringBy_ispha(string: "😞 Codable failure with error = \(error)")
                                        }
                                        
                                    }
                                    
                                }
        )
    }
    func getDetails(id:Int,completionHandler: @escaping (_ article:Item?) -> Void) {
        
        self.makeApiRequest(params: nil, urlString: ServicesURls.get_Details(id: id,page: 1, lang: .en), httpMethod: .get, headers: [:], completionHandler:
                                
                                { (response) in
                                    
                                    
                                    switch response.result{
                                    case .failure(let error):
                                        HelpingMethods.showAlert(title: "", messgae: "\(error.localizedDescription)", delegate: UIApplication.topViewController()!)
                                        
                                        
                                        completionHandler(nil)
                                    case .success(let value):
                                        
                                        
                                        do {
                                            
                                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                                            let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                                            print("response data branches› =\(String(describing: json))")
                                            if response.response?.statusCode == 200
                                            {
                                                let decodedModel = try JSONDecoder().decode(Item.self, from: jsonData)
                                                // Storage.store(decodedModel.teams , to: .documents, as: Constants.TeamsOffline)
                                                completionHandler(decodedModel)
                                                
                                                
                                                
                                            }
                                            else{
                                                
                                                HelpingMethods.showAlert(title:  "\( response.response?.statusCode ?? 0000)", messgae: response.response.debugDescription , delegate: UIApplication.topViewController()!)
                                                completionHandler(nil)
                                                
                                            }
                                            
                                            
                                        }catch let error {
                                            HelpingMethods.showAlert(title: "", messgae: "\(error)", delegate: UIApplication.topViewController()!)
                                            HelpingMethods.showAlert(title:  "", messgae:  "Something wnet wrong!", delegate: UIApplication.topViewController()!)
                                            completionHandler(nil)
                                            
                                            HelpingMethods.printStringBy_ispha(string: "😞 Codable failure with error = \(error)")
                                        }
                                        
                                    }
                                    
                                }
        )
    }
    
    
    /* -------------------Start Alamofire call------------------ */
    
    fileprivate func makeApiRequest(params:[String:Any]?,urlString:String,httpMethod:HTTPMethod,headers:HTTPHeaders,completionHandler: @escaping (_ reponse:DataResponse<Any>) -> Void)
    {
        if HelpingMethods.isConnectedToNetwork() == true {
            Alamofire.request(urlString, method: httpMethod, parameters:params  , encoding: URLEncoding.httpBody , headers: headers).log().responseJSON { (response) in
                completionHandler(response)
            }
        }
        else
        {
            // MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
            HelpingMethods.showAlert(title:  "No Internet connection!", messgae: "This app requeires good internet connection,Please make sure you are connected to Internet!", delegate: UIApplication.topViewController()!)
        }
        
    }
    fileprivate func makeApiRequest2(params:[String:Any]?,urlString:String,httpMethod:HTTPMethod,headers:HTTPHeaders,completionHandler: @escaping (_ reponse:DataResponse<Any>) -> Void)
    {
        if HelpingMethods.isConnectedToNetwork() == true {
            Alamofire.request(urlString, method: httpMethod, parameters:params  , encoding: URLEncoding.queryString , headers: headers).log().responseJSON { (response) in
                completionHandler(response)
            }
        }
        else
        {
            //  MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
            HelpingMethods.showAlert(title:  "No Internet connection!", messgae: "This app requeires good internet connection,Please make sure you are connected to Internet!", delegate: UIApplication.topViewController()!)
        }
        
    }
    
    /* -------------------End Alamofire call------------------ */
    
    
    
    
    /* -------------------Start Forming Headers------------------ */
    fileprivate func setUpHeaders()->HTTPHeaders
    {
        var headers = [
            
            "Content-Type": "application/x-www-form-urlencoded"
            
        ]
        
        headers["X-Auth-Token"] = Constants.CLIENT_SECRET
        
        return headers
    }
    /* -------------------End Forming Headers------------------ */
    
    
    
    
    
    
}
