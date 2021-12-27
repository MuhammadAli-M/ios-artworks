//
//  ArtistViewModel.swift
//  Artworks
//
//  Created by Muhammad Adam on 25/12/2021.
//

import Foundation

struct ArtistViewModel{
    let birthDate: Int
    let deathDate: Int
    
    init(artist: Artist){
        self.birthDate = artist.birthDate
        self.deathDate = artist.deathDate
    }
}
