//
//  UrlExtraInfoCharacterModel.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import Foundation

struct UrlExtraInfoCharacterModel: Codable {
    
    let type: String
    let urlStr: String

    enum CodingKeys: String, CodingKey {
        case type
        case urlStr = "url"
    }
}
