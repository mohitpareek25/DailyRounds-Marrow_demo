//
//  BookDetails.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import Foundation

struct NovelDetails : Codable {
    let description : Description?
    let title : String?
    let first_publish_date : String?
    let key : String?

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case title = "title"
        case first_publish_date = "first_publish_date"
        case key = "key"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(Description.self, forKey: .description)
        
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first_publish_date = try values.decodeIfPresent(String.self, forKey: .first_publish_date)
        key = try values.decodeIfPresent(String.self, forKey: .key)
    }

}


struct Description: Codable {
    let type : String?
    let value : String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

