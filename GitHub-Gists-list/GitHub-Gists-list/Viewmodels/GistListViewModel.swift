//
//  GistListViewModel.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import Foundation

protocol GistListViewModelProtocol {
    
    var gists: [Gist] { get } // Array of Gist objects
    var currentPage: Int { get } // Current page for pagination
    
    func fetchGists(_ isNew: Bool, completion: @escaping () -> Void) // Fetch Gists with pagination
    func increasePage() // Increment current page
    func resetPage() // Reset current page to 1
}

final class GistListViewModel: GistListViewModelProtocol {
    
    // MARK: - Properties
    var gists: [Gist] = [] // Array to hold fetched gists
    var currentPage = 1 // Pagination tracker
    
    // MARK: - Fetching Gists
    func fetchGists(_ isNew: Bool, completion: @escaping () -> Void) {
        if isNew {
            self.gists = [] // Clear existing gists if fetching new ones
        }
        NetworkService.shared.fetchGists(page: currentPage) { result in
            switch result {
            case .success(let newGists):
                self.gists.append(contentsOf: newGists) // Append new gists to the array
                completion() // Notify completion
            case .failure(let error):
                print("Error fetching gists: \(error)") // Log error
                completion() // Notify completion even on failure
            }
        }
    }
    
    // MARK: - Pagination Control
    func increasePage() {
        self.currentPage += 1 // Increment page number
    }
    
    func resetPage() {
        self.currentPage = 1 // Reset to first page
    }
}
