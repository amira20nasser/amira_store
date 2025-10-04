class EmailValidator {
  String? call(String? value) {
    if (value == null || value.isEmpty) {
      return "E-mail is required";
    }
    final checks = checkEmail(value);
    if (checks.containsValue(false)) {
      return "This e-mail isn't valid";
    }
    return null;
  }

  Map<String, bool> checkEmail(String email) {
    return {
      "notEmpty": email.isNotEmpty,
      "containsAt": email.contains('@'),
      "containsDot": email.contains('.'),
      "validFormat": RegExp(
        r"^[\w\.\-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(email),
      "minLength": email.length >= 6,
    };
  }
}
