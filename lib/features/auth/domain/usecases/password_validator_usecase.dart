class PasswordValidatorUsecase {
  String? call(String? value) {
    if (value == null) {
      return "Password is required";
    }
    final checks = checkPassword(value);
    if (checks.containsValue(false)) {
      return "Password does not meet all requirements";
    }
    return null;
  }

  Map<String, bool> checkPassword(String password) {
    return {
      "At least 8 characters": password.length >= 8,
      "Contains uppercase letter": password.contains(RegExp(r'[A-Z]')),
      "Contains lowercase letter": password.contains(RegExp(r'[a-z]')),
      "Contains number": password.contains(RegExp(r'[0-9]')),
      "Contains special character": password.contains(RegExp(r'[!@#\$&*~]')),
    };
  }
}
