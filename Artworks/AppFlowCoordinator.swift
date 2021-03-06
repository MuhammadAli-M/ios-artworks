//
//  AppFlowCoordinator.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//

import UIKit

final class AppFlowCoordinator{
    
    private var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer){
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let flow = appDIContainer.makeArtworksSceneFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
