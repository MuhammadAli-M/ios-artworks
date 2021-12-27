//
//  ArtistInfoAPI.swift
//  Artworks
//
//  Created by Muhammad Adam on 25/12/2021.
//

import Foundation

struct ArtistRequest: Codable{
    let id: String
}

struct ArtistInfoResponse: Codable{
    let data: ArtistInfo
    let info: Info
    let config: Config

    init(data: ArtistInfo, info: Info, config: Config) {
        self.data = data
        self.info = info
        self.config = config
    }
    
    func toDomain() -> Artist{
        return Artist(id: data.id,
                      birthDate: data.birthDate,
                      deathDate: data.deathDate)
    }
}

// MARK: - ArtistInfo
struct ArtistInfo: Codable {
    let id: Int
//    let apiModel: String
//    let apiLink: String
//    let title, sortTitle: String
//    let altTitles: [String]
    let birthDate: Int?
//    let birthPlace: String?
    let deathDate: Int?
//    let deathPlace: String?
//    let dataDescription: String
//    let isLicensingRestricted: Bool?
//    let isArtist: Bool
//    let agentTypeTitle: String
//    let agentTypeID: Int
//    let artworkIDS: [Int]
//    let siteIDS: [String?]
//    let suggestAutocompleteBoosted: SuggestAutocompleteBoosted
//    let suggestAutocompleteAll: SuggestAutocompleteAll
//    let lastUpdatedSource, lastUpdated, timestamp: Date
    
    enum CodingKeys: String, CodingKey {
            case id
//            case apiModel = "api_model"
//            case apiLink = "api_link"
//            case title
//            case sortTitle = "sort_title"
//            case altTitles = "alt_titles"
            case birthDate = "birth_date"
//            case birthPlace = "birth_place"
            case deathDate = "death_date"
//            case deathPlace = "death_place"
//            case dataDescription = "description"
//            case isLicensingRestricted = "is_licensing_restricted"
//            case isArtist = "is_artist"
//            case agentTypeTitle = "agent_type_title"
//            case agentTypeID = "agent_type_id"
//            case artworkIDS = "artwork_ids"
//            case siteIDS = "site_ids"
//            case suggestAutocompleteBoosted = "suggest_autocomplete_boosted"
//            case suggestAutocompleteAll = "suggest_autocomplete_all"
//            case lastUpdatedSource = "last_updated_source"
//            case lastUpdated = "last_updated"
//            case timestamp
        }
}

// MARK: - SuggestAutocompleteBoosted
class SuggestAutocompleteBoosted: Codable {
    let input: [String]
    let weight: Int

    init(input: [String], weight: Int) {
        self.input = input
        self.weight = weight
    }
}
