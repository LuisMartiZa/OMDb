//
//  SearchItem.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchItem: Mappable {
    var imdbID: String?
    var title: String?
    var year: String?
    var posterImage: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title           <- map["Title"]
        year            <- map["Year"]
        posterImage     <- map["PosterImage"]
    }
}
