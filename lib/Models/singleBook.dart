class SingleBookModel {
  String? status;
  String? message;
  String? response;

  static List<SingleBookItem> list = [];

  SingleBookModel.getuserid(dynamic obj) {
    list = obj
        .map<SingleBookItem>((jsonMap) => new SingleBookItem.fromJson(jsonMap))
        .toList();
  }
}

class SingleBookItem {
  String? categoryId;
  String? categoryName;
  String? bookPreview;
  String? link;
  String? bookSize;
  dynamic bookPages;
  String? authorName;
  String? bookDescription;
  int? isFavourite;

  SingleBookItem({
    this.categoryId,
    this.categoryName,
    this.bookPreview,
    this.link,
    this.bookSize,
    this.bookPages,
    this.authorName,
    this.bookDescription,
    this.isFavourite,
  });

  factory SingleBookItem.fromJson(Map<String, dynamic> jsonMap) {
    return SingleBookItem(
      categoryId: jsonMap["category_id"],
      categoryName: jsonMap["category_name"],
      bookPreview: jsonMap["book_preview"],
      link: jsonMap["link"],
      bookSize: jsonMap["book_size"],
      bookPages: jsonMap["book_pages"],
      authorName: jsonMap["author_name"],
      bookDescription: jsonMap["book_description"],
      isFavourite: jsonMap["is_favourite"],
    );
  }
}
