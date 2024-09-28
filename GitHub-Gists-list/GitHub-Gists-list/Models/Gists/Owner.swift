//
//  Owner.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import Foundation

struct Owner: Decodable {
    
    let login: String?
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
    
}
