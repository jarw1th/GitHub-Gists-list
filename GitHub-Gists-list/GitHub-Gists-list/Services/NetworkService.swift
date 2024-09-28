//
//  NetworkService.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import Foundation

final class NetworkService {
    
    // MARK: - Singleton Instance
    // Shared instance of NetworkService for global access
    static let shared = NetworkService()
    
    // MARK: - Initialization
    // Private initializer to prevent creating multiple instances
    private init() {}
    
    // MARK: - Fetch Gists
    // Function to fetch public gists for a specific page
    func fetchGists(page: Int, completion: @escaping (Result<[Gist], Error>) -> Void) {
        // Construct the URL for fetching public gists
        guard let url = URL(string: "https://api.github.com/gists/public?page=\(page)") else { return }
        
        // Call the generic fetch function with the constructed URL
        fetch(url) { (result: Result<[Gist], Error>) in
            completion(result) // Pass the result back to the completion handler
        }
    }
    
    // MARK: - Fetch Commits
    // Function to fetch commits for a specific gist
    func fetchCommits(gist: Gist, completion: @escaping (Result<[Commit], Error>) -> Void) {
        // Construct the URL for fetching commits of the given gist
        guard let url = URL(string: "https://api.github.com/gists/\(gist.id)/commits") else { return }
        
        // Call the generic fetch function with the constructed URL
        fetch(url) { (result: Result<[Commit], Error>) in
            completion(result) // Pass the result back to the completion handler
        }
    }
    
    // MARK: - Generic Fetch Function
    // Private function to perform data tasks and decode JSON into a specified type
    private func fetch<T: Decodable>(_ url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        // Create a data task for the given URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle any error that occurred during the request
            if let error = error {
                completion(.failure(error)) // Pass the error to the completion handler
                return
            }
            
            // Ensure we received data
            guard let data = data else { return }
            
            do {
                // Decode the received data into an array of the specified type
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(decodedData)) // Pass the decoded data to the completion handler
            } catch {
                print("Error decoding: \(error)") // Log any decoding error
                completion(.failure(error)) // Pass the decoding error to the completion handler
            }
        }
        // Start the data task
        task.resume()
    }
    
}
