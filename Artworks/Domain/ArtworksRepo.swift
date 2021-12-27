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

final class DefaultArtworksRepo {

    private let dataTransferService: DataTransferService
    private let imageDataTransferServiceBaseURL: URL?

    init(dataTransferService: DataTransferService, imageDataTransferServiceBaseURL: URL?) {
        self.dataTransferService = dataTransferService
        self.imageDataTransferServiceBaseURL = imageDataTransferServiceBaseURL
    }
}

extension DefaultArtworksRepo: ArtworksRepo {

    func getArtworks(page: Int, completion: @escaping (Result<[Artwork], ArtworksError>) -> Void){

        let requestDTO = ArtworksRequest(page: page)

            let endpoint = APIEndpoints.getArtworks(with: requestDTO)
            self.dataTransferService.request(with: endpoint) { [weak self] result in

                guard let `self` = self else { return }
                
                switch result {
                case .success(let responseDTO):
                    
                    let artworks = self.updateImageLinks(artworks: responseDTO.toDomain())
                    completion(.success(artworks))

                case .failure(let error):
                    let error = self.resolve(dataTransferError: error)
                    completion(.failure(error))
                }
            }
    }
    
    private func updateImageLinks(artworks: [Artwork]) -> [Artwork]{
        
        return artworks.map { artwork in
            var artwork1 = artwork
            artwork1.imageUrl = APIEndpoints.getArtworkImageUrl(with: imageDataTransferServiceBaseURL?.absoluteString ?? "", imageId: artwork.imageId)
            return artwork1
        }
    }
    
    private func resolve(dataTransferError: DataTransferError) -> ArtworksError{
        var outputError: ArtworksError = .dataTransferError(dataTransferError)
        
        if case .networkFailure(let networkError) = dataTransferError{
           if case .notConnected = networkError {
            outputError =  ArtworksError.noIntenetConnection
           } else if case .timedOut = networkError {
               return ArtworksError.connectionTimeout
           }
        }
        return outputError
    }
}
