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

  Future<void> getProductListFromApi() async {
    String url = 'https://crud.devnextech.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      var value = jsonDecode(response.body);
      productListPojo = ProductListPojo.fromJson(value);
      setState(() {

      });
    }
  }

  void addANewProduct() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewProduct()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
          itemCount: productListPojo?.listOfProducts?.length ?? 0,
          itemBuilder: (context, index) {
        return ListTile(
          title: Text(productListPojo?.listOfProducts?[index].productName ?? 'Unknown'),
          subtitle: Text(productListPojo?.listOfProducts?[index].productCode ?? 'Unknown'),
          trailing: Text(productListPojo?.listOfProducts?[index].unitPrice ?? ''),
        );
      }),
    );
  }
}


/// POJO / Model class
/// responsible for the conversion of json to dart / dart to json
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


class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController _productNameETController = TextEditingController();
  TextEditingController _productCodeETController = TextEditingController();
  TextEditingController _productUnitPriceETController = TextEditingController();
  TextEditingController _productImageETController = TextEditingController();
  TextEditingController _productQuantityETController = TextEditingController();
  TextEditingController _productTotalPriceTController = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey();

  Future<void> addANewProduct(String name, String productCode, String quantity,
      String image, String unitPrice, String totalPrice) async {
    String url = 'https://crud.devnextech.com/api/v1/CreateProduct';
    Uri uri = Uri.parse(url);
    http.Response response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          "Img": image,
          "ProductCode": productCode,
          "ProductName": name,
          "Qty": quantity,
          "TotalPrice": totalPrice,
          "UnitPrice": unitPrice
        }));
    if (response.statusCode == 200) {
      print(response.body);
      print('Product added successfully');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product added successfully')));
      _productTotalPriceTController.text = '';
      _productUnitPriceETController.text = '';
      _productImageETController.text = '';
      _productNameETController.text = '';
      _productCodeETController.text = '';
      _productQuantityETController.text = '';
    } else {
      print('Failed');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your product name';
                  }
                  return null;
                },
                controller: _productNameETController,
                decoration: InputDecoration(
                  hintText: 'Product name'
                ),
              ),
              TextField(
                controller: _productCodeETController,
                decoration: InputDecoration(
                  hintText: 'Product code'
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _productUnitPriceETController,
                decoration: InputDecoration(
                  hintText: 'Unit price'
                ),
              ),
              TextField(
                controller: _productImageETController,
                decoration: InputDecoration(
                  hintText: 'Image'
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _productQuantityETController,
                decoration: InputDecoration(
                  hintText: 'Quantity'
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _productTotalPriceTController,
                decoration: InputDecoration(
                  hintText: 'Total price'
                ),
              ),
              ElevatedButton(onPressed: () {
                if (_form.currentState!.validate()) {
                  addANewProduct(
                    _productNameETController.text,
                    _productCodeETController.text,
                    _productQuantityETController.text,
                    _productImageETController.text,
                    _productUnitPriceETController.text,
                    _productTotalPriceTController.text,
                  );
                }
              }, child: Text('Add Product'))
            ],
          ),
        ),
      ),
    );
  }
}




