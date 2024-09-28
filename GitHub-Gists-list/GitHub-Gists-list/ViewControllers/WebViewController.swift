//
//  WebViewController.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: - Properties
    private let webView = WKWebView() // WKWebView for displaying web content

    // MARK: - Initialization
    // Initializer that accepts a URL string
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        if let requestUrl = URL(string: url) { // Convert string to URL
            let request = URLRequest(url: requestUrl) // Create URL request
            webView.load(request) // Load the request in the web view
        }
    }
    
    // Required initializer for using Interface Builder, not implemented
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView) // Add web view to the main view
        webView.frame = view.bounds // Set web view to fill the entire view
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Adjusts with view size changes
    }
    
}
