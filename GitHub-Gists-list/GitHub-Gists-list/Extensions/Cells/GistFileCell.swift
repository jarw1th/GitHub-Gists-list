//
//  GistFileCell.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit

final class GistFileCell: UICollectionViewCell {
    
    // MARK: - Identifier
    // Unique identifier for cell reuse in UICollectionView
    static let identifier = "GistFileCell"
    
    // MARK: - UI Elements
    // fileLabel: Label to display the file name of the gist
    private let fileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14) // Regular font, size 14
        label.numberOfLines = 5 // Allow multiple lines for longer filenames
        label.translatesAutoresizingMaskIntoConstraints = false // Disables autoresizing mask
        return label
    }()

    // MARK: - Init Methods
    // Initializes the cell programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI() // Set up UI elements when the cell is initialized
    }
    
    // Required init for using NSCoder, not implemented in this case
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    // setupUI: Adds the label to the content view and positions it within the cell
    private func setupUI() {
        contentView.addSubview(fileLabel) // Adds the fileLabel to the cell's content view
        fileLabel.frame = contentView.frame // Sets the label to fill the entire content view
    }
    
    // MARK: - Configure Method
    // configure: Populates the cell with data from a GistFile object
    func configure(with gistFile: GistFile) {
        fileLabel.text = gistFile.filename // Displays the filename of the gist file
    }
    
}
