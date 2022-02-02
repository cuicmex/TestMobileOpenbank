//
//  ListCharacterModel.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 30/1/22.
//

import Foundation

struct ListCharacterModel: Codable{
    
    let characterId: Int
    let characterDescription: String
    let name: String
    let image: ImageModel
    
    enum CodingKeys: String, CodingKey {
        
        case characterId = "id"
        case characterDescription = "description"
        case name
        case image = "thumbnail"

    }
}

