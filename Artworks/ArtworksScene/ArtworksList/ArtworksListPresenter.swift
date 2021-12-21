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
    func viewDidLoad()
}

class ArtworksListPresenter: ArtworksListPresenterProtocol {

    // MARK: Properties
    weak var view: ArtworksListViewProtocol?


    func viewDidLoad() {
    }

    // MARK: Methods

}
