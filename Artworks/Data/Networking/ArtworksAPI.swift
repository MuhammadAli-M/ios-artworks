//
//  ArtworksAPI.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//

import Foundation

struct ArtworksRequest: Encodable {
    let page: Int
}


// MARK: - ArtworksListResponse
class ArtworksListResponse: Codable {
    let pagination: Pagination
    let data: [ArtworkResponse]
    let info: Info
    let config: Config

    init(pagination: Pagination, data: [ArtworkResponse], info: Info, config: Config) {
        self.pagination = pagination
        self.data = data
        self.info = info
        self.config = config
    }

    func toDomain() -> [Artwork]{
        return data.map { artworkResponse in
            
            let desc = artworkResponse.styleTitles.reduce("") { $0 + $1}
            let imageURLString = artworkResponse.imageID ?? artworkResponse.altImageIDS.compactMap{ $0 }.first ?? ""
            return Artwork(id:artworkResponse.id,
                           title: artworkResponse.title,
                           placeOfOrigin: artworkResponse.placeOfOrigin ?? "",
                           desc: desc,
                           dateDisplay: artworkResponse.dateDisplay,
                           imageId: imageURLString,
                           artistId: artworkResponse.artistID,
                           artistTitle: artworkResponse.artistTitle)
        }
    }
}

// MARK: - Config
class Config: Codable {
    let iiifURL: String
    let websiteURL: String

    enum CodingKeys: String, CodingKey {
        case iiifURL = "iiif_url"
        case websiteURL = "website_url"
    }

    init(iiifURL: String, websiteURL: String) {
        self.iiifURL = iiifURL
        self.websiteURL = websiteURL
    }
}

// MARK: - ArtworkResponse
struct ArtworkResponse: Codable {
    let id: Int
//    let apiModel: String
//    let apiLink: String
//    let isBoosted: Bool
    let title: String
//    let altTitles: [String]?
//    let thumbnail: Thumbnail?
//    let mainReferenceNumber: String
//    let hasNotBeenViewedMuch: Bool
//    let boostRank: Double?
//    let dateStart, dateEnd: Int
    let dateDisplay: String
//    let dateQualifierTitle: DateQualifierTitle
//    let dateQualifierID: Int?
//    let artistDisplay: String
    let placeOfOrigin: String?
//    let dimensions, mediumDisplay: String
//    let inscriptions: String?
//    let creditLine: String
//    let publicationHistory, exhibitionHistory, provenanceText: String?
//    let publishingVerificationLevel: PublishingVerificationLevel
//    let internalDepartmentID: Int
//    let fiscalYear: Int?
//    let fiscalYearDeaccession: Int?
//    let isPublicDomain, isZoomable: Bool
//    let maxZoomWindowSize: Int
//    let copyrightNotice: String?
//    let hasMultimediaResources, hasEducationalResources: Bool
//    let colorfulness: Double?
//    let color: Color?
//    let latitude, longitude: Double?
//    let latlon: String?
//    let isOnView: Bool
//    let onLoanDisplay: String?
//    let galleryTitle: String?
//    let galleryID: Int?
//    let artworkTypeTitle: String
//    let artworkTypeID: Int
    let departmentTitle: String?
//    let departmentID: String
    let artistID: Int?
    let artistTitle: String?
//    let altArtistIDS, artistIDS: [String?]
//    let artistTitles, categoryIDS, categoryTitles: [String]
//    let artworkCatalogueIDS: [String?]
//    let termTitles: [String]
//    let styleID, styleTitle: String?
//    let altStyleIDS, styleIDS: [String]
    let styleTitles: [String]
//    let classificationID, classificationTitle: String
//    let altClassificationIDS, classificationIDS, classificationTitles: [String]
//    let subjectID: String?
//    let altSubjectIDS, subjectIDS, subjectTitles: [String]
//    let materialID: String?
//    let altMaterialIDS, materialIDS, materialTitles: [String]
//    let techniqueID: String?
//    let altTechniqueIDS: [String?]
//    let techniqueIDS, techniqueTitles, themeTitles: [String]
    let imageID: String?
    let altImageIDS: [String?]
//    let documentIDS, soundIDS, videoIDS, textIDS: [String?]
//    let sectionIDS, sectionTitles, siteIDS: [String?]
//    let suggestAutocompleteAll: [SuggestAutocompleteAll]
//    let lastUpdatedSource, lastUpdated, timestamp: String?
//    let suggestAutocompleteBoosted: String?

    enum CodingKeys: String, CodingKey {
        case id
//        case apiModel = "api_model"
//        case apiLink = "api_link"
//        case isBoosted = "is_boosted"
        case title
//        case altTitles = "alt_titles"
//        case thumbnail
//        case mainReferenceNumber = "main_reference_number"
//        case hasNotBeenViewedMuch = "has_not_been_viewed_much"
//        case boostRank = "boost_rank"
//        case dateStart = "date_start"
//        case dateEnd = "date_end"
        case dateDisplay = "date_display"
//        case dateQualifierTitle = "date_qualifier_title"
//        case dateQualifierID = "date_qualifier_id"
//        case artistDisplay = "artist_display"
        case placeOfOrigin = "place_of_origin"
//        case dimensions
//        case mediumDisplay = "medium_display"
//        case inscriptions
//        case creditLine = "credit_line"
//        case publicationHistory = "publication_history"
//        case exhibitionHistory = "exhibition_history"
//        case provenanceText = "provenance_text"
//        case publishingVerificationLevel = "publishing_verification_level"
//        case internalDepartmentID = "internal_department_id"
//        case fiscalYear = "fiscal_year"
//        case fiscalYearDeaccession = "fiscal_year_deaccession"
//        case isPublicDomain = "is_public_domain"
//        case isZoomable = "is_zoomable"
//        case maxZoomWindowSize = "max_zoom_window_size"
//        case copyrightNotice = "copyright_notice"
//        case hasMultimediaResources = "has_multimedia_resources"
//        case hasEducationalResources = "has_educational_resources"
//        case colorfulness, color, latitude, longitude, latlon
//        case isOnView = "is_on_view"
//        case onLoanDisplay = "on_loan_display"
//        case galleryTitle = "gallery_title"
//        case galleryID = "gallery_id"
//        case artworkTypeTitle = "artwork_type_title"
//        case artworkTypeID = "artwork_type_id"
        case departmentTitle = "department_title"
//        case departmentID = "department_id"
        case artistID = "artist_id"
        case artistTitle = "artist_title"
//        case altArtistIDS = "alt_artist_ids"
//        case artistIDS = "artist_ids"
//        case artistTitles = "artist_titles"
//        case categoryIDS = "category_ids"
//        case categoryTitles = "category_titles"
//        case artworkCatalogueIDS = "artwork_catalogue_ids"
//        case termTitles = "term_titles"
//        case styleID = "style_id"
//        case styleTitle = "style_title"
//        case altStyleIDS = "alt_style_ids"
//        case styleIDS = "style_ids"
        case styleTitles = "style_titles"
//        case classificationID = "classification_id"
//        case classificationTitle = "classification_title"
//        case altClassificationIDS = "alt_classification_ids"
//        case classificationIDS = "classification_ids"
//        case classificationTitles = "classification_titles"
//        case subjectID = "subject_id"
//        case altSubjectIDS = "alt_subject_ids"
//        case subjectIDS = "subject_ids"
//        case subjectTitles = "subject_titles"
//        case materialID = "material_id"
//        case altMaterialIDS = "alt_material_ids"
//        case materialIDS = "material_ids"
//        case materialTitles = "material_titles"
//        case techniqueID = "technique_id"
//        case altTechniqueIDS = "alt_technique_ids"
//        case techniqueIDS = "technique_ids"
//        case techniqueTitles = "technique_titles"
//        case themeTitles = "theme_titles"
        case imageID = "image_id"
        case altImageIDS = "alt_image_ids"
//        case documentIDS = "document_ids"
//        case soundIDS = "sound_ids"
//        case videoIDS = "video_ids"
//        case textIDS = "text_ids"
//        case sectionIDS = "section_ids"
//        case sectionTitles = "section_titles"
//        case siteIDS = "site_ids"
//        case suggestAutocompleteAll = "suggest_autocomplete_all"
//        case lastUpdatedSource = "last_updated_source"
//        case lastUpdated = "last_updated"
//        case timestamp
//        case suggestAutocompleteBoosted = "suggest_autocomplete_boosted"
    }
}

// MARK: - Color
class Color: Codable {
    let h, l, s: Int
    let percentage: Double
    let population: Int

    init(h: Int, l: Int, s: Int, percentage: Double, population: Int) {
        self.h = h
        self.l = l
        self.s = s
        self.percentage = percentage
        self.population = population
    }
}

enum DateQualifierTitle: String, Codable {
    case empty = ""
    case made = "Made"
}

enum PublishingVerificationLevel: String, Codable {
    case webBasic = "Web Basic"
    case webCataloged = "Web Cataloged"
    case webEverything = "Web Everything"
}

// MARK: - SuggestAutocompleteAll
class SuggestAutocompleteAll: Codable {
    let input: [String]
    let contexts: Contexts
    let weight: Int?

    init(input: [String], contexts: Contexts, weight: Int?) {
        self.input = input
        self.contexts = contexts
        self.weight = weight
    }
}

// MARK: - Contexts
class Contexts: Codable {
    let groupings: [Grouping]

    init(groupings: [Grouping]) {
        self.groupings = groupings
    }
}

enum Grouping: String, Codable {
    case accession = "accession"
    case title = "title"
}

// MARK: - Thumbnail
class Thumbnail: Codable {
    let lqip: String
    let width, height: Int
    let altText: String

    enum CodingKeys: String, CodingKey {
        case lqip, width, height
        case altText = "alt_text"
    }

    init(lqip: String, width: Int, height: Int, altText: String) {
        self.lqip = lqip
        self.width = width
        self.height = height
        self.altText = altText
    }
}

// MARK: - Info
class Info: Codable {
    let licenseText: String
    let licenseLinks: [String]
    let version: String

    enum CodingKeys: String, CodingKey {
        case licenseText = "license_text"
        case licenseLinks = "license_links"
        case version
    }

    init(licenseText: String, licenseLinks: [String], version: String) {
        self.licenseText = licenseText
        self.licenseLinks = licenseLinks
        self.version = version
    }
}

// MARK: - Pagination
class Pagination: Codable {
    let total, limit, offset, totalPages: Int
    let currentPage: Int
    let nextURL: String

    enum CodingKeys: String, CodingKey {
        case total, limit, offset
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextURL = "next_url"
    }

    init(total: Int, limit: Int, offset: Int, totalPages: Int, currentPage: Int, nextURL: String) {
        self.total = total
        self.limit = limit
        self.offset = offset
        self.totalPages = totalPages
        self.currentPage = currentPage
        self.nextURL = nextURL
    }
}



