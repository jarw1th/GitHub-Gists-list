//
//  GistDetailViewController.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit

final class GistDetailViewController: UIViewController {
    
    // MARK: - Properties
    // View model for handling the logic of the Gist detail view
    private let viewModel: GistDetailViewModelProtocol
    
    // Refresh control for pull-to-refresh functionality
    private let refreshControl = UIRefreshControl()
    
    // Collection view for displaying gist files
    private let filesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // Collection view for displaying commits related to the gist
    private let commitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // Image view for displaying the author's avatar
    private let authorAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    // Label for displaying the author's name
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Label for displaying the gist title or description
    private let gistTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialization
    // Initializer that takes a Gist object and sets up the view model
    init(gist: Gist) {
        self.viewModel = GistDetailViewModel(gist: gist)
        super.init(nibName: nil, bundle: nil)
        
        // Set up the collection views
        setupCollectionView(filesCollectionView)
        setupCollectionView(commitsCollectionView)
        
        // Register cell classes
        filesCollectionView.register(GistFileCell.self, forCellWithReuseIdentifier: GistFileCell.identifier)
        commitsCollectionView.register(CommitCell.self, forCellWithReuseIdentifier: CommitCell.identifier)
        
        // Configure refresh control
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        commitsCollectionView.refreshControl = refreshControl
    }
    
    // Required initializer for using Interface Builder, not implemented
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Set up the UI elements
        fetchCommits() // Fetch commits for the gist
    }
    
    // MARK: - UI Setup
    // Function to set up the collection view properties
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self // Set delegate
        collectionView.dataSource = self // Set data source
        collectionView.backgroundColor = .systemBackground
        collectionView.layer.borderColor = UIColor.systemBlue.cgColor
        collectionView.layer.borderWidth = 1
   }
    
    // Function to set up UI elements on the screen
    private func setupUI() {
        // Set the title of the navigation bar
        title = viewModel.gist.description
        view.backgroundColor = .systemBackground
        
        // Add subviews to the main view
        view.addSubview(authorAvatarImageView)
        view.addSubview(authorNameLabel)
        view.addSubview(gistTitleLabel)
        view.addSubview(filesCollectionView)
        view.addSubview(commitsCollectionView)

        // Set up constraints for the UI elements
        NSLayoutConstraint.activate([
            authorAvatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            authorAvatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            authorAvatarImageView.widthAnchor.constraint(equalToConstant: 40),
            authorAvatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            authorNameLabel.centerYAnchor.constraint(equalTo: authorAvatarImageView.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorAvatarImageView.trailingAnchor, constant: 10),
            authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            gistTitleLabel.topAnchor.constraint(equalTo: authorAvatarImageView.bottomAnchor, constant: 5),
            gistTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            gistTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            filesCollectionView.topAnchor.constraint(equalTo: gistTitleLabel.bottomAnchor, constant: 10),
            filesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            filesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            filesCollectionView.heightAnchor.constraint(equalToConstant: 150),
           
            commitsCollectionView.topAnchor.constraint(equalTo: filesCollectionView.bottomAnchor, constant: 10),
            commitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            commitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            commitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
        // Load the author's avatar image from the cache or fetch it
        viewModel.gist.owner.avatarUrl.setCachedImage(authorAvatarImageView)
        
        // Set the author name and gist title labels
        authorNameLabel.text = viewModel.gist.owner.login
        gistTitleLabel.text = viewModel.gist.description
    }
    
    // Function to fetch commits for the gist using the view model
    private func fetchCommits() {
        viewModel.fetchCommits {
            DispatchQueue.main.async {
                self.commitsCollectionView.reloadData() // Reload collection view with new data
                self.refreshControl.endRefreshing() // End refreshing
            }
        }
    }
    
    // MARK: - Actions
    // Action for refreshing the data
    @objc private func refreshData() {
        fetchCommits() // Fetch commits again
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
// Extension to conform to collection view delegate and data source protocols
extension GistDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Function to return the number of items in each section of the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filesCollectionView {
            return viewModel.files.count // Return count of files for files collection view
        } else {
            return viewModel.commits.count // Return count of commits for commits collection view
        }
    }
    
    // Function to configure each cell in the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GistFileCell.identifier, for: indexPath) as! GistFileCell
            let file = viewModel.files[indexPath.item]
            cell.configure(with: file) // Configure the cell with the gist file data
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommitCell.identifier, for: indexPath) as! CommitCell
            let commit = viewModel.commits[indexPath.item]
            cell.configure(with: commit) // Configure the cell with the commit data
            return cell
        }
    }
    
    // Function called when a cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filesCollectionView {
            let file = viewModel.files[indexPath.item]
            showFileContent(file) // Show the file content when a file is selected
        }
    }
    
    // Function to present a web view for the selected file
    private func showFileContent(_ file: GistFile) {
        let webVC = WebViewController(url: file.rawUrl) // Create web view controller with file URL
        navigationController?.present(webVC, animated: true) // Present web view controller
    }
    
}
