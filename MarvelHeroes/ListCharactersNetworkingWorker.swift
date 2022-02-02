//
//  ListCharactersNetworkingWorker.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 31/1/22.
//

import UIKit

class ListCharactersNetworkingWorker: BaseNetworkingWorker {

    override class func servicePath(parametersPath:[String: Any]?) -> String {
        return "characters"
    }

    public class func parametersFor(page: Int, limit: Int) -> [String: Any] {
        let offset = (page-1)*limit
        return ["limit": limit, "offset": offset]
    }
}
