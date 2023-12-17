//
//  Docs.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 16/12/23.
//

import Foundation
struct Docs: Codable {
    let title : String?
    let ratings_average : Double?
    let ratings_count : Int?
    let cover_i : Int?
    let author_name : [String]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case ratings_average = "ratings_average"
        case ratings_count = "ratings_count"
        case cover_i = "cover_i"
        case author_name = "author_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        ratings_average = try values.decodeIfPresent(Double.self, forKey: .ratings_average)
        ratings_count = try values.decodeIfPresent(Int.self, forKey: .ratings_count)
        cover_i = try values.decodeIfPresent(Int.self, forKey: .cover_i)
        author_name = try values.decodeIfPresent([String].self, forKey: .author_name)
    }

}
