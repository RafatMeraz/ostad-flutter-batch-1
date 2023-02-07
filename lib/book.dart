class Book {
  final String name, category, date;
  final double price;

  Book(this.name, this.category, this.date, this.price);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['price'] = price;
    map['type'] = category;
    map['date'] = date;
    return map;
  }
}
