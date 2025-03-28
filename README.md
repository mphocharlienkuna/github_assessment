# GitHub Accounts

A Flutter application that allows users to search for GitHub accounts, view their profiles, manage their liked accounts, and explore their repositories. The app incorporates retry functionality, local storage with Hive, and user-friendly error handling.

## Features

- **Search GitHub Users**: Search for GitHub accounts by username.
- **View Profile**: Display user details, including their name, bio, followers, following, and repositories.
- **View Repositories**: Display a list of repositories for a specific GitHub user.
- **Like/Unlike Accounts**: Store liked GitHub accounts locally using Hive.
- **Retry Mechanism**: Retry failed network requests with a custom retry service.
- **Network Error Handling**: User-friendly error messages for network issues.
- **Local Caching**: Cache liked accounts using Hive for offline access.

## Project Structure

### Folder Breakdown

- **`android/`** & **`ios/`**:
    - Platform-specific files for Android and iOS.

- **`lib/`**:
    - This is the main directory containing all Dart files for the application.

- **`config/`**:
  - Contains configuration files that handle app-specific settings.
     - **`app_theme.dart`**: Defines the app's light and dark themes.
     - **`env.dart`**: Manages environment configurations, like API keys.
     - **`router.dart`**: Handles navigation and routing logic for the app.
- **`core/`**:
    - Contains reusable code and utilities that are shared across different features:
        - **`constants/`**: Stores constant values like API URLs, app settings.
        - **`error/`**: Contains custom exceptions and error handling classes.
        - **`network/`**: Contains the Dio client setup and network-related logic.
        - **`utils/`**: Helper functions like logging, retry logic, etc.

- **`features/`**:
    - This folder contains individual feature modules for GitHub account management:
        - **`github_accounts/`**: This is the folder for GitHub account management functionality.
            - **`data/`**: Contains models, repositories, and services related to fetching GitHub data.
            - **`domain/`**: Contains entities, repositories (abstract), and use cases (business logic).
            - **`presentation/`**: Contains UI components:
                - **`blocs/`**: BLoC files to manage the app's state.
                - **`screens/`**: UI screens related to GitHub accounts.
                - **`widgets/`**: Reusable widgets related to the GitHub feature.

- **`main.dart`**:
    - The entry point of the application where the `MyApp` widget is initialized and run.

## Setup

### Prerequisites

- Flutter SDK installed.
- Android Studio or Visual Studio Code for development.

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/mphocharlienkuna/github_assessment.git
    cd github_assessment
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Ensure Flutter is set up:
    ```bash
    flutter doctor
    ```

4. Open an Android/iOS emulator or connect a device.

5. Run the app:
    ```bash
    flutter run
    ```

### Environment Configuration

1. Create a `.env` file at the root of your project.
2. Add your GitHub API key or other configurations in the `.env` file:
    ```
    GITHUB_TOKEN=your_api_key_here
    ```

### Database Setup

This app uses Hive to store liked GitHub accounts locally. The necessary Hive boxes are initialized at the start of the app.

- The `AppConstants.likedAccountsBox` box stores liked GitHub accounts.
- The `AppConstants.recentSearchesBox` box stores recent search queries.

## Usage

### Searching for GitHub Users

- The app allows users to search for GitHub users by their username. The search results will show the user’s name, bio, repositories, followers, etc.

### Liking and Unliking Accounts

- Users can like GitHub accounts, which will store their details in the local database (Hive).
- Liked accounts will be displayed in the "Liked Accounts" section of the home screen.
- Users can also unlike accounts, which removes them from the list.

### Viewing Account Details

- Tapping on a user in the search results will navigate to a detailed view of the user's profile, including their repositories.

### Error Handling and Retry Mechanism

- The app includes retry functionality for network requests. If a request fails, the app will retry the request a few times before showing an error message.
- All network-related errors will display user-friendly error messages.

### Screenshots
| **Android** | **IOS** |
|---|---|
|<img src="https://github.com/user-attachments/assets/da08d1c9-195b-4978-83a7-65e37b4bee8d" width="300"/>|<img src="https://github.com/user-attachments/assets/93fe749b-5510-4692-a849-d1da744d872d" width="300"/>|
|<img src="https://github.com/user-attachments/assets/dbe448e5-bfb3-4ad4-86e3-100d6b5b56c6" width="300"/>|<img src="https://github.com/user-attachments/assets/33fadfd0-e44a-4aaf-b01e-4a15fbbf0aa7" width="300"/>|
|<img src="https://github.com/user-attachments/assets/bb54161a-0bd2-48bc-94f4-095937275dd0" width="300"/>|<img src="https://github.com/user-attachments/assets/5fac8ff1-cf66-430d-b8a8-cfdafd6120cd" width="300"/>|
|<img src="https://github.com/user-attachments/assets/81c08807-6b0d-4140-827e-0720ccde76b1" width="300"/>|<img src="https://github.com/user-attachments/assets/5602979e-4b9b-48b2-b2aa-6d63270caf3a" width="300"/>|
|<img src="https://github.com/user-attachments/assets/3aec69ac-851b-4b58-9cbd-061789f7d490" width="300"/>|<img src="https://github.com/user-attachments/assets/170b8a02-0372-4cf8-be9e-2a53403dacfa" width="300"/>|
|<img src="https://github.com/user-attachments/assets/66df88a0-775f-402b-abae-94edfacab8b4" width="300"/>|<img src="https://github.com/user-attachments/assets/678e9aa0-04c3-4461-bd17-8a234b7aa063" width="300"/>|
|  |  |
