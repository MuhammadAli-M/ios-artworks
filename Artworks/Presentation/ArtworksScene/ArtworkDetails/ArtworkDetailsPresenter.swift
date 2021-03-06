//
//  ArtworkDetailsViewModel.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

protocol ArtworkDetailsViewProtocol: AnyObject {
    func themeUpdated(theme: ThemeProtocol)
    func artistInfoFetched(with result:Result<ArtistViewModel, Error> )
    func showAlert(title: String, message: String, actions: [AlertAction])
}

// MARK:- ViewPresenter
protocol ArtworkDetailsPresenterProtocol: AnyObject {
    var view: ArtworkDetailsViewProtocol? { get set }
    func getViewModel() -> ArtworksItemViewModel
    func getTheme() -> ThemeProtocol
    func fetchArtistInfo()
}

class ArtworkDetailsPresenter: ArtworkDetailsPresenterProtocol {
    
    // MARK: Properties
    weak var view: ArtworkDetailsViewProtocol?
    var artwork: Artwork!
    var repo: ArtistsRepo? // TODO: Fix it, to have use case instead of repo directly
    var router: ArtworkDetailsRouterProtocol?
    var deviceRotationManager: DeviceRotationManagerProtocol?{
        didSet{
            deviceRotationManager?.updateInterval = 0.1
            deviceRotationManager?.startUpdates(to: .main, withHandler: { [weak self] result in
                if case let .success(angle) = result {
                    let targetAngle = 30.0 // degrees
                    let sightRange = 150.0
                    let goodSigntStart = targetAngle
                    let goodSigntRange = goodSigntStart...goodSigntStart + sightRange
                    let badSightStart = 2 * .pi.fromRadToDeg() - targetAngle
                    let badSigntRange = badSightStart-sightRange...badSightStart // I reversed as the start will be greater than the end
                    
                    if goodSigntRange ~= angle {
                        self?.view?.themeUpdated(theme: GoodSightTheme())
                    }else if badSigntRange ~= angle {
                        self?.view?.themeUpdated(theme: BadSightTheme())
                    }else{
                        self?.view?.themeUpdated(theme: DefaultTheme())
                    }
                }
                
                // TODO: handle deviceRotationManager error
            })
        }
    }
    
    // MARK: Life Cycle
    
    deinit{
        deviceRotationManager?.stopUpdates()
    }
    
    // MARK: Methods
    func getViewModel() -> ArtworksItemViewModel {
        return ArtworksItemViewModel(artwork)
    }
    
    func getTheme() -> ThemeProtocol{
        return DefaultTheme()
    }
    
    func fetchArtistInfo(){
        
        repo?.getArtist(id: artwork.artistId, completion: { [weak self] result in
            
            guard let `self` = self else { return }
            
            let outputResult = result
                .map { ArtistViewModel(artist: $0) }
                .mapError { $0 as Error }
            
            self.view?.artistInfoFetched(with: outputResult)
            
            if case .failure(let error) = result {
                errorLog("\(String(describing: error))")
                
                switch error{
                    
                case .noAttacedIdentifier:
                    self.view?.showAlert(title: "Error",
                                          message: "NoAttacedIdentifierErrorMessage".localizedValue,
                                          actions: [.init(title: "OK",
                                                          block: nil,
                                                          type: .normal)])

                case .noIntenetConnection:
                    self.view?.showAlert(title: "Error".localizedValue,
                                         message: "NoInternetConnectErrorMessage".localizedValue,
                                         actions: [.init(title: "OKAction".localizedValue,
                                                          block: nil,
                                                          type: .normal)])
                    
                case .connectionTimeout:
                    self.view?.showAlert(title: "Error".localizedValue,
                                         message: "InternetConnectTimeoutErrorMessage".localizedValue,
                                         actions: [.init(title: "OKAction".localizedValue,
                                                          block: nil,
                                                          type: .normal)])

                case .dataTransferError(let dataTransferError):
                    errorLog("dataTransferError: \(String(describing: dataTransferError))")
                    self.view?.showAlert(title: "Error".localizedValue,
                                         message: "InternalErrorMessage".localizedValue,
                                          actions: [.init(title: "OKAction".localizedValue,
                                                          block: nil,
                                                          type: .normal)])
                }
            }
        })
    }
}


