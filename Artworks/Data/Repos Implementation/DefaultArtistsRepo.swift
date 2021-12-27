//
//  DefaultArtistsRepo.swift
//  Artworks
//
//  Created by Muhammad Adam on 27/12/2021.
//

import Foundation

final class DefaultArtistsRepo {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultArtistsRepo: ArtistsRepo {
    func getArtist(id: Int?, completion: @escaping (Result<Artist, ArtistInfoError>) -> Void) {
        
        guard let artistId = id else {
            completion(.failure(.noAttacedIdentifier))
            return
        }
        
        let requestDTO = ArtistRequest(id: String(artistId))
        
        let endpoint = APIEndpoints.getArtist(with: requestDTO)
        self.dataTransferService.request(with: endpoint) { [weak self] result in

            guard let `self` = self else { return }
            
            switch result {
            case .success(let responseDTO):
                
                completion(.success(responseDTO.toDomain()))

            case .failure(let error):
                let artistInfoError = self.resolve(dataTransferError: error)
                completion(.failure(artistInfoError))
            }
        }
    }

    private func resolve(dataTransferError: DataTransferError) -> ArtistInfoError{
        var outputError: ArtistInfoError = .dataTransferError(dataTransferError)
        
        if case .networkFailure(let networkError) = dataTransferError{
           if case .notConnected = networkError {
            outputError =  .noIntenetConnection
           } else if case .timedOut = networkError {
               return .connectionTimeout
           }
        }
        return outputError
    }

}

