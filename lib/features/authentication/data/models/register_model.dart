class RegisterModel {
  final int? id;
  final String? token;
  final String? error;

  const RegisterModel({
    this.id,
    this.token,
    this.error,
  });

  RegisterModel.fromJson(dynamic json)
      : id = json['id'] as int?,
        token = json['token'] as String?,
        error = json['error'] as String?;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['token'] = token;
    map['error'] = error;

    return map;
  }
}
