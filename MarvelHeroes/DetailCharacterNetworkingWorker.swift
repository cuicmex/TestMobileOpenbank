//
//  DetailCharacterNetworkingWorker.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 31/1/22.
//

import UIKit


class DetailCharacterNetworkingWorker: BaseNetworkingWorker {

    static let kKey_idCharacter = "idCharacter"

    override class func servicePath(parametersPath: [String : Any]?) -> String {
        let idCharacter = parametersPath?[kKey_idCharacter] ?? ""
        return "characters/\(idCharacter)"
    }
}
