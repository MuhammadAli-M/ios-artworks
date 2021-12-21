//
//  AppDIContainer.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//

import UIKit

final class AppDIContainer{
    
    init(){}
    
    func makeArtworksSceneDIContainer() -> ArtworksSceneDIContainerProtocol{
        return ArtworksSceneDIContainer()
    }
    
    func makeArtworksSceneFlowCoordinator(navigationController: UINavigationController) -> ArtworksSceneFlowCoordinator{
        let DIContainer = makeArtworksSceneDIContainer()
        return ArtworksSceneFlowCoordinator(navigationController: navigationController, DIContainer: DIContainer)
    }
}
