//
//  DetailCharacterModel.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import Foundation

struct DetailCharacterModel: Codable{
    
    let characterId: Int
    let characterDescription: String
    let name: String
    let image: ImageModel
    let urlsExtras: [UrlExtraInfoCharacterModel]
    
    enum CodingKeys: String, CodingKey {
        
        case characterId = "id"
        case characterDescription = "description"
        case name
        case image = "thumbnail"
        case urlsExtras = "urls"
    }
}
