class ContinueReadingModel {
  String? status;
  String? message;
  String? response;

  static List<ContinueReadingItem> list = [];

  ContinueReadingModel.getuserid(dynamic obj) {
    list = obj
        .map<ContinueReadingItem>(
            (jsonMap) => new ContinueReadingItem.fromJson(jsonMap))
        .toList();
  }
}

class ContinueReadingItem {
  String? bookId;
  String? bookTitle;
  String? bookDescription;
  String? bookPreview;
  String? pdf;
  String? categoryId;
  String? categoryName;
  String? authorName;
  int? isFavourite;
  String? rate;

  ContinueReadingItem({
    this.bookId,
    this.bookTitle,
    this.bookDescription,
    this.bookPreview,
    this.pdf,
    this.categoryId,
    this.categoryName,
    this.authorName,
    this.isFavourite,
    this.rate,
  });

  factory ContinueReadingItem.fromJson(Map<String, dynamic> jsonMap) {
    return ContinueReadingItem(
      bookId: jsonMap["book_id"],
      bookTitle: jsonMap["book_title"],
      bookDescription: jsonMap["book_description"],
      bookPreview: jsonMap["book_preview"],
      pdf: jsonMap["pdf"],
      categoryId: jsonMap["category_id"],
      categoryName: jsonMap["category_name"],
      authorName: jsonMap["author_name"],
      isFavourite: jsonMap["is_favourite"],
      rate: jsonMap["rate"],
    );
  }
}
