class Book {
  final int id;
  final int userId;
  final String isbn;
  final String title;
  final String subtitle;
  final String author;
  final String published;
  final String publisher;
  final int pages;
  final String description;
  final String website;

  Book(this.id, this.userId, this.isbn, this.title, this.subtitle,
      this.author, this.published, this.publisher, this.pages,
      this.description, this.website);

  factory Book.fromMap(Map<String, dynamic> bookMap) {
    return Book(bookMap["id"], bookMap["user_id"], bookMap["isbn"], bookMap["title"],
        bookMap["subtitle"], bookMap["author"], bookMap["published"], bookMap["publisher"],
        bookMap["pages"], bookMap["description"], bookMap["website"]);
  }
}