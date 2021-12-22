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
    var artworks: [Artwork] = [ .init(title: "Dumo", source: "d source", desc: "d desc", date: "d date", imageUrl: URL(string: ""))
    ]

    func viewDidLoad() {
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




