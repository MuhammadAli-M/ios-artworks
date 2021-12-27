//
//  ArtworkListTableCellDelegate.swift
//  Artworks
//
//  Created by Muhammad Adam on 27/12/2021.
//

import Foundation

protocol ArtworkListTableCellDelegate: AnyObject{
    func cell(urlString: String, updatesFavoriteState isFavorite: Bool)
}
