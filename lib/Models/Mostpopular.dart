class MostPopularModel {
  String? status;
  String? message;
  String? response;

  static List<MostPopularItem> list = [];

  MostPopularModel.getuserid(dynamic obj) {
    list = obj
        .map<MostPopularItem>(
            (jsonMap) => new MostPopularItem.fromJson(jsonMap))
        .toList();
  }
}

class MostPopularItem {
  String? bookId;
  String? categoryId;
  String? authorId;
  String? bookTitle;
  String? bookDescription;
  String? bookPreview;
  String? bookPdf;
  String? bookSize;
  String? bookPages;
  String? bookStatus;
  DateTime? createdDate;
  String? categoryName;
  String? bookRead;
  String? authorName;
  String? rate;

  MostPopularItem({
    this.bookId,
    this.categoryId,
    this.authorId,
    this.bookTitle,
    this.bookDescription,
    this.bookPreview,
    this.bookPdf,
    this.bookSize,
    this.bookPages,
    this.bookStatus,
    this.createdDate,
    this.categoryName,
    this.bookRead,
    this.authorName,
    this.rate,
  });

  factory MostPopularItem.fromJson(Map<String, dynamic> jsonMap) {
    return MostPopularItem(
      bookId: jsonMap["book_id"],
      categoryId: jsonMap["category_id"],
      authorId: jsonMap["author_id"],
      bookTitle: jsonMap["book_title"],
      bookDescription: jsonMap["book_description"],
      bookPreview: jsonMap["book_preview"],
      bookPdf: jsonMap["book_pdf"],
      bookSize: jsonMap["book_size"],
      bookPages: jsonMap["book_pages"],
      bookStatus: jsonMap["book_status"],
      createdDate: DateTime.parse(jsonMap["created_date"]),
      categoryName: jsonMap["category_name"],
      bookRead: jsonMap["book_read"],
      authorName: jsonMap["author_name"],
      rate: jsonMap["rate"],
    );
  }
}
