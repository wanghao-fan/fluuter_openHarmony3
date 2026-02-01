import 'package:flutter/material.dart';
import 'form_model.dart';

class FormWithReset extends StatefulWidget {
  const FormWithReset({super.key});

  @override
  State<FormWithReset> createState() => _FormWithResetState();
}

class _FormWithResetState extends State<FormWithReset> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  String _selectedGender = '男';
  bool _agreeTerms = false;

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    setState(() {
      _selectedGender = '男';
      _agreeTerms = false;
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final formData = FormData(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        gender: _selectedGender,
        agreeTerms: _agreeTerms,
      );
      
      // 在这里处理表单提交逻辑
      print('Form submitted: ${formData.toJson()}');
      
      // 显示提交成功提示
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('表单提交成功！')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            const Text(
              '用户信息表单',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            
            // 姓名
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '姓名',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return '请输入姓名';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // 邮箱
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '邮箱',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return '请输入邮箱';
                }
                if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value!)) {
                  return '请输入有效的邮箱地址';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // 电话
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: '电话',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return '请输入电话';
                }
                if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value!)) {
                  return '请输入有效的手机号码';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // 地址
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: '地址',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              maxLines: 2,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return '请输入地址';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // 性别
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('性别'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Radio(
                      value: '男',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    const Text('男'),
                    const SizedBox(width: 20),
                    Radio(
                      value: '女',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    const Text('女'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 同意条款
            Row(
              children: [
                Checkbox(
                  value: _agreeTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeTerms = value!;
                    });
                  },
                ),
                const Text('我同意服务条款和隐私政策'),
              ],
            ),
            const SizedBox(height: 24),
            
            // 按钮
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      '提交',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetForm,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Colors.deepPurple),
                    ),
                    child: const Text(
                      '重置',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
