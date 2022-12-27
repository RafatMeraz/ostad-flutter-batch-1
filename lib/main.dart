import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListPojo? productListPojo;

  @override
  void initState() {
    super.initState();
    getProductListFromApi();
  }

  void getProductListFromApi() async {
    String url = 'https://crud.devnextech.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);


      productListPojo = ProductListPojo.fromJson(jsonDecode(response.body));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
          itemCount: productListPojo?.listOfProducts?.length ?? 0,
          itemBuilder: (context, index) {
        return ListTile(
          title: Text(productListPojo?.listOfProducts?[index].productName ?? ''),
          subtitle: Text(productListPojo?.listOfProducts?[index].productCode ?? ''),
          trailing: Text(productListPojo?.listOfProducts?[index].unitPrice ?? ''),
        );
      }),
    );
  }
}


/// responsible for the conversion of json to dart
class ProductListPojo {
  String? status;
  List<Product>? listOfProducts;

  ProductListPojo({this.status, this.listOfProducts});

  ProductListPojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfProducts = <Product>[];
      json['data'].forEach((v) {
        listOfProducts!.add(new Product.fromJson(v));
      });
    }
  }
}

class Product {
  String? sId;
  String? productName;
  String? productCode;
  String? img;
  String? unitPrice;
  String? qty;
  String? totalPrice;
  String? createdDate;

  Product(
      {this.sId,
        this.productName,
        this.productCode,
        this.img,
        this.unitPrice,
        this.qty,
        this.totalPrice,
        this.createdDate});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    img = json['Img'];
    unitPrice = json['UnitPrice'];
    qty = json['Qty'];
    totalPrice = json['TotalPrice'];
    createdDate = json['CreatedDate'];
  }
}



