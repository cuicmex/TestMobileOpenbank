//
//  MarvelHeroesTests.swift
//  MarvelHeroesTests
//
//  Created by Humberto C Trujano Chavez on 28/1/22.
//

import XCTest
@testable import MarvelHeroes

class MarvelHeroesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testListCharactersNetworkingWorker() {
        
        let promise = expectation(description: "There is result and no error")

        let elementsByPage = 20
                
        let parameters = ListCharactersNetworkingWorker.parametersFor(page: 1, limit: elementsByPage)
        
        ListCharactersNetworkingWorker.performRequest(parameters: parameters, parametersPath: nil, typeOfModel: ListCharactersInfo.self, completion: { result, error in

            if let result = result, !error {
                if result.count != elementsByPage {
                    XCTFail("Number elements inconsistency")
                }else{
                    promise.fulfill()
                }
                
            }else{
                XCTFail("Service error")
            }
        })

        wait(for: [promise], timeout: 5)
    }


    func testDetailCharacterNetworkingWorker() {
        
        let promise = expectation(description: "There is result and no error")

        let idCharacter = 1017100
//        let idCharacter = 1

        let parametersPath=[DetailCharacterNetworkingWorker.kKey_idCharacter: idCharacter]
        
        DetailCharacterNetworkingWorker.performRequest(parameters: nil, parametersPath: parametersPath, typeOfModel: DetailCharacterInfo.self) { result, error in

            if let result = result, !error {
                print(result)
                promise.fulfill()
            }else{
                XCTFail("Service error")
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
}
