//
//  ArtistViewModel.swift
//  Artworks
//
//  Created by Muhammad Adam on 25/12/2021.
//

import Foundation

struct ArtistViewModel{
    let birthDate: String
    let deathDate: String
    
    init(artist: Artist){
        var birthDateString: String = "Nan"
        var deathDateString: String = "Nan"
        
        if let birthDate = artist.birthDate {
            birthDateString = String(birthDate)
        }
        if let deathDate = artist.deathDate {
            deathDateString = String(deathDate)
        }
        
        self.birthDate = birthDateString
        self.deathDate = deathDateString
    }
}
