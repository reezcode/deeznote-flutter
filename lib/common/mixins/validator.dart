import '../enums/form_type.dart';

mixin RsValidationMixin {
  final passwordRegEx = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  final upperCaseRegEx = RegExp(r'[A-Z]');

  final lowerCaseRegEx = RegExp(r'[a-z]');

  final numberRegEx = RegExp(r'[0-9]');

  final emailRegEx = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  final mobileRegEx = RegExp(r'^[0-9]{10}$');

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (!mobileRegEx.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!emailRegEx.hasMatch(value)) {
      return 'Please enter valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(upperCaseRegEx)) {
      return 'Password must contain at least 1 uppercase letter';
    }

    if (!value.contains(lowerCaseRegEx)) {
      return 'Password must contain at least 1 lowercase letter';
    }

    if (!value.contains(numberRegEx)) {
      return 'Password must contain at least 1 number';
    }

    if (!passwordRegEx.hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter, 1 lowercase letter and 1 number';
    }
    return null;
  }

  bool isValidRsForm(List<dynamic> formConfig) {
    bool isValid = true;
    for (var element in formConfig) {
      if (element is Map) {
        if (element['type'] != null) {
          if (element['type'] == FormType.password) {
            if (element['controller'].text.length < 8 &&
                !element['controller'].text.contains(upperCaseRegEx) &&
                !element['controller'].text.contains(lowerCaseRegEx) &&
                !element['controller'].text.contains(numberRegEx)) {
              isValid = false;
            }
          } else if (element['type'] == FormType.email) {
            if (!element['controller'].text.contains('@') &&
                !element['controller'].text.contains('.') &&
                element['controller'].text.length < 5 &&
                !emailRegEx.hasMatch(element['controller'].text)) {
              isValid = false;
            }
          } else if (element['type'] == FormType.phone) {
            if (element['controller'].text.length < 10 &&
                element['controller'].text.split('08')[0] == '08' &&
                !mobileRegEx.hasMatch(element['controller'].text)) {
              isValid = false;
            }
          } else if (element['type'] == FormType.text) {
            if (!element['controller'].text.isNotEmpty) {
              isValid = false;
            }
          }
        }
      }
    }
    return isValid;
  }
}
