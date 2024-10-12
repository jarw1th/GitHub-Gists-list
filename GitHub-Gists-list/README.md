# Github Gists List

This is a simple iOS application developed as a test task for Astrosoft. It displays a list of characters from the popular TV show "Rick and Morty" by fetching data from the *GitHub*.

## Features

- Fetches a list of gists from [GitHub API](https://api.github.com/).
- Displays detailed information about each gist.
- Retrieves and displays the commits associated with each gist.

## Technologies Used

- Swift
- UIKit
- MVVM architecture
- URLSession for API requests

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/jarw1th/GitHub-Gists-list.git
2. Open the project in Xcode:

 - Navigate to the project directory and open GitHub-Gists-list.xcodeproj.
3. Run the project:
- Select a simulator or connect a device, then click the Run button in Xcode.

## Usage
- Launch the app to see a list of gists..
- Tap on any gist to view detailed information and its associated commits.

## Architecture
This project follows the MVVM (Model-View-ViewModel) architecture to separate concerns and improve maintainability:

- Model: Represents the data structures (e.g., Gist, Commit).
- View: User interface components (e.g., GistListViewController, GistDetailViewController).
- ViewModel: Provides the data and logic for the views (e.g., ViewModel).

## Contributing
If you want to contribute to this project, feel free to fork the repository and submit a pull request. Please ensure your code follows the project's coding standarts.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
For inquiries, please contact:

- Name: Руслан Парастаев
- Email: [parastaev31@gmail.com]
