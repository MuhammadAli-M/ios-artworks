//
//  AppDIContainer.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//

import UIKit

final class AppDIContainer{
    
    private lazy var appConfiguration = AppConfiguration(apiBaseURL: "https://api.artic.edu/api/v1/",
                                                 imagesBaseURL: "https://www.artic.edu/iiif/2/")

    // MARK: - Network
    private lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                          queryParameters: ["language": NSLocale.preferredLanguages.first ?? "en"])
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    init(){}
    
    func makeArtworksSceneDIContainer() -> ArtworksSceneDIContainerProtocol{
        return ArtworksSceneDIContainer(dependecies: .init(apiDataTransferService: apiDataTransferService,
                                                           imageDataTransferServiceBaseURL: URL( string: appConfiguration.imagesBaseURL)))
    }
    
    func makeArtworksSceneFlowCoordinator(navigationController: UINavigationController) -> ArtworksSceneFlowCoordinator{
        let DIContainer = makeArtworksSceneDIContainer()
        return ArtworksSceneFlowCoordinator(navigationController: navigationController, DIContainer: DIContainer)
    }
}
