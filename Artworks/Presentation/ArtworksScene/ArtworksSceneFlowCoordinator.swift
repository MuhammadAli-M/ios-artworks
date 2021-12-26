//
//  ArtworksSceneFlowCoordinator.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//

import UIKit

final class ArtworksSceneFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private var DIContainer: ArtworksSceneDIContainerProtocol
    
    init(navigationController: UINavigationController,
         DIContainer: ArtworksSceneDIContainerProtocol){
        self.navigationController = navigationController
        self.DIContainer = DIContainer
    }
    
    func start() {
        let vc = DIContainer.makeArtworksListVC(router: self)
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension ArtworksSceneFlowCoordinator: ArtworksListRouterProtocol{
    func showDetailed(artwork: Artwork) {
        let vc = DIContainer.makeArtworkDetailsVC(artwork: artwork,
                                                  router: self)
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension ArtworksSceneFlowCoordinator: ArtworkDetailsRouterProtocol{
    func showArtworksList(){
        navigationController?.popViewController(animated: true)
    }
}
