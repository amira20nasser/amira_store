import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class DioFailure extends Failure {
  const DioFailure(super.message);

  factory DioFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return const DioFailure("Request was cancelled. Please try again.");

      case DioExceptionType.connectionTimeout:
        return const DioFailure(
          "Connection timed out. Check your internet connection.",
        );

      case DioExceptionType.sendTimeout:
        return const DioFailure(
          "Send timeout. The request took too long to send.",
        );

      case DioExceptionType.receiveTimeout:
        return const DioFailure(
          "Receive timeout. The server took too long to respond.",
        );

      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        final data = dioException.response?.data;
        return DioFailure._handleBadResponse(statusCode, data);

      case DioExceptionType.connectionError:
        return const DioFailure(
          "No internet connection. Please check your network.",
        );

      case DioExceptionType.unknown:
      default:
        if (dioException.message != null &&
            dioException.message!.contains("SocketException")) {
          return const DioFailure("No Internet connection. Please try again.");
        }
        return DioFailure(
          "Unexpected error: ${dioException.message ?? 'Unknown error'}",
        );
    }
  }
  factory DioFailure._handleBadResponse(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return const DioFailure("Bad request. Please check your input.");
      case 401:
        return const DioFailure("Unauthorized. Please log in again.");
      case 403:
        return const DioFailure("Access forbidden. You don’t have permission.");
      case 404:
        return const DioFailure("Resource not found. Please try again later.");
      case 409:
        return const DioFailure(
          "Conflict error. The request could not be processed.",
        );
      case 500:
        return const DioFailure(
          "Internal server error. Please try again later.",
        );
      case 502:
        return const DioFailure("Bad gateway. Please try again later.");
      case 503:
        return const DioFailure("Service unavailable. Please try again later.");
      default:
        return DioFailure(
          "Received invalid status code: $statusCode\nData: $data",
        );
    }
  }
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure(super.message);

  factory FirebaseAuthFailure.fromCode(String code) {
    switch (code) {
      // Common errors
      case 'too-many-requests':
        return FirebaseAuthFailure(
          'Too many requests. Please try again later.',
        );
      case 'network-request-failed':
        return FirebaseAuthFailure(
          'No internet connection. Please check your network and try again.',
        );
      case 'internal-error':
        return FirebaseAuthFailure(
          'An internal authentication error occurred. Please try again later.',
        );
      case 'operation-not-allowed':
        return FirebaseAuthFailure(
          'This operation is not allowed. Contact support for assistance.',
        );
      case 'user-disabled':
        return FirebaseAuthFailure(
          'This user account has been disabled. Please contact support for assistance.',
        );

      // Email & Password
      case 'email-already-in-use':
        return FirebaseAuthFailure(
          'The email address is already registered. Please use a different email.',
        );
      case 'invalid-email':
        return FirebaseAuthFailure(
          'The email address provided is invalid. Please enter a valid email.',
        );
      case 'weak-password':
        return FirebaseAuthFailure(
          'The password is too weak. Please choose a stronger password.',
        );
      case 'user-not-found':
        return FirebaseAuthFailure('Invalid login details. User not found.');
      case 'wrong-password':
        return FirebaseAuthFailure(
          'Incorrect password. Please check your password and try again.',
        );
      case 'requires-recent-login':
        return FirebaseAuthFailure(
          'This operation requires recent authentication. Please log in again.',
        );

      // Phone Verification
      case 'invalid-phone-number':
        return FirebaseAuthFailure(
          'The phone number provided is invalid. Please enter a valid phone number.',
        );
      case 'missing-phone-number':
        return FirebaseAuthFailure('Please provide a phone number.');
      case 'quota-exceeded':
        return FirebaseAuthFailure('Quota exceeded. Please try again later.');
      case 'session-expired':
        return FirebaseAuthFailure(
          'Session expired. Please request a new verification code.',
        );
      case 'invalid-verification-code':
        return FirebaseAuthFailure(
          'Invalid verification code. Please enter a valid code.',
        );
      case 'invalid-verification-id':
        return FirebaseAuthFailure(
          'Invalid verification ID. Please request a new verification code.',
        );
      case 'code-expired':
        return FirebaseAuthFailure(
          'The verification code has expired. Please request a new code.',
        );

      // Credential/Provider
      case 'credential-already-in-use':
        return FirebaseAuthFailure(
          'This credential is already associated with a different user account.',
        );
      case 'account-exists-with-different-credential':
        return FirebaseAuthFailure(
          'An account already exists with the same email but different sign-in credentials.',
        );
      case 'invalid-credential':
        return FirebaseAuthFailure(
          'The supplied credential is malformed or has expired. Try signing in using Google.',
        );
      case 'provider-already-linked':
        return FirebaseAuthFailure(
          'The account is already linked with another provider.',
        );
      case 'user-mismatch':
        return FirebaseAuthFailure(
          'The supplied credentials do not correspond to the previously signed in user.',
        );

      // Google/Facebook/Web
      case 'popup-closed-by-user':
        return FirebaseAuthFailure(
          'Sign-in popup was closed before completing the sign-in.',
        );
      case 'popup-blocked':
        return FirebaseAuthFailure('Sign-in popup was blocked by the browser.');
      case 'cancelled-popup-request':
        return FirebaseAuthFailure('Sign-in popup request was cancelled.');
      case 'web-storage-unsupported':
        return FirebaseAuthFailure(
          'Web storage is not supported or is disabled.',
        );
      case 'app-not-authorized':
        return FirebaseAuthFailure(
          'The app is not authorized to use Firebase Authentication with the provided API key.',
        );

      // Action Codes
      case 'expired-action-code':
        return FirebaseAuthFailure(
          'The action code has expired. Please request a new action code.',
        );
      case 'invalid-action-code':
        return FirebaseAuthFailure(
          'The action code is invalid. Please check the code and try again.',
        );
      case 'missing-action-code':
        return FirebaseAuthFailure(
          'The action code is missing. Please provide a valid action code.',
        );

      // Miscellaneous
      case 'user-token-expired':
        return FirebaseAuthFailure(
          'The user\'s token has expired. Please sign in again.',
        );
      case 'user-token-revoked':
        return FirebaseAuthFailure(
          'The user\'s token has been revoked. Please sign in again.',
        );
      case 'invalid-message-payload':
        return FirebaseAuthFailure(
          'The email template verification message payload is invalid.',
        );
      case 'invalid-sender':
        return FirebaseAuthFailure(
          'The email template sender is invalid. Please verify the sender\'s email.',
        );
      case 'invalid-recipient-email':
        return FirebaseAuthFailure(
          'The recipient email address is invalid. Please provide a valid recipient email.',
        );
      case 'missing-iframe-start':
        return FirebaseAuthFailure(
          'The email template is missing the iframe start tag.',
        );
      case 'missing-iframe-end':
        return FirebaseAuthFailure(
          'The email template is missing the iframe end tag.',
        );
      case 'missing-iframe-dashboard':
        return FirebaseAuthFailure(
          'The email template is missing the iframe dashboard attribute.',
        );
      case 'auth-domain-config-required':
        return FirebaseAuthFailure(
          'The authDomain configuration is required for the action code verification link.',
        );
      case 'missing-app-credential':
        return FirebaseAuthFailure(
          'The app credential is missing. Please provide valid app credentials.',
        );
      case 'invalid-app-credential':
        return FirebaseAuthFailure(
          'The app credential is invalid. Please provide a valid app credential.',
        );
      case 'session-cookie-expired':
        return FirebaseAuthFailure(
          'The Firebase session cookie has expired. Please sign in again.',
        );
      case 'uid-already-exists':
        return FirebaseAuthFailure(
          'The provided user ID is already in use by another user.',
        );
      case 'invalid-cordova-configuration':
        return FirebaseAuthFailure(
          'The provided Cordova configuration is invalid.',
        );
      case 'app-deleted':
        return FirebaseAuthFailure(
          'This instance of FirebaseApp has been deleted.',
        );
      case 'user-token-mismatch':
        return FirebaseAuthFailure(
          'The provided user\'s token has a mismatch with the authenticated user\'s user ID.',
        );
      case 'keychain-error':
        return FirebaseAuthFailure(
          'A keychain error occurred. Please check the keychain and try again.',
        );
      case 'INVALID_LOGIN_CREDENTIALS':
        return FirebaseAuthFailure('Invalid login credentials.');

      default:
        return FirebaseAuthFailure(
          'An unexpected authentication error occurred. Please try again.',
        );
    }
  }
}
