//
//  Books.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 16/12/23.
//

import Foundation

struct Books : Codable {
    let numFound : Int?
    let start : Int?
    let numFoundExact : Bool?
    let docs : [Docs]?
    let num_found : Int?
    let q : String?
    let offset : Int?

    enum CodingKeys: String, CodingKey {

        case numFound = "numFound"
        case start = "start"
        case numFoundExact = "numFoundExact"
        case docs = "docs"
        case num_found = "num_found"
        case q = "q"
        case offset = "offset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        numFound = try values.decodeIfPresent(Int.self, forKey: .numFound)
        start = try values.decodeIfPresent(Int.self, forKey: .start)
        numFoundExact = try values.decodeIfPresent(Bool.self, forKey: .numFoundExact)
        docs = try values.decodeIfPresent([Docs].self, forKey: .docs)
        num_found = try values.decodeIfPresent(Int.self, forKey: .num_found)
        q = try values.decodeIfPresent(String.self, forKey: .q)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }

}
