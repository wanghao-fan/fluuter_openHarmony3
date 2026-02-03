part of 'form_cubit.dart';

enum FormStatus {
  initial,
  submitting,
  submitted,
  error,
}

class FormCubitState extends Equatable {
  final FormModel form;
  final FormStatus status;
  final Map<String, String> errors;

  const FormCubitState({
    this.form = const FormModel(),
    this.status = FormStatus.initial,
    this.errors = const {},
  });

  FormCubitState copyWith({
    FormModel? form,
    FormStatus? status,
    Map<String, String>? errors,
  }) {
    return FormCubitState(
      form: form ?? this.form,
      status: status ?? this.status,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props {
    return [
      form,
      status,
      errors,
    ];
  }
}