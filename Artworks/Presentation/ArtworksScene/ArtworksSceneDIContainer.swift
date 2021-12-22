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
    
    func makeArtworksListVC(router : ArtworksListRouterProtocol) -> ArtworksListVC{
        let presenter = ArtworksListPresenter()
        let vc = ArtworksListVC.create(with: presenter)
        return vc
    }
     
}
