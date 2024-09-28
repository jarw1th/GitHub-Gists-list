//
//  GistDetailViewModel.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import Foundation

protocol GistDetailViewModelProtocol {
    
    var gist: Gist { get } // The gist being detailed
    var files: [GistFile] { get } // List of files associated with the gist
    var commits: [Commit] { get } // List of commits associated with the gist
    
    func fetchCommits(completion: @escaping () -> Void) // Fetch commits and call completion
}

final class GistDetailViewModel: GistDetailViewModelProtocol {
    
    // MARK: - Properties
    let gist: Gist // The Gist object
    let files: [GistFile] // Array of GistFile objects
    
    var commits: [Commit] = [] // Array to store fetched commits
    
    // MARK: - Initialization
    init(gist: Gist) {
        self.gist = gist
        self.files = Array(gist.files.values.prefix(5)) // Limit to first 5 files
    }
    
    // MARK: - Fetching Commits
    func fetchCommits(completion: @escaping () -> Void) {
        self.commits = [] // Clear existing commits before fetching new ones
        NetworkService.shared.fetchCommits(gist: gist) { result in
            switch result {
            case .success(let newCommits):
                self.commits.append(contentsOf: newCommits) // Append new commits to the list
                completion() // Notify completion
            case .failure(let error):
                print("Error fetching commits: \(error)") // Log error
                completion() // Notify completion even on failure
            }
        }
    }
    
}

