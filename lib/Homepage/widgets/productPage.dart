import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_task/data/Model/products.dart';
import 'package:flutter/material.dart';

class Productpage extends StatefulWidget {
  final Product;
  const Productpage({super.key, required this.Product});
  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text("Product Details"),
        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            padding: const EdgeInsets.all(10),
            height: 250,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: widget.Product.image,
                fadeInCurve: Curves.bounceIn,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(widget.Product.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(widget.Product.description, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
            ),
          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            "\$ " + widget.Product.price.toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: (){

                        },
                         style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                         ),
                         child: const Text("Buy", style: TextStyle(color: Colors.white, fontSize: 20),)),
                      ],
                    )


      ]),
    );
  }
}