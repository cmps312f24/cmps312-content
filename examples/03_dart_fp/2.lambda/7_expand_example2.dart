void main() {
  List<Book> books = [
    Book("Head First Dart", ["Dawn Griffiths", "David Griffiths"]),
    Book("Dart in Action", ["Dmitry Jemerov", "Svetlana Isakova"]),
  ];

  // Flattening the list of authors
  var authors = books.expand((book) => book.authors).toList();

  print(authors);
}

class Book {
  String title;
  List<String> authors;

  Book(this.title, this.authors);
}
