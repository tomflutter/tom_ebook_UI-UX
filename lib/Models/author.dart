class AuthorModel {
  String? status;
  String? message;
  String? response;

  static List<AuthorItem> list = [];

  AuthorModel.getuserid(dynamic obj) {
    list = obj
        .map<AuthorItem>((jsonMapMap) => new AuthorItem.fromJsonMap(jsonMapMap))
        .toList();
  }
}

class AuthorItem {
  String? authorId;
  String? authorName;
  String? authorImage;
  String? authorStatus;
  DateTime? createdDate;
  int? books;

  AuthorItem({
    this.authorId,
    this.authorName,
    this.authorImage,
    this.authorStatus,
    this.createdDate,
    this.books,
  });

  factory AuthorItem.fromJsonMap(Map<String, dynamic> jsonMap) {
    return AuthorItem(
      authorId: jsonMap["author_id"],
      authorName: jsonMap["author_name"],
      authorImage: jsonMap["author_image"],
      authorStatus: jsonMap["author_status"],
      createdDate: DateTime.parse(jsonMap["created_date"]),
      books: jsonMap["books"],
    );
  }
}
