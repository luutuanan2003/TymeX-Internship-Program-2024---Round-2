# Currency Exchange iOS App

## 📚 App Structure

The app is a simple iOS application designed to interact with a currency exchange service. Here is the demostration link: 
https://rmiteduau-my.sharepoint.com/:v:/g/personal/s3926655_rmit_edu_vn/Ea43JfHc5tJButEuHJLXxbEBJUYd9sh7tdoKG5ANbY7enA?e=azdhUC
Below is an overview of the app's main components:

### **Core Files**

1. **`CurrencyService.swift`**
   - Handles fetching and parsing real-time currency exchange rates.
   - Manages network requests to fetch conversion data.
   - Includes error handling for failed requests.

2. **`SplashScreenView.swift`**
   - Displays a clean and animated loading screen during app launch.
   - Sets up and transitions to the main `HomeView`.

3. **`HomeView.swift`**
   - Provides a user-friendly interface for inputting and viewing currency conversion rates.
   - Integrates with `CurrencyService` to display up-to-date data.

4. **`CurrencyServiceTests.swift`**
   - Unit tests for the `CurrencyService` class.
   - Covers:
     - Valid API responses.
     - Error handling for failed requests.
     - Parsing and validating exchange rate data.

---

## 🛠 Steps to Build and Run the App

Follow the steps below to set up and run the app:

### **Prerequisites**
- **Xcode**: Ensure you have the latest version of Xcode installed - Version 16.1 (16B40).
- **Apple Developer Account**: Required for deploying to physical devices.

### **Setup**
Clone the repository from github to Xcode

### **Build And Run**
Choose the iPhone 16 Pro as the simulator and hit Start

## 🧪 Running Unit Tests

This app includes unit tests for validating the functionality of the `CurrencyService`. Press `Command + U` to start the test.

