//
//  ArtworksRepo.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//

import Foundation

protocol ArtworksRepo{
    func getArtworks(page: Int, completion: @escaping (Result<[Artwork], ArtworksError>) -> Void)
}

public enum ArtworksError: Error {
    case noIntenetConnection
    case connectionTimeout
    case dataTransferError(DataTransferError)
}
