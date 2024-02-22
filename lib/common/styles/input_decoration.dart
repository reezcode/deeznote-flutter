import 'package:flutter/material.dart';

import 'rs_style_library.dart';

class RsInputDecoration {
  static InputDecoration defaultDecoration({
    String? hint,
    String? label,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(
              icon,
              color: RsColorScheme.grey,
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: RsColorScheme.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: RsColorScheme.grey),
      ),
    );
  }

  static InputDecoration passwordDecoration({
    String? hint,
    String? label,
    bool? isObscure,
    void Function()? onObscurePressed,
  }) {
    return InputDecoration(
      hintText: hint,
      errorMaxLines: 2,
      prefixIcon: const Icon(
        Icons.lock,
        color: RsColorScheme.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: RsColorScheme.primary),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          isObscure! ? Icons.visibility : Icons.visibility_off,
          color: RsColorScheme.grey,
        ),
        onPressed: onObscurePressed,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: RsColorScheme.grey),
      ),
    );
  }
}
