//
//  ArtworksItemViewModel.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//

import Foundation

protocol ArtworksItemViewProtocol{
    var title: String { get }
    var source: String { get }
    var desc: String { get }
    var date: String { get }
    var imageUrl: URL? { get }
    var artistTitle: String? { get }
}

struct ArtworksItemViewModel: ArtworksItemViewProtocol{
    let id: Int
    let title: String
    let source: String
    let desc: String
    let date: String
    var imageUrl: URL?
    let artistTitle: String?
    
    
    init(_ artwork: Artwork){
        self.id = artwork.id
        self.title = artwork.title
        self.source = artwork.placeOfOrigin
        self.desc = artwork.desc
        self.date = artwork.dateDisplay
        self.imageUrl = artwork.imageUrl
        self.artistTitle = artwork.artistTitle
    }
}
