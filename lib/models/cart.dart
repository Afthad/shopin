import 'dart:async';

import 'package:shopin/models/products.dart';

class Cart {
  String? prodId;
  Products? products;
  int? quantity;
  Timer? timer;
  Cart({
    this.prodId,
    this.timer,
    this.products,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': prodId,
      'products': products?.toMap(),
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      prodId: map['uid'],
      products:
          map['products'] != null ? Products.fromMap(map['products']) : null,
      quantity: map['quantity']?.toInt(),
    );
  }
}
