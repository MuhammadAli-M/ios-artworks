//
//  ArtistsRepo.swift
//  Artworks
//
//  Created by Muhammad Adam on 24/12/2021.
//

import Foundation

protocol ArtistsRepo{
    func getArtist(id: String, completion: @escaping (Result<Artist, Error>) -> Void)
}

final class DefaultArtistsRepo {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultArtistsRepo: ArtistsRepo {
    func getArtist(id: String, completion: @escaping (Result<Artist, Error>) -> Void) {
        let requestDTO = ArtistRequest(id: id)
        
        let endpoint = APIEndpoints.getArtist(with: requestDTO)
        self.dataTransferService.request(with: endpoint) { [weak self] result in

            guard let `self` = self else { return }
            
            switch result {
            case .success(let responseDTO):
                
                completion(.success(responseDTO.toDomain()))

            case .failure(let error):
                completion(.failure(error))
            }
        }

        
    }
    
}

