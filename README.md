# Booking Rafael Barbershop

Booking Rafael Barbershop is a mobile application (Android & iOS) built with Flutter to streamline barbershop service bookings and management for both customers and administrators. The app provides a modern, user-friendly interface and comprehensive features for booking, data management, and reporting.

## Main Features

### For Customers

- **Registration & Login:** Secure account creation and authentication.
- **Book Capster & Schedule:** Choose a capster, select date and time based on availability.
- **Select Services, Hair Style & Color:** Browse and choose from various service menus, hair styles, and hair colors.
- **Upload Payment Proof:** Upload payment receipts directly through the app.
- **Booking Status & Order History:** Track booking status and view order history.
- **Profile Management:** Edit personal information such as name, phone number, email, and address.

### For Admin

- **Capster Management:** Add, edit, and delete capster data with photos.
- **Service, Hair Style & Color Management:** Manage service menus, hair styles, and hair colors.
- **Customer Data Management:** View, add, and delete customer data.
- **Payment Method Management:** Add and remove payment methods (including QR code uploads).
- **Capster Leave Scheduling:** Set capster leave schedules to prevent bookings during leave.
- **Booking Reports:** View and export daily, monthly, and yearly booking reports in PDF format, including total revenue.
- **Update Payment Status:** Verify and update booking payment status to "Success".

### General Features

- **Notifications & Snackbar:** Real-time status and error notifications.
- **Role-based Access:** Feature access is separated for admin and customer roles.
- **Responsive UI:** Modern, intuitive, and mobile-friendly design.

## Usage Flow

1. **Customers register and log in.**
2. **Customers select a capster, date, time, service, hair style, and hair color.**
3. **Customers upload payment proof and wait for admin confirmation.**
4. **Admin verifies payment and updates booking status.**
5. **Customers can track booking status and view order history.**
6. **Admin manages data, views reports, and exports reports to PDF.**

## Tech Stack

- **Flutter (Dart):** Cross-platform mobile development.
- **Firebase Auth:** User authentication.
- **Cloud Firestore:** Real-time database for bookings, users, capsters, etc.
- **Firebase Storage:** Image storage (payment proof, capster photos, payment QR codes).
- **GetX:** State management, dependency injection, and routing.
- **PDF & Printing:** Generate and print booking reports in PDF format.
- **Cloud Functions:** Backend automation.

## Getting Started

1. **Clone this repository:**
   ```sh
   git clone https://github.com/adrianAlviYendri/booking-rafael-barbershop.git
   cd booking-rafael-barbershop
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Setup Firebase:**

   - Create a project in [Firebase Console](https://console.firebase.google.com/).
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS), and place them in the appropriate folders.
   - Update configuration in `firebase_options.dart` if needed.

4. **Run the app:**
   ```sh
   flutter run
   ```

## Folder Structure

- `lib/`
  - `controller/` - Business logic and state management
  - `models/` - Data models
  - `screen admin/` - Admin features (management, reports, etc.)
  - `screen customer/` - Customer features (booking, payment, profile, etc.)
  - `widgets/` - Reusable UI components
  - `routers/` - App routing
