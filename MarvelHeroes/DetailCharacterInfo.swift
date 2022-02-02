//
//  DetailCharacterInfo.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import Foundation

struct DetailCharacterInfo: Codable {

    let total: Int
    let detailCharacters: [DetailCharacterModel]

    var character: DetailCharacterModel {
        return detailCharacters[0]
    }

    enum CodingKeys: String, CodingKey {
        case total
        case detailCharacters = "results"
    }

}
