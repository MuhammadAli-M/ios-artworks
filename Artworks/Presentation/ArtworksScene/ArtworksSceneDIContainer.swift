//
//  ArtworksSceneDIContainer.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//

import UIKit

protocol ArtworksSceneDIContainerProtocol{
    func makeArtworksListVC(router : ArtworksListRouterProtocol) -> ArtworksListVC
    func makeArtworkDetailsVC(artwork: Artwork, router : ArtworkDetailsRouterProtocol) -> ArtworkDetailsVC
}

final class ArtworksSceneDIContainer: ArtworksSceneDIContainerProtocol{
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferServiceBaseURL: URL?
    }
    
    let dependecies: Dependencies
    lazy var artworksRepo = DefaultArtworksRepo(dataTransferService: dependecies.apiDataTransferService,
                                   imageDataTransferServiceBaseURL: dependecies.imageDataTransferServiceBaseURL)
    lazy var artistsRepo = DefaultArtistsRepo(dataTransferService: dependecies.apiDataTransferService)
    
    let deviceRotationManager = DefaultDeviceRotationManager()

    
    init(dependecies: Dependencies){
        self.dependecies = dependecies
    }

    func makeArtworksListVC(router : ArtworksListRouterProtocol) -> ArtworksListVC{
        let presenter = ArtworksListPresenter()
        presenter.router = router
        let vc = ArtworksListVC.create(with: presenter)
        presenter.repo = artworksRepo
        presenter.view = vc
        return vc
    }
    
    func makeArtworkDetailsVC(artwork: Artwork, router : ArtworkDetailsRouterProtocol) -> ArtworkDetailsVC{
        
        let presenter = ArtworkDetailsPresenter()
        presenter.artwork = artwork
        presenter.router = router
        presenter.deviceRotationManager = deviceRotationManager
        let vc = ArtworkDetailsVC.create(with: presenter)
        presenter.repo = artistsRepo
        presenter.view = vc
        return vc
    }
}
