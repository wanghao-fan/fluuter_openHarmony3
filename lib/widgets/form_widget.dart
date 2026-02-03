import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/form_cubit.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormCubit, FormCubitState>(
      listener: (context, state) {
        if (state.status == FormStatus.submitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('表单提交成功！')),
          );
        } else if (state.status == FormStatus.error) {
          // 错误信息已经在输入框下方显示，这里可以添加额外的错误处理
        }
      },
      builder: (context, state) {
        final cubit = context.read<FormCubit>();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 姓名输入
              _buildTextField(
                label: '姓名',
                initialValue: state.form.name,
                onChanged: cubit.updateName,
                errorText: state.errors['name'],
              ),
              const SizedBox(height: 16),

              // 邮箱输入
              _buildTextField(
                label: '邮箱',
                initialValue: state.form.email,
                onChanged: cubit.updateEmail,
                errorText: state.errors['email'],
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // 密码输入
              _buildTextField(
                label: '密码',
                initialValue: state.form.password,
                onChanged: cubit.updatePassword,
                errorText: state.errors['password'],
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // 确认密码输入
              _buildTextField(
                label: '确认密码',
                initialValue: state.form.confirmPassword,
                onChanged: cubit.updateConfirmPassword,
                errorText: state.errors['confirmPassword'],
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // 手机号输入
              _buildTextField(
                label: '手机号',
                initialValue: state.form.phone,
                onChanged: cubit.updatePhone,
                errorText: state.errors['phone'],
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // 地址输入
              _buildTextField(
                label: '地址',
                initialValue: state.form.address,
                onChanged: cubit.updateAddress,
                errorText: state.errors['address'],
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // 提交按钮
              ElevatedButton(
                onPressed: state.status == FormStatus.submitting
                    ? null
                    : cubit.submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: state.status == FormStatus.submitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('提交表单', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // 重置按钮
              OutlinedButton(
                onPressed: cubit.resetForm,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('重置表单', style: TextStyle(fontSize: 16)),
              ),

              // 提交状态显示
              if (state.status == FormStatus.submitted)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: const Text(
                    '表单提交成功！',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }
}