//
//  ServicesURLs.swift
//  NYTimesTrial
//
//  Created by ispha on 7/18/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import Foundation
class ServicesURls {
    class func get_MostViewed(page:Int, lang:Language)->String
    {
        return 
            Constants.DomainEndpoint.DOMAIN_ENDPOINT + 
            Constants.DomainEndpoint.ArticlesEndpoint +
            Constants.DomainEndpoint.Section +
            Constants.DomainEndpoint.Period +
            ".json?" +
            "api-key=\(Constants.CLIENT_SECRET)"
    }
    class func get_Details(id:Int,page:Int, lang:Language)->String
    {
        return
            Constants.DomainEndpoint.DOMAIN_ENDPOINT +   Constants.DomainEndpoint.Version +
            Constants.DomainEndpoint.ArticlesEndpoint  +
            "\(id)" + "?" +
            "api_key=\(Constants.CLIENT_SECRET)&" +
            "language=\(lang.rawValue)&page=\(page)"
        
    }
    
}
