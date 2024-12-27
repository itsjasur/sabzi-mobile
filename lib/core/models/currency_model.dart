class CurrencyModel {
  final String code;
  final String label;

  CurrencyModel({required this.code, required this.label});

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      code: map['code'] as String,
      label: map['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'label': label,
    };
  }

  CurrencyModel copyWith({
    String? code,
    String? label,
  }) {
    return CurrencyModel(
      code: code ?? this.code,
      label: label ?? this.label,
    );
  }
}
