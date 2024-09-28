//
//  CommitCell.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit

final class CommitCell: UICollectionViewCell {
    
    // MARK: - Variables
    // identifier: Reuse identifier for the CommitCell
    static let identifier = "CommitCell"
    
    // commitLabel: Label that presents the URL of the commit
    private let commitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14) // Font size of 14 for commitLabel
        label.numberOfLines = 5 // Up to 5 lines for longer URLs
        label.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        return label
    }()

    // MARK: - Init
    // Custom initializer for the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI() // Set up the UI when the cell is initialized
    }
    
    // Required init for using NSCoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // setupUI: Sets up the UI elements for the cell
    private func setupUI() {
        contentView.addSubview(commitLabel) // Add commitLabel to the cell's content view
        commitLabel.frame = contentView.frame // Make commitLabel fill the entire content view
    }
    
    // configure: Configures the cell with commit data
    func configure(with commit: Commit) {
        commitLabel.text = commit.url // Set the label's text to the commit URL
    }
    
}
