import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/form_model.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormCubitState> {
  FormCubit() : super(const FormCubitState());

  void updateName(String name) {
    final form = state.form.copyWith(name: name);
    emit(state.copyWith(form: form));
  }

  void updateEmail(String email) {
    final form = state.form.copyWith(email: email);
    emit(state.copyWith(form: form));
  }

  void updatePassword(String password) {
    final form = state.form.copyWith(password: password);
    emit(state.copyWith(form: form));
  }

  void updateConfirmPassword(String confirmPassword) {
    final form = state.form.copyWith(confirmPassword: confirmPassword);
    emit(state.copyWith(form: form));
  }

  void updatePhone(String phone) {
    final form = state.form.copyWith(phone: phone);
    emit(state.copyWith(form: form));
  }

  void updateAddress(String address) {
    final form = state.form.copyWith(address: address);
    emit(state.copyWith(form: form));
  }

  Future<void> submitForm() async {
    final errors = state.form.validate();
    
    if (errors.isNotEmpty) {
      emit(state.copyWith(
        status: FormStatus.error,
        errors: errors,
      ));
      return;
    }

    emit(state.copyWith(status: FormStatus.submitting));

    // 模拟表单提交
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(status: FormStatus.submitted));
  }

  void resetForm() {
    emit(const FormCubitState());
  }
}