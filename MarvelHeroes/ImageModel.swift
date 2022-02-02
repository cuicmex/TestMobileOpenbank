//
//  ImageModel.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import Foundation

struct ImageModel: Codable{
    
    let extensionImage: String
    let path: String

    var thumbnailPath: String {
        return path+"/portrait_small."+extensionImage
    }

    var detailPath: String {
        return path+"/landscape_incredible."+extensionImage //464x261
    }

    
    enum CodingKeys: String, CodingKey {
        case extensionImage = "extension"
        case path
    }
}
