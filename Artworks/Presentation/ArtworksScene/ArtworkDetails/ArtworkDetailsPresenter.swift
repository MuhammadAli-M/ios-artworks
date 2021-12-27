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
}

// MARK:- ViewPresenter
protocol ArtworkDetailsPresenterProtocol: AnyObject {
    var view: ArtworkDetailsViewProtocol? { get set }
    func getViewModel() -> ArtworksItemViewModel
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
            deviceRotationManager?.startDeviceMotionUpdates(to: .main, withHandler: { [weak self] result in
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
                
                // TODO: handle error
            })
        }
    }
    
    // MARK: Life Cycle
    
    deinit{
        deviceRotationManager?.stopDeviceMotionUpdates()
    }
    
    // MARK: Methods
    func getViewModel() -> ArtworksItemViewModel {
        return ArtworksItemViewModel(artwork)
    }
    
    func getTitle() -> String{
        artwork.title // TODO: Localization
    }
    
    func fetchArtistInfo(){
        guard let artistId = artwork.artistId else {
            errorLog("Null for artistId for artwork: \(artwork.title)")
            view?.artistInfoFetched(with: .failure(ArtistInfoError.noAttacedIdentifier))
            return
        }
        
        repo?.getArtist(id: String(artistId), completion: { [weak self] result in
            
            let outputResult = result.map { ArtistViewModel(artist: $0) }
            
            self?.view?.artistInfoFetched(with: outputResult)
        })
    }
}

enum ArtistInfoError: Error{
    case noAttacedIdentifier
}



// TODO: Add new file
extension Double{
    static var piInDegrees: Double = 180
    
    func fromRadToDeg() -> Double {
        return self * .piInDegrees / .pi
    }
}
