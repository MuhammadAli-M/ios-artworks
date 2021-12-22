//
//  ArtworksRepo.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//

import Foundation

protocol ArtworksRepo{
    func getArtworks(page: Int, completion: @escaping (Result<[Artwork], Error>) -> Void)
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

    func getArtworks(page: Int, completion: @escaping (Result<[Artwork], Error>) -> Void){

        let requestDTO = ArtworksRequest(page: page)

            let endpoint = APIEndpoints.getArtworks(with: requestDTO)
            self.dataTransferService.request(with: endpoint) { [weak self] result in

                guard let `self` = self else { return }
                
                switch result {
                case .success(let responseDTO):
                    
                    let artworks = self.updateImageLinks(artworks: responseDTO.toDomain())
                    completion(.success(artworks))

                case .failure(let error):
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
}
