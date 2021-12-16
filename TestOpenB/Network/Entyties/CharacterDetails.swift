import Foundation

// MARK: - CharactersDetails
struct CharacterDetails: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

