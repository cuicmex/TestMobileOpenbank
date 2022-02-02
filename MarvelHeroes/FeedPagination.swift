//
//  FeedPagination.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import Foundation

class FeedPagination {
    
    var elementsByPage: Int = 0

    var totalElementsExpected: Int = 0
    var lastPageReadIt: Int = 0

    var accumulatedElements: [Any] = [Any]()
    var lastFetchElements: [Any] = [Any]()
    
    init() {
    }
    

    func resetFeedPagination(){
        lastPageReadIt=0
        totalElementsExpected=0
        accumulatedElements.removeAll()
        lastFetchElements.removeAll()
    }

    func addLastFetch(elements: [Any]){
        lastFetchElements.removeAll()
        lastFetchElements.append(contentsOf: elements)
        accumulatedElements.append(contentsOf: elements)
        
        self.lastPageReadIt += 1
    }

    func alreadyReadedAllElements() -> Bool {
        //Si se tiene una ultima lectura donde lo leido sea lo ultimo, pero coincide el numero de elementos leidos con el numero de elementos por paginacion, se requerira una lectura adicional que de 0 para asegurar que es el final.
        //Esto es asi porque el numero de elementos totales esperados puede variar durante el proceso (si en ese momento se agregan o eliminan elementos mediante el gestor)
        if (self.lastFetchElements.count < self.elementsByPage) {
            return true;
        }else{
            return false;
        }
    }

}
