import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String title;
  String imageUrl;
  String price;
  int quantity;
  String addedQuantity;
  String? prodId;
  Products(
      {required this.title,
      required this.imageUrl,
      required this.price,
      required this.quantity,
      required this.prodId,
      required this.addedQuantity});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'prodId': prodId,
    };
  }

  factory Products.fromMap(DocumentSnapshot map) {
    return Products(
      addedQuantity: '1',
      prodId: map['prodId'],
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? '',
      quantity: map['quantity'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Products(title: $title, imageUrl: $imageUrl, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Products &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        imageUrl.hashCode ^
        price.hashCode ^
        quantity.hashCode;
  }
}
