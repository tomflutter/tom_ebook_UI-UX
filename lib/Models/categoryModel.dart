class CategoryModel {
  String? status;
  String? message;
  String? response;

  static List<CategoryItem> list = [];

  CategoryModel.getuserid(dynamic obj) {
    list = obj
        .map<CategoryItem>(
            (jsonMapMap) => new CategoryItem.fromJsonMap(jsonMapMap))
        .toList();
  }
}

class CategoryItem {
  String? categoryId;
  String? categoryName;
  String? categoryImage;
  String? categoryStatus;
  DateTime? createdDate;
  int? books;

  CategoryItem({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.categoryStatus,
    this.createdDate,
    this.books,
  });

  factory CategoryItem.fromJsonMap(Map<String, dynamic> jsonMap) {
    return CategoryItem(
      categoryId: jsonMap["category_id"],
      categoryName: jsonMap["category_name"],
      categoryImage: jsonMap["category_image"],
      categoryStatus: jsonMap["category_status"],
      createdDate: DateTime.parse(jsonMap["created_date"]),
      books: jsonMap["books"],
    );
  }
}
