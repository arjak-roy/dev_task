import 'dart:convert';
import 'dart:math';
import 'package:dev_task/Homepage/widgets/product_card.dart';
import 'package:dev_task/data/Model/products.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
abstract class ProductRepository{
  List<Product> pd = [];
  Future<List<ProductCard>> getProducts();
  Future<List<ProductCard>> loadMore();
  Future<List<ProductCard>> searchProducts(String query);
}

class ProductRepositoryImpl implements ProductRepository{
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  List<Product> pd = [];
  @override
  Future<List<ProductCard>> getProducts()async{
  try {
  final snapshot = await fireStore.collection('Products').limit(10).get();
  final products = snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
  pd.clear();
  pd.addAll(products);
  final List<ProductCard> pdts = [];
  //First the project was done with FAKESTOREAPI
  // final client =  http.Client();
  // final response = await client.get(Uri.parse('https://fakestoreapi.com/products'));
  // final jsonString = response.body;
  // print(jsonString);
  // final jsonMap = json.decode(jsonString);
  for (var element in products) {
    final ProductCard productCard = ProductCard(product: element,);
    pdts.add(productCard);
  }
  return pdts;
  } catch (e) {
    if (e.runtimeType == FirebaseException){
     throw Exception('Client Side error');
    }
    else{
      throw Exception('Server Side error');
    }
  }
  }

  @override
  Future<List<ProductCard>> loadMore()async{
    try {
    final snapshot = await fireStore.collection('Products').orderBy('id').startAfter([pd.last.id]).limit(10).get();
    if(snapshot.docs.isEmpty){
      return [];
    }
    else{
    final products = snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    final List<ProductCard> pdts = [];
    pd.clear();
    pd.addAll(products);
    for (var element in products) {
      final ProductCard productCard = ProductCard(product: element);
      pdts.add(productCard);
    }
    return pdts;

    }
    }
     catch (e) {
      throw Exception('Server Side error');
    }
  }
  @override
  Future<List<ProductCard>> searchProducts(String query) async {
  try {
  if(query.isNotEmpty){
  final List<ProductCard> pdts = [];
  // final client =  http.Client();
  // final response = await client.get(Uri.parse('https://fakestoreapi.com/products/${query}'));
  // final jsonString = response.body;
  // final jsonMap = json.decode(jsonString);
  // final product = Product.fromJson(jsonMap);
  final result = await fireStore.collection('Products').where('category',isEqualTo: query).limit(10).get();
  if (result.docs.isEmpty){
    throw Exception('No Products found');
  }
  else{
  final products = result.docs.map((doc) => Product.fromJson(doc.data())).toList();
  for (var element in products) {
    final ProductCard productCard = ProductCard(product: element);
    pdts.add(productCard);
  }
  return pdts;

  }
  }
  else{
    return [];
  }
  } catch (e) {
    if (e.runtimeType == FirebaseException){
     throw Exception('No Products found');
    }
    else{
      throw Exception('No Products found');
    }
  }

  }

}
