class FormData {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String gender;
  final bool agreeTerms;

  FormData({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.agreeTerms,
  });

  // 转换为JSON格式，便于后续处理
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'gender': gender,
      'agreeTerms': agreeTerms,
    };
  }
}
