import 'package:flutter/material.dart';
import 'form_fields.dart';

class FormzForm extends StatefulWidget {
  const FormzForm({super.key});

  @override
  State<FormzForm> createState() => _FormzFormState();
}

class _FormzFormState extends State<FormzForm> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late Username _username;
  late Email _email;
  late Password _password;

  bool _isSubmitting = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _username = const Username.pure();
    _email = const Email.pure();
    _password = const Password.pure();

    _usernameController.addListener(() {
      setState(() {
        _username = Username.dirty(_usernameController.text);
        _validateForm();
      });
    });

    _emailController.addListener(() {
      setState(() {
        _email = Email.dirty(_emailController.text);
        _validateForm();
      });
    });

    _passwordController.addListener(() {
      setState(() {
        _password = Password.dirty(_passwordController.text);
        _validateForm();
      });
    });
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _username.isValid && _email.isValid && _password.isValid;
    });
  }

  void _submitForm() {
    setState(() {
      _isSubmitting = true;
    });

    // 模拟表单提交
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isSubmitting = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('表单提交成功！'),
            backgroundColor: Colors.green,
          ),
        );
        // 重置表单
        _usernameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _username = const Username.pure();
        _email = const Email.pure();
        _password = const Password.pure();
        _isFormValid = false;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '用户注册',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              
              // Username Field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: '用户名',
                  errorText: _username.isNotValid ? _username.error?.message : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              // Email Field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: '邮箱',
                  errorText: _email.isNotValid ? _email.error?.message : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '密码',
                  errorText: _password.isNotValid ? _password.error?.message : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormValid && !_isSubmitting ? _submitForm : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          '注册',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Form Status
              Center(
                child: Text(
                  _isFormValid ? '表单验证通过！' : '请填写并验证表单',
                  style: TextStyle(
                    color: _isFormValid ? Colors.green : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
