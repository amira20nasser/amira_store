abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure(super.message);

  factory FirebaseAuthFailure.fromCode(String code) {
    switch (code) {
      case 'too-many-requests':
        return FirebaseAuthFailure(
          'Temporarily unavailable. We have blocked all requests from this device due to unusual activity.',
        );
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
      case 'user-disabled':
        return FirebaseAuthFailure(
          'This user account has been disabled. Please contact support for assistance.',
        );
      case 'user-not-found':
        return FirebaseAuthFailure('Invalid login details. User not found.');
      case 'wrong-password':
        return FirebaseAuthFailure(
          'Incorrect password. Please check your password and try again.',
        );
      case 'invalid-verification-code':
        return FirebaseAuthFailure(
          'Invalid verification code. Please enter a valid code.',
        );
      case 'invalid-verification-id':
        return FirebaseAuthFailure(
          'Invalid verification ID. Please request a new verification code.',
        );
      case 'quota-exceeded':
        return FirebaseAuthFailure('Quota exceeded. Please try again later.');
      case 'email-already-exists':
        return FirebaseAuthFailure(
          'The email address already exists. Please use a different email.',
        );
      case 'provider-already-linked':
        return FirebaseAuthFailure(
          'The account is already linked with another provider.',
        );
      case 'requires-recent-login':
        return FirebaseAuthFailure(
          'This operation is sensitive and requires recent authentication. Please log in again.',
        );
      case 'credential-already-in-use':
        return FirebaseAuthFailure(
          'This credential is already associated with a different user account.',
        );
      case 'user-mismatch':
        return FirebaseAuthFailure(
          'The supplied credentials do not correspond to the previously signed in user.',
        );
      case 'account-exists-with-different-credential':
        return FirebaseAuthFailure(
          'An account already exists with the same email but different sign-in credentials.',
        );
      case 'operation-not-allowed':
        return FirebaseAuthFailure(
          'This operation is not allowed. Contact support for assistance.',
        );
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
      case 'user-token-expired':
        return FirebaseAuthFailure(
          'The user\'s token has expired, and authentication is required. Please sign in again.',
        );
      case 'invalid-credential':
        return FirebaseAuthFailure(
          'The supplied credential is malformed or has expired.',
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
      case 'web-storage-unsupported':
        return FirebaseAuthFailure(
          'Web storage is not supported or is disabled.',
        );
      case 'app-not-authorized':
        return FirebaseAuthFailure(
          'The app is not authorized to use Firebase Authentication with the provided API key.',
        );
      case 'keychain-error':
        return FirebaseAuthFailure(
          'A keychain error occurred. Please check the keychain and try again.',
        );
      case 'internal-error':
        return FirebaseAuthFailure(
          'An internal authentication error occurred. Please try again later.',
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
