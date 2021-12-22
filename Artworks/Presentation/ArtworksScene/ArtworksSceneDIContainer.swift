//
//  ArtworksSceneDIContainer.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//

import UIKit

protocol ArtworksSceneDIContainerProtocol{
    func makeArtworksListVC(router : ArtworksListRouterProtocol) -> ArtworksListVC
}

final class ArtworksSceneDIContainer: ArtworksSceneDIContainerProtocol{
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferServiceBaseURL: URL?
    }
    
    let dependecies: Dependencies
    
    init(dependecies: Dependencies){
        self.dependecies = dependecies
    }

    func makeArtworksListVC(router : ArtworksListRouterProtocol) -> ArtworksListVC{
        let repo = DefaultArtworksRepo(dataTransferService: dependecies.apiDataTransferService,
                                       imageDataTransferServiceBaseURL: dependecies.imageDataTransferServiceBaseURL)
        let presenter = ArtworksListPresenter()
        let vc = ArtworksListVC.create(with: presenter)
        presenter.repo = repo
        presenter.view = vc
        return vc
    }
}
