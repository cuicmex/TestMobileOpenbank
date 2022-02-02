//
//  ListCharactersInfo.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 31/1/22.
//

import Foundation

struct ListCharactersInfo: Codable {

    let count: Int
    let limit: Int
    let offset: Int
    let total: Int
    let listCharacters: [ListCharacterModel]

    enum CodingKeys: String, CodingKey {
        case count
        case limit
        case offset
        case total
        case listCharacters = "results"
    }

}
