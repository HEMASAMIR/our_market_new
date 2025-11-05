class Rate {
  String? id;
  DateTime? createdAt;
  int? rates;
  String? forUser;
  String? forProduct;

  Rate({this.id, this.createdAt, this.rates, this.forUser, this.forProduct});

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json['id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        rates: json['rates'] is int
            ? json['rates'] as int
            : int.tryParse(json['rates'].toString()), // ✅ هنا التعديل,
        forUser: json['for_user'] as String?,
        forProduct: json['for_product'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'rates': rates,
        'for_user': forUser,
        'for_product': forProduct,
      };
}
