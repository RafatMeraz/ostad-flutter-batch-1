import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ostad_flutter_batch_one/book.dart';

class CloudStoreHelper {
  final db = FirebaseFirestore.instance;

  Future<List<Book>> getAllBooks() async {
    List<Book> listOfBooks = [];
    final result = await db.collection('books').get();
    for (var element in result.docs) {
      Book book = Book(
        element.get('name'),
        element.get('type'),
        element.get('date').toString(),
        double.tryParse(element.get('price').toString()) ?? 0,
      );
      listOfBooks.add(book);
    }
    return listOfBooks;
  }
}
