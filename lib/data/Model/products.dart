import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
    final int id;
    final String title;
    final double price;
    final String description;
    final String category;
    final String image;
    Timestamp ? createdAt;
    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        this.createdAt
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        createdAt: Timestamp.now()
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "createdAt": createdAt
    };
}
