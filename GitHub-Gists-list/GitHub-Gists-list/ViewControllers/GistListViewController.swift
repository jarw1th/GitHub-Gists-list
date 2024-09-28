//
//  GistListViewController.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit

final class GistListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: GistListViewModelProtocol // View model for managing gist data
    private let tableView = UITableView() // Table view for displaying the list of gists
    private let refreshControl = UIRefreshControl() // Control for pull-to-refresh functionality
    
    // MARK: - Initialization
    // Initializer that sets up the view model
    init() {
        self.viewModel = GistListViewModel() // Initialize the view model
        super.init(nibName: nil, bundle: nil)
    }
    
    // Required initializer for using Interface Builder, not implemented
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView() // Set up the table view
        fetchGists() // Fetch the initial list of gists
    }
    
    // MARK: - UI Setup
    // Function to set up the table view properties and add it to the main view
    private func setupTableView() {
        tableView.delegate = self // Set the delegate for table view
        tableView.dataSource = self // Set the data source for table view
        tableView.register(GistCell.self, forCellReuseIdentifier: GistCell.identifier) // Register cell class
        
        view.addSubview(tableView) // Add table view to the main view
        tableView.frame = view.bounds // Set table view to fill the view
        tableView.rowHeight = UITableView.automaticDimension // Enable automatic row height
        tableView.estimatedRowHeight = UITableView.automaticDimension // Set estimated row height
        
        // Configure refresh control
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl // Assign refresh control to table view
    }
    
    // Function to fetch gists using the view model
    private func fetchGists() {
        viewModel.fetchGists(true) { // Fetch initial gists
            DispatchQueue.main.async {
                self.tableView.reloadData() // Reload table view data
                self.refreshControl.endRefreshing() // End refreshing state
            }
        }
    }
    
    // MARK: - Actions
    // Action for refreshing the data when the user pulls down
    @objc private func refreshData() {
        viewModel.resetPage() // Reset pagination
        fetchGists() // Fetch gists again
    }
    
    // Function to load more gists when the user scrolls to the bottom
    private func loadMoreGists() {
        viewModel.increasePage() // Increase the current page number
        viewModel.fetchGists(false) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData() // Reload table view with new gists
            }
        }
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
// Extension to conform to table view delegate and data source protocols
extension GistListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Function to return the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gists.count // Return count of gists
    }
    
    // Function to configure each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GistCell.identifier, for: indexPath) as! GistCell
        if viewModel.gists.count > indexPath.row {
            let gist = viewModel.gists[indexPath.row] // Get the gist for the current row
            cell.configure(with: gist) // Configure the cell with gist data
        }
        return cell // Return the configured cell
    }
    
    // Function called when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gist = viewModel.gists[indexPath.row] // Get the selected gist
        let detailVC = GistDetailViewController(gist: gist) // Create detail view controller
        navigationController?.pushViewController(detailVC, animated: true) // Navigate to detail view
    }
    
    // Function called when the user scrolls
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y // Get current vertical offset
        let contentHeight = scrollView.contentSize.height // Get total content height

        // Check if the user scrolled to the bottom
        if offsetY > contentHeight - scrollView.frame.size.height {
            loadMoreGists() // Load more gists if at the bottom
        }
    }
    
}
