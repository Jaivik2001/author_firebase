class AuthorModel {
  String? author;
  String? book;

  AuthorModel({required this.author, required this.book });

  AuthorModel.fromMap(Map<String, dynamic> map) {
    author = map[author];
    book = map[book];
  }

  Map<String, dynamic> toMap() => {
    'author': author,
    'book': book,
  };
}