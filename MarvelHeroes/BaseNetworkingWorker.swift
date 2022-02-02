//
//  BaseNetworkingWorker.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 30/1/22.
//

import Foundation
import Alamofire
import CryptoKit

class BaseNetworkingWorker{
    
    //To override by each subclass
    public class func servicePath(parametersPath:[String: Any]?) -> String {
        return ""
    }
    
    public class func performRequest<ModelToUse:Decodable>(parameters:[String: Any]?, parametersPath:[String: Any]?, typeOfModel:ModelToUse.Type, completion: @escaping(_ result:ModelToUse?, _ error:Bool) -> Void) {
        
        let completeUrlStr=baseUrlStr()+servicePath(parametersPath: parametersPath)
        
        var completeParameters:[String: Any]
        if let parameters=parameters{
            completeParameters = parameters.merging(baseParameters()) { (_, new) in new }
        }else{
            completeParameters = baseParameters()
        }
        
        if let encoded = completeUrlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded){
            
            AF.request(url, method: .get, parameters: completeParameters).validate(statusCode: 200..<500).responseDecodable { (response: DataResponse<MarvelResponse<ModelToUse>, AFError>) in

                if let marvelResponse = response.value, response.error == nil {
                    switch marvelResponse.status {
                    case .success:
                        if let info: ModelToUse = marvelResponse.data{
                            completion(info, false)
                        }else{
                            completion(nil, true)
                        }
                    case .failed:
                        completion(nil, true)
                    }
                } else {
                    completion(nil, true)
                }
            }
        }else{
            completion(nil, true)
        }
    }
    
    public class func baseParameters() -> [String: Any]! {

        let timeStamp:TimeInterval = NSDate.init().timeIntervalSince1970
        let timeStampStr:String = String(Int(timeStamp))
        
        let apiKeyPrivate="567adbc41352f1786cfacf408cc702714684a688"
        let apiKeyPublic="8df26c3a9b35f1224b32c3a067e709f3"
        
        let hash=MD5(string: "\(timeStampStr)\(apiKeyPrivate)\(apiKeyPublic)")

        let parameters: [String: Any] = ["apikey": apiKeyPublic, "hash": hash, "ts": timeStampStr]

        return parameters
    }
    
    private class func baseUrlStr() -> String {
        return "https://gateway.marvel.com/v1/public/"
    }
    
    private class func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
