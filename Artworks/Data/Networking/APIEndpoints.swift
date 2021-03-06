//
//  APIEndpoints.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//

import Foundation

struct APIEndpoints {
    
    static func getArtworks(with requestDTO: ArtworksRequest) -> Endpoint<ArtworksListResponse> {
        return Endpoint(path: "artworks",
                        method: .get,
                        headerParamaters: ["Content-Type": "application/json"],
                        queryParametersEncodable: requestDTO)
    }
    
    static func getArtworkImageUrl(with baseUrl: String, imageId: String) -> URL?{
        return URL(string: "\(baseUrl)/\(imageId)/full/843,/0/default.jpg" )
    }
    
    static func getArtist(with requestDTO: ArtistRequest) -> Endpoint<ArtistInfoResponse> {
        return Endpoint(path: "artists/\(requestDTO.id)",
                        method: .get,
                        headerParamaters: ["Content-Type": "application/json"])
    }
}
