class Book {
  String isbn;
  String title;
  Book(this.isbn, this.title);

  @override
  String toString() => 'Book{isbn: $isbn, title: $title}';
}

// Abstract class (used as an interface in Dart)
abstract class BookRepository {
  // Abstract methods
  Book getBook(String isbn);
  void addBook(Book book);
}

// Implementation of BookRepository using a File system (like a FileBookRepository in Kotlin)
class FileBookRepository implements BookRepository {
  @override
  Book getBook(String isbn) {
    // Logic for retrieving a book from a file would go here
    return Book('1234', 'Dart Programming');
  }

  @override
  void addBook(Book book) {
    // Logic for adding a book to a file would go here
  }
}

// Implementation of BookRepository using a Database (like a DBBookRepository in Kotlin)
class DBBookRepository implements BookRepository {
  @override
  Book getBook(String isbn) {
    // Logic for retrieving a book from a database would go here
    return Book('1234', 'Dart Programming');
  }

  @override
  void addBook(Book book) {
    // Logic for adding a book to a database would go here
  }
}

void main() {
  // Polymorphism: BookRepository can be either FileBookRepository or DBBookRepository
  BookRepository bookRepository = DBBookRepository(); 
  
  // Accessing the getBook method
  var book = bookRepository.getBook("1234");
  print(book);
}
