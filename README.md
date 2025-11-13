# KFH Task - GitHub Repository Browser

A SwiftUI iOS application that displays GitHub public repositories with Clean Architecture implementation and MVVM pattern.

## Features

### 🏛️ Core Features
- **GitHub Repository Browser**: Browse and search public repositories
- **Repository Details**: View detailed information about repositories including owner avatar, name, and full description
- **Developer CV**: Access developer's CV through an info button with tooltip
- **Tutorial Overlay**: Welcome tutorial on first app launch (auto-hides after 2 seconds)
- **Search**: Real-time search functionality for repositories
- **Pull to Refresh**: Refresh repository list with pull-to-refresh gesture

### 🎨 UI/UX Features
- **Clean Interface**: Modern SwiftUI design
- **Image Caching**: Efficient avatar image caching system
- **Error Handling**: User-friendly error alerts

## Architecture

### 🏗️ Clean Architecture
The app follows Clean Architecture principles with clear separation of concerns:

```
├── Core/
│   ├── Components/           # Reusable UI components
│   ├── Configuration/        # App configuration management
│   ├── DependencyInjection/  # DI container
│   ├── Error/               # Error handling
│   ├── ImageCache/          # Image caching system
│   ├── Network/             # Networking layer
│   └── Utils/               # Utilities and extensions
├── Domain/
│   ├── Entities/            # Business models
│   ├── UseCases/            # Business logic
│   └── Protocols/           # Repository interfaces
├── Data/
│   ├── Repositories/        # Data repositories
│   ├── Endpoints/           # API endpoints
│   └── Cache/               # Data caching
├── Presentation/
│   ├── RepositoryList/      # Repository list feature
│   │   ├── Views/           # SwiftUI views
│   │   ├── ViewModel/       # ViewModels
│   │   └── Router/          # Navigation
│   └── Common/              # Shared presentation components
└── Features/
    ├── RepositoryList/      # Main repository browser
    └── RepositoryDetails/   # Repository detail views
```

### 🔧 Key Components

#### Configuration Management
- **AppConfiguration**: Environment-based configuration
- **ConfigurationManager**: Runtime configuration management
- **Config.plist**: Configuration data storage

#### Networking
- **HTTPClient**: Generic HTTP client
- **NetworkManager**: Request handling
- **Endpoint**: API endpoint definitions

#### Image Caching
- **ImageCache**: Efficient image loading and caching
- **ImageItem**: Image model with URL and cache support

#### Dependency Injection
- **DIContainer**: Centralized dependency management
- Proper separation of concerns with protocol-based injection

## Technical Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: Clean Architecture + MVVM
- **Networking**: URLSession with custom HTTP client
- **Image Loading**: Custom image cache implementation
- **PDF Viewing**: PDFKit integration
- **Persistence**: UserDefaults for app preferences

## Getting Started

### Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

### Installation
1. Clone the repository
2. Open `KFH-task.xcodeproj` in Xcode
3. Build and run the project

### Configuration
The app uses a configuration system that supports multiple environments:
- Base URLs and API endpoints are configured in `Config.plist`
- Environment-specific settings in `AppConfiguration.swift`
- Runtime configuration via `ConfigurationManager`

## API Integration

The app integrates with GitHub's public API:
- **Endpoint**: `https://api.github.com/repositories`
- **Search**: Repository search functionality
- **Rate Limiting**: Handled gracefully with error messages

## Features Overview

### Repository List
- Displays GitHub public repositories
- Search functionality with real-time filtering
- Pull-to-refresh support
- Navigation to repository details

### Repository Details
- Repository owner avatar
- Repository name and full name
- Owner information (login, type)
- Repository description
- Privacy status (public/private)
- Fork status indicator
- Direct link to GitHub repository

### Tutorial System
- First-launch tutorial overlay
- Launch count tracking
- Auto-hide functionality
- Smooth animations

## Code Quality

- **Protocol-Oriented**: Extensive use of protocols for testability
- **SOLID Principles**: Following SOLID design principles
- **Error Handling**: Comprehensive error handling with custom error types
- **Memory Management**: Proper memory management with weak references
- **Performance**: Optimized with image caching and efficient data loading

## Testing

The architecture supports easy testing with:
- Protocol-based dependencies
- Dependency injection
- Separated business logic in UseCases
- Mockable network layer

## Author

**Elsayed Ahmed** - iOS Developer
