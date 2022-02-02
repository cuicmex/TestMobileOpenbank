//
//  MarvelResponse.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 30/1/22.
//

import Foundation

struct MarvelResponse<T>: Decodable where T: Decodable {

    let code: Int
    let copyright: String
    let statusResponse: String
    private(set) var data: T?

    var status: Status {
        if (statusResponse=="Ok"){
            return .success
        }else{
            return .failed
        }
    }
    enum CodingKeys: String, CodingKey {
        case code
        case copyright
        case statusResponse = "status"
        case data = "data"
    }

    enum Status {
        case success
        case failed
    }

}

