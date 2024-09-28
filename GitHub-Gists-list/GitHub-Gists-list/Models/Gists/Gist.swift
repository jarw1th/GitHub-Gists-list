//
//  Gist.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import Foundation

struct Gist: Decodable {
    
    let id: String
    let description: String?
    let owner: Owner
    let files: [String: GistFile]
    
}
