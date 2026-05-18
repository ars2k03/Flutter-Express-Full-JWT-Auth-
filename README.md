# Flutter Express Full JWT Auth

A complete authentication system built with a **Flutter frontend** and an **Express.js + TypeScript backend**, featuring **JWT authentication**, **email verification**, **resend OTP**, **forgot password**, **password reset**, and **persistent login**. The repository is organized into separate `Frontend` and `Backend` apps, with the backend using Express, Mongoose, bcrypt, JSON Web Token, Nodemailer, dotenv, and tsx. The frontend uses Flutter with `http` and `shared_preferences` for API calls and token persistence. citeturn441124view0turn170323view0turn170323view1turn550901view0turn550901view2turn890298view0turn905436view0

## Features

- User signup and login
- JWT-based authentication
- Email verification flow
- Resend verification code / OTP
- Forgot password flow
- Password reset flow
- Persistent login on the client side
- Separate Flutter frontend and Express backend

## Tech Stack

**Frontend**
- Flutter
- Dart
- `http`
- `shared_preferences`

**Backend**
- Node.js
- Express.js
- TypeScript
- MongoDB / Mongoose
- bcrypt
- jsonwebtoken
- nodemailer
- dotenv
- tsx

## Project Structure

```text
Flutter-Express-Full-JWT-Auth-
├── Frontend
│   ├── lib
│   │   ├── auth_service.dart
│   │   ├── main.dart
│   │   └── screens/
│   ├── android/
│   ├── ios/ (if added later)
│   ├── linux/
│   └── web/
└── Backend
    └── src
        ├── controller
        │   ├── forgetPassword.ts
        │   ├── login.ts
        │   ├── resendCode.ts
        │   ├── resetPass.ts
        │   ├── signup.ts
        │   └── verifyCode.ts
        ├── middleware
        │   └── auth.middle.ts
        ├── model
        │   ├── user.model.ts
        │   └── verification.model.ts
        ├── router
        │   └── route.user.ts
        ├── utils
        │   └── sendMail.ts
        └── index.ts
```

## How It Works

1. The user signs up from the Flutter app.
2. The backend creates the account and sends a verification code by email.
3. The user verifies the code.
4. After login, the backend returns a JWT token.
5. Flutter stores the token using `shared_preferences`.
6. On app launch, Flutter checks the saved token and redirects the user directly to the home screen if the session is still valid.

## Prerequisites

Make sure you have the following installed:

- Flutter SDK
- Dart
- Node.js
- MongoDB
- A working email account for Nodemailer
- A code editor such as VS Code

## Setup Instructions

### 1) Clone the repository

```bash
git clone https://github.com/ars2k03/Flutter-Express-Full-JWT-Auth-.git
cd Flutter-Express-Full-JWT-Auth-
```

### 2) Backend setup

```bash
cd Backend
npm install
```

Run the backend in development mode:

```bash
npm run dev
```

The backend is configured to run on port `8000`. The current code connects to a local MongoDB instance at `mongodb://127.0.0.1:27017/Resgister`, and CORS is enabled for cross-origin requests. Update the connection string in `src/index.ts` if needed for your own environment. citeturn550901view0

### 3) Frontend setup

```bash
cd ../Frontend
flutter pub get
flutter run
```

The Flutter app checks for a stored `token` at startup and opens the home screen when one exists; otherwise it shows the login screen. 

## Environment Variables

Create a `.env` file inside `Backend` and add the values your mail and auth setup needs.

Example:

```env
JWT_SECRET=your_jwt_secret
EMAIL_USER=your_email@example.com
EMAIL_PASS=your_email_password
MONGO_URI=mongodb://127.0.0.1:27017/Resgister
```

Note: if your backend code still uses a hardcoded MongoDB URI, move it to `.env` for cleaner deployment.

## API Endpoints

The exact routes live in `Backend/src/router/route.user.ts` and are handled by the controller files in `Backend/src/controller`. Based on the current structure, the main auth flows covered are:

- Signup
- Login
- Email verification
- Resend verification code
- Forgot password
- Reset password

## Screenshots

Add app screenshots here when you are ready:

- Login screen
- Sign up screen
- OTP verification screen
- Forgot password screen
- Reset password screen
- Home screen

## Future Improvements

- Move secrets fully into environment variables
- Add refresh token support
- Add input validation on both client and server
- Add API error handling UI in Flutter
- Add deployment guide for backend and frontend
- Add screenshots and demo video

## Contributing

Pull requests and improvements are welcome.

## License

This project is licensed under the [MIT License](LICENSE).

---

Made with Flutter, Express, and JWT.