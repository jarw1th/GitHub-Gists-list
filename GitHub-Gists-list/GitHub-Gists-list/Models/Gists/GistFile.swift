//
//  GistFile.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import Foundation

struct GistFile: Decodable {
    
    let filename: String
    let type: String
    let rawUrl: String
    
    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case rawUrl = "raw_url"
    }
    
}
