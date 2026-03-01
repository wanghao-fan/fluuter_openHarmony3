import 'package:formz/formz.dart';

// Email Form Input
class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  EmailValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return EmailValidationError.empty;
    }
    if (!_emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    return null;
  }
}

// Password Form Input
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PasswordValidationError.empty;
    }
    if (value.length < 6) {
      return PasswordValidationError.tooShort;
    }
    return null;
  }
}

// Username Form Input
class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return UsernameValidationError.empty;
    }
    if (value.length < 3) {
      return UsernameValidationError.tooShort;
    }
    return null;
  }
}

// Validation Error Classes
enum EmailValidationError {
  empty, invalid
}

enum PasswordValidationError {
  empty, tooShort
}

enum UsernameValidationError {
  empty, tooShort
}

// Extension methods for error messages
extension EmailValidationErrorX on EmailValidationError {
  String get message {
    switch (this) {
      case EmailValidationError.empty:
        return '邮箱不能为空';
      case EmailValidationError.invalid:
        return '请输入有效的邮箱地址';
    }
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String get message {
    switch (this) {
      case PasswordValidationError.empty:
        return '密码不能为空';
      case PasswordValidationError.tooShort:
        return '密码长度至少为6位';
    }
  }
}

extension UsernameValidationErrorX on UsernameValidationError {
  String get message {
    switch (this) {
      case UsernameValidationError.empty:
        return '用户名不能为空';
      case UsernameValidationError.tooShort:
        return '用户名长度至少为3位';
    }
  }
}
