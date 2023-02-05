import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/cloud_store_helper.dart';

import 'book.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool inProgress = true;
  List<Book> listOfBooks = [];
  final cloudStoreHelper = CloudStoreHelper();

  @override
  void initState() {
    super.initState();
    cloudStoreHelper.getAllBooks().then((value) {
      listOfBooks = value;
      inProgress = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book list'),
      ),
      body: Visibility(
        visible: inProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: listOfBooks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listOfBooks[index].name),
              trailing: Text(listOfBooks[index].category),
              subtitle: Text(listOfBooks[index].date),
              leading: Text(listOfBooks[index].price.toString()),
            );
          },
        ),
      ),
    );
  }
}
