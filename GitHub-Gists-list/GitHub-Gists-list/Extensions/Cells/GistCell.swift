//
//  Untitled.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit

final class GistCell: UITableViewCell {
    
    // MARK: - Identifier
    // Unique identifier for the cell to be reused in the UITableView
    static let identifier = "GistCell"
    
    // MARK: - UI Elements
    // authorAvatarImageView: Displays the avatar of the gist owner
    private let authorAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // Fill the image view without distortion
        imageView.clipsToBounds = true // Ensures the image doesn't overflow the bounds
        imageView.translatesAutoresizingMaskIntoConstraints = false // Disables autoresizing mask
        imageView.layer.cornerRadius = 20 // Adds rounded corners to the image view
        return imageView
    }()
    
    // authorNameLabel: Displays the name of the gist owner
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16) // Bold font, size 16
        label.translatesAutoresizingMaskIntoConstraints = false // Disables autoresizing mask
        return label
    }()
    
    // gistTitleLabel: Displays the title or description of the gist
    private let gistTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14) // Regular font, size 14
        label.numberOfLines = 0 // Allows for multiple lines in case the description is long
        label.translatesAutoresizingMaskIntoConstraints = false // Disables autoresizing mask
        return label
    }()
    
    // MARK: - Init Methods
    // Initializes the cell programmatically
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI() // Calls the function to set up UI elements
    }
    
    // Required init for using NSCoder, not implemented in this case
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    // setupUI: Adds the UI elements to the cell's content view and sets constraints
    private func setupUI() {
        contentView.addSubview(authorAvatarImageView) // Adds avatar image view to the cell
        contentView.addSubview(authorNameLabel) // Adds name label to the cell
        contentView.addSubview(gistTitleLabel) // Adds gist description label to the cell

        // Layout constraints to position the elements within the cell
        NSLayoutConstraint.activate([
            authorAvatarImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            authorAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            authorAvatarImageView.widthAnchor.constraint(equalToConstant: 20), // Fixed width for avatar
            authorAvatarImageView.heightAnchor.constraint(equalToConstant: 20), // Fixed height for avatar
            
            authorNameLabel.centerYAnchor.constraint(equalTo: authorAvatarImageView.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorAvatarImageView.trailingAnchor, constant: 10), // Position name next to avatar
            
            gistTitleLabel.centerYAnchor.constraint(equalTo: authorAvatarImageView.centerYAnchor),
            gistTitleLabel.leadingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor, constant: 40), // Position title next to name
            gistTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10) // Align title to the right
        ])
    }
    
    // MARK: - Configure Method
    // configure: Populates the cell with data from a Gist object
    func configure(with gist: Gist) {
        gistTitleLabel.text = gist.description ?? "No Description" // Set the description or fallback to default
        authorNameLabel.text = gist.owner.login ?? "No Login" // Set the author's login or fallback to default
        
        // Check if the avatar is cached, otherwise load it from the URL
        gist.owner.avatarUrl.setCachedImage(authorAvatarImageView)
    }
    
}
