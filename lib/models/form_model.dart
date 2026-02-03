import 'package:equatable/equatable.dart';

class FormModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final String address;

  const FormModel({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.phone = '',
    this.address = '',
  });

  FormModel copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
    String? address,
  }) {
    return FormModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, String> validate() {
    final errors = <String, String>{};

    if (name.isEmpty) {
      errors['name'] = '姓名不能为空';
    }

    if (email.isEmpty) {
      errors['email'] = '邮箱不能为空';
    } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      errors['email'] = '请输入有效的邮箱地址';
    }

    if (password.isEmpty) {
      errors['password'] = '密码不能为空';
    } else if (password.length < 6) {
      errors['password'] = '密码长度至少为6位';
    }

    if (confirmPassword.isEmpty) {
      errors['confirmPassword'] = '请确认密码';
    } else if (confirmPassword != password) {
      errors['confirmPassword'] = '两次输入的密码不一致';
    }

    if (phone.isEmpty) {
      errors['phone'] = '手机号不能为空';
    } else if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(phone)) {
      errors['phone'] = '请输入有效的手机号';
    }

    if (address.isEmpty) {
      errors['address'] = '地址不能为空';
    }

    return errors;
  }

  @override
  List<Object?> get props {
    return [
      name,
      email,
      password,
      confirmPassword,
      phone,
      address,
    ];
  }
}