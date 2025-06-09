Reels App


A Flutter application that fetches and displays video reels from an API, implementing pagination, lazy loading, caching, and clean architecture with the BLoC pattern.
Features

Fetches video reels from the provided API
Implements pagination with lazy loading
Caches reel data using Hive
Uses BLoC for state management
Implements dependency injection with GetIt
Handles errors gracefully
Displays videos in a reels-like interface with smooth scrolling

Prerequisites

Flutter SDK: >=2.18.0 <3.0.0
Dart SDK
Android Studio or VS Code with Flutter plugin

Installation

Clone the repository:
git clone <repository-url>
cd reels_app


Install dependencies:
flutter pub get


Generate Hive adapters:
flutter pub run build_runner build


Run the application:
flutter run



Notes

The app uses the http package for API requests and video_player for video playback.
Pagination is achieved by loading more reels when the user scrolls near the bottom.
Error handling covers API failures and JSON parsing issues.
The UI mimics a reels interface with smooth scrolling and video playback.

Dependencies

http: For making API requests
flutter_bloc: For state management
get_it: For dependency injection
cached_network_image: For loading and caching thumbnail images
video_player: For playing videos
path_provider: For accessing file storage


