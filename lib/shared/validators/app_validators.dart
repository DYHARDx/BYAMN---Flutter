class AppValidators {
  static final RegExp _emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=]{8,}$',
  );

  // At least 8 characters, 1 letter, 1 number

  static String? required(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!_emailRegExp.hasMatch(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (!_passwordRegExp.hasMatch(value)) {
      return "Password must be at least 8 chars include letters and numbers";
    }

    return null;
  }

  static String? confirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }

    if (value != original) {
      return 'Passwords do not match';
    }

    return null;
  }
}
