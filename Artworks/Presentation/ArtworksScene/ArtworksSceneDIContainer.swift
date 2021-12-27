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
    
    private let dependecies: Dependencies
    private lazy var artworksRepo = DefaultArtworksRepo(dataTransferService: dependecies.apiDataTransferService,
                                   imageDataTransferServiceBaseURL: dependecies.imageDataTransferServiceBaseURL)
    private lazy var artistsRepo = DefaultArtistsRepo(dataTransferService: dependecies.apiDataTransferService)
    
    private lazy var deviceRotationManager = DefaultDeviceRotationManager() // Added here so you don't make a new one with each presenter

    
    init(dependecies: Dependencies){
        self.dependecies = dependecies
    }

    func makeArtworksListVC(router : ArtworksListRouterProtocol) -> ArtworksListVC{
        let presenter = ArtworksListPresenter()
        presenter.router = router
        presenter.repo = artworksRepo
        let vc = ArtworksListVC.create(with: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeArtworkDetailsVC(artwork: Artwork, router : ArtworkDetailsRouterProtocol) -> ArtworkDetailsVC{
        
        let presenter = ArtworkDetailsPresenter()
        presenter.artwork = artwork
        presenter.router = router
        presenter.deviceRotationManager = deviceRotationManager
        presenter.repo = artistsRepo
        let vc = ArtworkDetailsVC.create(with: presenter)
        presenter.view = vc
        return vc
    }
}
