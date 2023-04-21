import Foundation

struct List: Codable {
    let workCount: Int
    let works: [Book]
    
    enum CodingKeys: String, CodingKey {
        case workCount = "work_count"
        case works
    }
}

struct Book: Codable {
    let key, title: String
    let coverID: Int
    let authors: [Author]
    let firstPublishYear: Int
    
    enum CodingKeys: String, CodingKey {
        case key, title
        case coverID = "cover_id"
        case authors
        case firstPublishYear = "first_publish_year"
    }
}

struct Author: Codable {
    let key, name: String
}

struct Details: Codable {
    let title, key: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case title, key, description
    }
}

