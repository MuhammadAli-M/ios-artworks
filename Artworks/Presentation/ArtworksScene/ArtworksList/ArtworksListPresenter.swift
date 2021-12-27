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
    func showAlert(title: String, message: String, actions: [AlertAction])
}

// MARK:- ViewPresenter
protocol ArtworksListPresenterProtocol: AnyObject {
	var view: ArtworksListViewProtocol? { get set }
    func getTitle() -> String
    func viewDidLoad()
    func getArtworksCount() -> Int
    func viewModel(forCellAtIndex: Int) -> ArtworksItemViewProtocol
    func artworkTapped(withIndex index: Int)
    func willDisplayItem(ForIndex: Int)
}

class ArtworksListPresenter: ArtworksListPresenterProtocol {
    
    // MARK: Properties
    weak var view: ArtworksListViewProtocol?
    var router: ArtworksListRouterProtocol?
    var repo: ArtworksRepo? // TODO: Fix it, to have use case instead of repo directly
    var artworks = [Artwork]()
    var nextPage = 1
    var loading = false
    var automaticPaginate = true
    let minIntervalToFetchAfterNoConnection:Double = 10.0 // seconds
    let itemsMarginToFetchNewPage = 10
    
    
    func viewDidLoad() {
        fetchArtworks(page: nextPage)
    }
    
    // MARK: Methods
    func getTitle() -> String{
        "Artworks" // TODO: Localization
    }
    
    func getArtworksCount() -> Int {
        artworks.count
    }
    
    func fetchArtworks(page: Int){
        loading = true
        repo?.getArtworks(page: page, completion: { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result{
            case .success(let artworks):
                self.artworks += artworks
                self.view?.didFinishLoading(with: nil)
                self.nextPage = page + 1
            case .failure(let error):
                errorLog("error: \(error.localizedDescription)")
                
                self.view?.didFinishLoading(with: error)
                
                self.handleError(artworksError: error)
                
                if case .noIntenetConnection = error{
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.minIntervalToFetchAfterNoConnection) { [weak self] in
                        self?.automaticPaginate = true
                    }
                    self.automaticPaginate = false
                }
            }
            self.loading = false
        })
    }
    
    func viewModel(forCellAtIndex index: Int) -> ArtworksItemViewProtocol {
        let viewModel = ArtworksItemViewModel( artworks[index] )
        return viewModel
    }
    
    func artworkTapped(withIndex index: Int){
        router?.showDetailed(artwork: artworks[index])
    }
    
    func willDisplayItem(ForIndex index: Int) {
        if index + itemsMarginToFetchNewPage >= artworks.count && !loading && automaticPaginate{
            fetchArtworks(page: nextPage)
        }
    }
    
    private func handleError(artworksError: ArtworksError){
        switch artworksError{
            
        case .noIntenetConnection:
            self.view?.showAlert(title: "Error",
                                  message: "Internet connection can not be established",
                                  actions: [.init(title: "OK",
                                                  block: nil,
                                                  type: .normal)])
            
        case .connectionTimeout:
            self.view?.showAlert(title: "Error",
                                  message: "Internet connection took too much time",
                                  actions: [.init(title: "OK",
                                                  block: nil,
                                                  type: .normal)])

        case .dataTransferError(let dataTransferError):
            errorLog("dataTransferError: \(String(describing: dataTransferError))")
            self.view?.showAlert(title: "Error",
                                  message: "Internal error occured, check application logs",
                                  actions: [.init(title: "OK",
                                                  block: nil,
                                                  type: .normal)])
        }
    }
}




