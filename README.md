# Spotmies
![image](https://github.com/swastiksuvam55/spotmies_user/assets/90003260/6a12dad8-058f-42d8-948f-16a27cde73bd)
![image](https://github.com/swastiksuvam55/spotmies_user/assets/90003260/91801168-b877-4749-9b1d-1942ab6be95c)
![image](https://github.com/swastiksuvam55/spotmies_user/assets/90003260/f85f12c0-587b-4776-96a0-1897e010d0f2)



Spotmies is a Flutter project that aims to provide a platform for connecting service providers with customers. It allows users to find and hire professionals for various services such as home repairs, tutoring, designing, and more.

## Features

- User Registration and Authentication: Users can create an account and log in to the application using their email and password. Firebase Authentication is used for secure authentication.

- Service Listing: Service providers can create profiles and list their services on the platform. Users can search for services based on their location, view service details, and contact service providers.

- Booking Services: Users can book services directly through the app. They can select a date and time slot for the service and communicate with the service provider.

- Real-time Messaging: Users can communicate with service providers through real-time messaging. Firebase Cloud Firestore is used to store and synchronize the messages between users.

- Location Services: The app uses the device's GPS to fetch the user's location and display services available in their area. The geolocator and geocoder packages are used for location-related functionality.

- Image and File Upload: Service providers can upload images related to their services, and users can upload profile pictures or other relevant files. Firebase Storage is used to store and retrieve the uploaded files.

- Push Notifications: The app supports push notifications using the Firebase Cloud Messaging service. Users receive notifications for new messages, service updates, and other relevant events.

## Installation

1. Make sure you have Flutter SDK installed. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

2. Clone this repository to your local machine:

```bash
git clone https://github.com/swastiksuvam55/spotmies_user.git
```

3. Change your current directory to the cloned project:

```bash
cd spotmies
```

4. Fetch the dependencies by running the following command:

```bash
flutter pub get
```

This will download and install all the necessary packages and dependencies.

5. Create a Firebase project and set up Firebase Authentication, Cloud Firestore, and Firebase Storage. Follow these steps:

- Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
- Enable Firebase Authentication and set up the email/password sign-in method.
- Enable Cloud Firestore and create a new Firestore database.
- Enable Firebase Storage for storing uploaded images and files.
- Generate the necessary configuration files for Android and iOS platforms.

6. Add the Firebase configuration files to the project:
- For Android: Place the `google-services.json` file inside the `android/app` directory.
- For iOS: Place the `GoogleService-Info.plist` file inside the `ios/Runner` directory.

7. Run the app on a connected device or emulator using the following command:

```bash
flutter run
```

This will launch the app on the selected device or emulator.

## Folder Structure

The project follows a standard Flutter folder structure:

- `lib`: Contains the Dart code for the application.
- `models`: Defines the data models used in the app.
- `screens`: Contains the different screens of the app.
- `services`: Includes the service classes for data retrieval and manipulation.
- `widgets`: Contains reusable UI components used across the app.
- `assets`: Contains static assets such as images, icons, and fonts.
- `test`: Includes test cases for the app.

## Dependencies

The following dependencies are used in this project:

- `firebase_core: ^1.0.1`: Firebase Core package for initializing Firebase services.
- `firebase_auth: ^1.0.0`: Firebase Authentication package for user registration and authentication.
- `cloud_firestore: ^1.0.1`: Firebase Cloud Firestore package for real-time database functionality.
- `geolocator: ^7.0.1`: Package for retrieving the device's location using GPS.
- `firebase_storage: ^8.0.0`: Firebase Storage package for storing and retrieving uploaded files.
- `flutter_icons: ^1.1.0`: Package for using custom icons in the app.
- `http: ^0.13.0`: Package for making HTTP requests to the backend API.
- `provider: ^5.0.0`: Package for state management using the Provider pattern.
- `google_maps_flutter: ^2.0.1`: Package for displaying maps and location markers.
- `url_launcher: ^6.0.3`: Package for launching URLs in the device's browser.
- `webview_flutter: ^2.0.4`: Package for displaying web content within the app.
- `fluttertoast: ^8.0.7`: Package for showing toast messages in the app.
- `shared_preferences: ^2.0.6`: Package for storing and retrieving simple data locally.
- `socket_io_client: ^1.0.1`: Package for WebSocket communication with the backend server.
- `video_player: ^2.1.14`: Package for playing videos in the app.
- `flutter_webrtc: ^0.6.5`: Package for integrating WebRTC video calling functionality.
- `lottie: ^1.1.0`: Package for using Lottie animations in the app.
- `photo_view: ^0.12.0`: Package for displaying zoomable images in the app.
- `permission_handler: ^8.1.4+2`: Package for handling runtime permissions in the app.
- `flutter_audio_recorder2: ^0.0.2`: Package for recording audio in the app.
- `audioplayers: ^0.19.1`: Package for playing audio files in the app.
- `path_provider: ^2.0.3`: Package for accessing the device's file system paths.
- `firebase_messaging: ^10.0.7`: Firebase Cloud Messaging package for push notifications.
- `rxdart`: Package for reactive programming using Observables.
- `awesome_notifications: ^0.0.6+10`: Package for custom push notifications.
- `country_code_picker: ^2.0.2`: Package for selecting country codes in the app.
- `flutter_incall: ^1.0.0`: Package for integrating voice and video calling functionality.

Note: Make sure to check for the latest versions of the dependencies and update them accordingly in your `pubspec.yaml` file.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

Please make sure to follow the [Flutter style guide](https://flutter.dev/docs/development/code-style) and write unit tests for any new features or bug fixes.

## License

This project is licensed under the `BSD 3-Clause License`. You can find more details in the LICENSE file..
