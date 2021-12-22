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
}

struct ArtworksItemViewModel: ArtworksItemViewProtocol{
    let title: String
    let source: String
    let desc: String
    let date: String
    var imageUrl: URL?
    
    
    init(_ artwork: Artwork){
        self.title = artwork.title
        self.source = artwork.placeOfOrigin
        self.desc = artwork.desc
        self.date = artwork.dateDisplay
        self.imageUrl = artwork.imageUrl
    }
}
