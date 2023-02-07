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
  final TextEditingController nameETController = TextEditingController();
  final TextEditingController priceETController = TextEditingController();
  final TextEditingController typeETController = TextEditingController();
  final TextEditingController dateETController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // cloudStoreHelper.getAllBooks().then((value) {
    //   listOfBooks = value;
    //   inProgress = false;
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book list'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text('Add new book'),
                        const SizedBox(height: 20),
                        TextField(
                          controller: nameETController,
                          decoration: const InputDecoration(hintText: 'Name'),
                        ),
                        TextField(
                          controller: priceETController,
                          decoration: const InputDecoration(hintText: 'Price'),
                        ),
                        TextField(
                          controller: typeETController,
                          decoration: const InputDecoration(hintText: 'Type'),
                        ),
                        TextField(
                          controller: dateETController,
                          decoration: const InputDecoration(hintText: 'Date'),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              Book book = Book(
                                  nameETController.text,
                                  typeETController.text,
                                  dateETController.text,
                                  double.tryParse(priceETController.text) ?? 0);
                              await cloudStoreHelper.addNewBook(book).then(
                                (value) {
                                  nameETController.clear();
                                  priceETController.clear();
                                  dateETController.clear();
                                  typeETController.clear();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('New Book Added')));
                                },
                              );
                            },
                            child: const Text('Add'))
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: cloudStoreHelper.listenAllBooksCollection(),
        builder: (context, snapshot) {
          /// in progress
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// error state
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            listOfBooks.clear();
            for (var element in snapshot.data!.docs) {
              Book book = Book(
                element.get('name'),
                element.get('type'),
                element.get('date').toString(),
                double.tryParse(element.get('price').toString()) ?? 0,
              );
              listOfBooks.add(book);
            }
            return ListView.builder(
              itemCount: listOfBooks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listOfBooks[index].name),
                  trailing: Text(listOfBooks[index].category),
                  subtitle: Text(listOfBooks[index].date),
                  leading: Text(listOfBooks[index].price.toString()),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
