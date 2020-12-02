//
//  Constants.swift
//  NYTimesTrial
//
//  Created by ispha on 7/18/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import Foundation
struct Constants{
    //foursquare api Secret ID
    static let CLIENT_SECRET = "4cGlDc53PFTiLz3AleutmfXJRB2MYyCQ"
    struct DomainEndpoint
    {
        static let DOMAIN_ENDPOINT = "http://api.nytimes.com/svc/"
        static let Version = "v2"
        static let Section = "all-sections/"
        static let Period = "7"
        static let ArticlesEndpoint = "mostpopular/" + Version + "/mostviewed/"
        static let Images_url = "https://image.tmdb.org/t/p/w500/"
    }
    
    
    struct Colors {
        
        static let imgColor = "#F0F2F5"
        
    }
    struct  StoryboardIDs {
        static let Main = "Main"
    }
    struct StoryboardVCsIDs
    {
        static let ArticleDetailsViewController = "ArticleDetailsViewController"
    }
    
}
enum Language : String
{
    case ar = "ar"
    case en = "en-US"
}
