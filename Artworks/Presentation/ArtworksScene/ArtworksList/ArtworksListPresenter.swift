//
//  ArtworksListPresenter.swift
//  Artworks
//
//  Created by Muhammad Adam on 21/12/2021.
//  Copyright © 2021 Muhammad Adam. All rights reserved.
//

import Foundation

// MARK:- View
protocol ArtworksListViewProtocol: AnyObject {
    func didFinishLoading(with error: Error?)
}

// MARK:- ViewPresenter
protocol ArtworksListPresenterProtocol: AnyObject {
	var view: ArtworksListViewProtocol? { get set }
    func getTitle() -> String
    func viewDidLoad()
    func getArtworksCount() -> Int
    func viewModel(forCellAtIndex: Int) -> ArtworksItemViewProtocol
}

class ArtworksListPresenter: ArtworksListPresenterProtocol {
    
    // MARK: Properties
    weak var view: ArtworksListViewProtocol?
    var artworks = [Artwork]()
    var repo: ArtworksRepo? // TODO: Fix it, to have use case instead of repo directly
    
    func viewDidLoad() {
        repo?.getArtworks(page: 1, completion: { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result{
            case .success(let artworks):
                self.artworks = artworks
                self.view?.didFinishLoading(with: nil)
            case .failure(let error):
                errorLog("error: \(error.localizedDescription)")
                self.view?.didFinishLoading(with: error)
            }
        })
    }

    // MARK: Methods
    func getTitle() -> String{
        "Artworks" // TODO: Localization
    }
    
    func getArtworksCount() -> Int {
        artworks.count
    }
    
    func viewModel(forCellAtIndex index: Int) -> ArtworksItemViewProtocol {
        let viewModel = ArtworksItemViewModel( artworks[index] )
        return viewModel
    }
}




