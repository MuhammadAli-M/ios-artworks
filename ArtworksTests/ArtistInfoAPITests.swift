//
//  ArtistInfoAPITests.swift
//  ArtworksTests
//
//  Created by Muhammad Adam on 25/12/2021.
//

import XCTest

class ArtistInfoAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchArtistInfo() throws {
        // This is an example of a functional test case.
        let url = URL(string: "https://api.artic.edu/api/v1/artists/36062")

        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            
            if let error = error {
                XCTFail("error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                XCTFail("empty data, response: \(response.debugDescription)")
                return
            }
            
            do{
                let responseData = try JSONDecoder().decode(ArtistInfoResponse.self, from: data)
                let artist = responseData.toDomain()
                
                debugLog("recieved \(artist)")
            }catch{
                XCTFail("while json parsing, error : \(error.localizedDescription)")
            }
        }
        task.resume()
        
    }

}
