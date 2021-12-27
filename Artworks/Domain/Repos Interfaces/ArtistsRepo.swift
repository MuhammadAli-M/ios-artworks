//
//  ArtistsRepo.swift
//  Artworks
//
//  Created by Muhammad Adam on 24/12/2021.
//

import Foundation

protocol ArtistsRepo{
    func getArtist(id: Int?, completion: @escaping (Result<Artist, ArtistInfoError>) -> Void)
}

enum ArtistInfoError: Error{
    case noAttacedIdentifier
    case noIntenetConnection
    case connectionTimeout
    case dataTransferError(DataTransferError)
}
