class CommentsModel {
  String? status;
  String? message;
  String? response;

  static List<CommentsItem> list = [];

  CommentsModel.getuserid(dynamic obj) {
    list = obj
        .map<CommentsItem>(
            (jsonMapMap) => new CommentsItem.fromJsonMap(jsonMapMap))
        .toList();
  }
}

class CommentsItem {
  String? commentId;
  String? comment;
  String? userName;

  CommentsItem({
    this.commentId,
    this.comment,
    this.userName,
  });

  factory CommentsItem.fromJsonMap(Map<String, dynamic> jsonMap) {
    return CommentsItem(
      commentId: jsonMap["comment_id"],
      comment: jsonMap["comment"],
      userName: jsonMap["user_name"],
    );
  }
}
