//
//  Commit.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import Foundation

struct Commit: Decodable {
    
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case url
    }
    
}
