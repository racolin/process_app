import 'package:process_app/presentation/res/strings/values.dart';

class AppBarModel {
  final String? image;
  final String greeting;
  final int cartTemplateAmount;
  final int voucherAmount;
  final int notifyAmount;

  const AppBarModel({
    this.image,
    required this.greeting,
    required this.cartTemplateAmount,
    required this.voucherAmount,
    required this.notifyAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'greeting': greeting,
      'templateCartAmount': cartTemplateAmount,
      'voucherAmount': voucherAmount,
      'notifyAmount': notifyAmount,
    };
  }

  factory AppBarModel.fromMap(Map<String, dynamic> map) {
    return AppBarModel(
      image: map['image'],
      greeting: map['greeting'] ?? txtDefault,
      cartTemplateAmount: map['templateCartAmount'] ?? 0,
      voucherAmount: map['voucherAmount'] ?? 0,
      notifyAmount: map['notifyAmount'] ?? 0,
    );
  }

  AppBarModel copyWith({
    String? image,
    String? greeting,
    int? cartTemplateAmount,
    int? voucherAmount,
    int? notifyAmount,
  }) {
    return AppBarModel(
      image: image ?? this.image,
      greeting: greeting ?? this.greeting,
      cartTemplateAmount: cartTemplateAmount ?? this.cartTemplateAmount,
      voucherAmount: voucherAmount ?? this.voucherAmount,
      notifyAmount: notifyAmount ?? this.notifyAmount,
    );
  }
}
